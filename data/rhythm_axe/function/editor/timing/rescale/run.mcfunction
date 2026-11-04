# 时间点改 tpb 后：保持谱面内容在音乐中的位置不变（段内按比例缩放 + 其后整体平移）
#
# 前置 prop.rescale（由调用方捕获）：a / b（可缺）/ bpm_old / tpb_old / bpm_new / tpb_new
#
# 语义 —— ratio = (bpm_new × tpb_new) / (bpm_old × tpb_old)：
#   t <  a      → t                                             （段前不动）
#   a ≤ t < b   → a + round((t − a) × ratio)                     （段内按比例缩放，锚 = a）
#   t ≥  b      → t + delta，delta = a + round((b−a)×ratio) − b  （段后整体平移）
# ★ 为什么段后是「平移」而不是「再缩放」：tick rate 逐段独立设置，段 A 的刻数 ×ratio 后
#   现实时长恰好不变 ⇒ 只要把边界 b 挪到新位置，段 B 及其后的**刻坐标**整体平移同样多，
#   它们的现实时间（相对 b）就完全不变。若对段后再乘 ratio 就是二次错位。
# ★ f 单调不减 ⇒ notes[] 缩放后仍按 time 升序，**不需要重排**（绕开 order_repair 的 O(N²)）。
# ★ 只在 tpb 变化时补偿：改 bpm 属于「有意改节奏映射」，补偿会误伤。
#
# ★★ 分刻（2026-10-29 起，遵循《命令链与「分刻」政策》）：
#   逐音符 = O(N) 次宏展开 + NBT 读写；几千音符同刻会撞命令链，而截断发生在**尾部**
#   ⇒ 静默只改一半（比"全都没改"更危险）。所以遍历一律按 CHUNK 分刻。
#
# ★★ 调用约定：一旦确认要缩放，本链路就**接管 commit 与 refresh**（收尾见 rescale/finish_next）；
#   因为遍历跨 tick，调用方不能在 run 返回后立刻 commit。调用方写法：
#     function rhythm_axe:editor/timing/rescale/run
#     execute unless score #rs_own editor matches 1 run function rhythm_axe:editor/file/commit
#     execute unless score #rs_own editor matches 1 run function rhythm_axe:editor/timing/rescale/refresh_guard
#   #rs_own = 1 表示本链路已接管；比值=1 / 开关全关 / 非法值 时为 0，调用方按原逻辑收尾。

scoreboard players set #rs_own editor 0

# ★ 先清掉上一次可能残留的运行期状态（2026-10-29）：
#   若上一次缩放被中途打断（reload / 撤销 / 异常），prop.rescale 与 rescale.active 会留在
#   storage 里；后续任何一次 `rescale/run` 都会拿它当有效上下文 → 用过期参数重跑一遍。
#   必须先清干净，再由调用方重新注入本次上下文。
execute if data storage rhythm_axe:maps.editor rescale.active run data remove storage rhythm_axe:prop rescale
execute if data storage rhythm_axe:maps.editor rescale.active run data remove storage rhythm_axe:maps.editor rescale
execute if data storage rhythm_axe:maps.editor rescale.active run scoreboard players set #rs_i editor 0
execute if data storage rhythm_axe:maps.editor rescale.active run scoreboard players set #rs_chunk editor 0
execute if data storage rhythm_axe:maps.editor rescale.active run scoreboard players set #rs_phase editor -1

# 无上下文（不是时间点确认路径）→ 静默返回
execute unless data storage rhythm_axe:prop rescale run return 0
# 四个开关全关 → 无事可做
scoreboard players set #rs_any editor 0
execute if score editor_scale_time options matches 1 run scoreboard players set #rs_any editor 1
execute if score editor_scale_hold options matches 1 run scoreboard players set #rs_any editor 1
execute if score editor_scale_life options matches 1 run scoreboard players set #rs_any editor 1
execute if score editor_scale_event options matches 1 run scoreboard players set #rs_any editor 1
execute if score #rs_any editor matches 0 run data remove storage rhythm_axe:prop rescale
execute if score #rs_any editor matches 0 run return 0

# 读旧/新 tpb；未变 → 不补偿（改 bpm / bpb / judgement_scale 都不缩放）
execute store result score #rs_told editor run data get storage rhythm_axe:prop rescale.tpb_old
execute store result score #rs_tnew editor run data get storage rhythm_axe:prop rescale.tpb_new
execute if score #rs_told editor = #rs_tnew editor run data remove storage rhythm_axe:prop rescale
execute if score #rs_told editor = #rs_tnew editor run return 0

# 比值 = 新 tps / 旧 tps（tps = bpm × tpb；bpm 取 ×1000 定标保留三位小数）
execute store result score #rs_bold editor run data get storage rhythm_axe:prop rescale.bpm_old 1000
execute store result score #rs_bnew editor run data get storage rhythm_axe:prop rescale.bpm_new 1000
scoreboard players operation #rs_den editor = #rs_bold editor
scoreboard players operation #rs_den editor *= #rs_told editor
scoreboard players operation #rs_num editor = #rs_bnew editor
scoreboard players operation #rs_num editor *= #rs_tnew editor
# 非法值（bpm ≤ 0 / 读失败）→ 放弃，绝不写坏数据
execute if score #rs_den editor matches ..0 run data remove storage rhythm_axe:prop rescale
execute if score #rs_den editor matches ..0 run return 0
execute if score #rs_num editor matches ..0 run data remove storage rhythm_axe:prop rescale
execute if score #rs_num editor matches ..0 run return 0
# 约分（num/den 原始值可能上百万，见 scale 的溢出说明）
function rhythm_axe:editor/timing/rescale/gcd
# 比值 1 → 无需缩放
execute if score #rs_num editor = #rs_den editor run data remove storage rhythm_axe:prop rescale
execute if score #rs_num editor = #rs_den editor run return 0

# ── 到这里确认要缩放 ⇒ 接管 commit / refresh ──
scoreboard players set #rs_own editor 1

# 段起点 a / 下一个点 b / delta
execute store result score #rs_a editor run data get storage rhythm_axe:prop rescale.a
scoreboard players set #rs_has_b editor 0
execute if data storage rhythm_axe:prop rescale.b run scoreboard players set #rs_has_b editor 1
execute if score #rs_has_b editor matches 1 run execute store result score #rs_b editor run data get storage rhythm_axe:prop rescale.b
# delta = a + round((b−a)×ratio) − b（b 不存在时用不到）
scoreboard players set #rs_delta editor 0
execute if score #rs_has_b editor matches 1 run scoreboard players operation #rs_off editor = #rs_b editor
execute if score #rs_has_b editor matches 1 run scoreboard players operation #rs_off editor -= #rs_a editor
execute if score #rs_has_b editor matches 1 run function rhythm_axe:editor/timing/rescale/scale
execute if score #rs_has_b editor matches 1 run scoreboard players operation #rs_delta editor = #rs_out editor
execute if score #rs_has_b editor matches 1 run scoreboard players operation #rs_delta editor += #rs_a editor
execute if score #rs_has_b editor matches 1 run scoreboard players operation #rs_delta editor -= #rs_b editor

# ── 遍历进度初始化 ──
# 每刻额度 64 由 *_drive 里的**字面量**控制（不存计分板：未赋值的变量在 `>=` 比较里按 0 算，
# 会让「额度用满」恒真 → 每刻都只 schedule 不干活 → 死循环。实测踩过，#rs_i 涨到 9 万）。
scoreboard players set #rs_rounds editor 0
scoreboard players set #rs_count editor 0
scoreboard players set #rs_ev editor 0
scoreboard players set #rs_phase editor 0
scoreboard players set #rs_i editor 0
scoreboard players set #rs_chunk editor 0
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# ★ cursor 冗余备份（2026-10-29 根治死循环）：resume / *_drive 每轮都从
#   prop.rescale.cursor 重建 prop.cursor —— 否则调用方收尾删了 prop.cursor 之后，
#   notes_leaf 的 `with storage` 宏实例化失败 → #rs_done 永远 0 → #rs_i 无限增长。
data modify storage rhythm_axe:prop rescale.cursor set from storage rhythm_axe:maps.editor history_cursor
# ★ 遍历期间锁编辑器（editor/menu/consume 顶部会拦）：跨 tick 时若别的操作插进来改 notes，
#   下标会漂移 ⇒ 漏改/错改。收尾在 rescale/finish_next 里清掉。
data modify storage rhythm_axe:maps.editor rescale.active set value 1b
# 开始遍历（小谱面几刻内自然跑完，不产生可见延迟）
function rhythm_axe:editor/timing/rescale/notes_drive
