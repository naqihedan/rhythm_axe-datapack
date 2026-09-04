# 活跃音符处理（每刻对已生成音符执行）
# M2-A：移动（交互实体跟随展示实体视觉位置）
# M2-B：寿命递减（note_life 每刻 -1）
# M2-C：音符盒判定（视线检测 + 判定保护）
# M2-D：木板判定（简化版音符盒：无 bad/miss，全转大P）
# 后续里程碑：其他类型判定 / 反馈组表 / 出窗

# 视线标记清理：looked_at（实际判定，由 judgement/judgement 用 looking_at 打）与
#   looked_at_perfect（判定保护，由射线步进 raycast 打）每 tick 先清再重新打
#   （display 的 looked_at 供唱片机视线兜底 jukebox_late 用，也一并清理）
tag @e[type=interaction,tag=note_interaction] remove looked_at
tag @e[type=interaction,tag=note_interaction] remove looked_at_perfect
tag @e[type=item_display,tag=note_display] remove looked_at
function rhythm_axe:play/active_note/raycast

# 染色玻璃扣血冷却递减（M2-G；>0 时每刻 -1，=0 时碰撞可再次扣血）
execute if score damage_cooldown play_state matches 1.. run scoreboard players remove damage_cooldown play_state 1

# 寿命递减：仅在 note_active=1 时递减（避免出生 tick 立即递减导致判定时刻偏差 1 tick）
scoreboard players remove @e[type=interaction,tag=note_interaction,scores={note_active=1}] note_life 1
# 出生 tick 后标记活跃（下 tick 起递减）
scoreboard players set @e[type=interaction,tag=note_interaction,scores={note_active=0}] note_active 1
# 混凝土展示实体寿命同步递减 + active 翻转（concrete/tick 用 note_life；2026-08-09 回退：混凝土不走客户端插值）
scoreboard players remove @e[type=item_display,tag=note_display,tag=note_concrete,scores={note_active=1}] note_life 1
scoreboard players set @e[type=item_display,tag=note_display,tag=note_concrete,scores={note_active=0}] note_active 1
# 非线性玻璃展示实体寿命同步递减 + active 翻转（glass/tick 用 note_life）
#   ★ 线性玻璃（note_linear_pending / note_linear）不进这里：active 由下方 ② 管理，进度用 note_lin_t
scoreboard players remove @e[type=item_display,tag=note_display,tag=note_stained_glass,tag=!note_linear,scores={note_active=1}] note_life 1
scoreboard players set @e[type=item_display,tag=note_display,tag=note_stained_glass,tag=!note_linear_pending,tag=!note_linear,scores={note_active=0}] note_active 1
# ===== 线性插值启动（普通 0/1/2 + 玻璃 4 统一；★ 2026-08-27 重写：真实 3 tick 延迟）=====
#   ★ 根因复盘（只看代码）：原 0→-1→1 / 0→-1→-2→1 链式 set 会在【同一 tick】内全部执行
#     （每条 set 的 selector 会命中上一条刚写入的值）→ 出生 tick 当刻 active 就到 1，次 tick 即 motion/start，
#     实际"出生→终点"只隔 1 tick（注释/文档声称 2~3 tick，但代码从未做到）。
#     1 tick 间隔下，客户端一帧覆盖 2 个服务端刻即触发"插值起点丢失"（用户实测很多音符停在判定位置）。
#   ★ 正确做法 = 计数递增 + 消费优先：
#     - ① 每 tick 先消费 active=4 的 pending → motion/start（参数+终点同刻）+ 转 note_linear + 清 pending；
#     - ② 再对【仍带 pending】的实体 note_active +1（已消费的已移除 pending，不会被 +1）。
#       消费先于递增、且递增不命中已消费实体 → 绝不会同 tick 链式推进。
#     出生 tick 计 0 → 0→1→2→3→4 用满 4 tick，第 5 tick 才被 ① 消费 → 出生→终点真正隔 4 tick（间隔 3 刻）。
#     插值时长 D 已同步 -2（summon：#m_dur 普通=lt-4、玻璃=lt+dur-4）→ 间隔 + D 恒定 → 视觉到位仍落节拍。
#   ★ 为什么隔 4 tick（间隔 3 刻）：客户端某帧耗时 ≥2 服务端刻时服务端会在一个客户端刻内补跑 2 刻，
#     出生包与终点包同帧消费 → 新实体从未渲染出生状态 → 插值起点丢失 → 永久停在终点（判定位置）。
#     隔 4 tick 需帧耗时 ≥5 个服务端刻才触发（原 1 tick 间隔需 ≥2 刻 → 极易触发，这就是"很多卡住"的根因）。
#   ★ 插值参数（duration/start）与终点【同一刻】下发（wiki：同刻多次变更计为单个变更），
#     插值时钟从终点到达时才开始 → 无起步前跳。
#   ★ 混凝土不走此链（客户端插值三段见 play/note/concrete/*；其 armed→promote→pending 链同样偏短，见 concrete/seg1_*）
# ① 消费 active=4 的 pending → motion/start
execute as @e[type=item_display,tag=note_linear_pending,scores={note_active=4}] run function rhythm_axe:play/note/motion/start
# ★ 先 add 再 remove（同一选择器先 remove 后 add 会匹配不到实体 → note_linear 打不上 → move 走 unless 分支读恒值 note_cur_tz → 交互实体停出生位置）
execute as @e[type=item_display,tag=note_linear_pending,scores={note_active=4}] run tag @s add note_linear
tag @e[type=item_display,tag=note_linear_pending,scores={note_active=4}] remove note_linear_pending
# ★ 2026-09-04 不再用 active=3 恢复 size：改用 item=air 隐藏（summon 暂存 item 到 note_show、item 设 air；
#   motion/start 恢复 item=方块）。scale 全程恒定 size，仅 item 切换，不会触发 scale 插值放大。
#   note_linear_pending 只负责计数（active 0→1→2→3→4），active=4 才由 ① 消费 → motion/start 开始平移。
# ② 每 tick 所有仍未消费的 pending 计数 +1（出生 tick 0→1，隔 4 tick 后到 4 被 ① 消费）
scoreboard players add @e[type=item_display,tag=note_linear_pending] note_active 1
# 线性插值进度 +1（move 算交互位置用；merge 终点当 tick 起=1 → 交互实体滞后 1 tick 对齐客户端渲染延迟）
# ★ 性能优化（2026-09-04，O(N²) 消除）：交互实体也带 note_linear，同刻递增 note_lin_t，
#   使 move_self 可用"note_lin_t-1"复现"上一刻视觉位置"（与 move 写 #pvx 的解耦延迟一致）。
scoreboard players add @e[type=item_display,tag=note_linear] note_lin_t 1
scoreboard players add @e[type=interaction,tag=note_linear] note_lin_t 1
# ★ 性能优化（2026-09-04，O(N²) 消除）：玻璃中心 marker（仅线性，start 已打 note_linear）也同步递增 note_lin_t，
#   供 marker_self 自算扫掠段。非线性玻璃 marker 无 note_lin_t，走 move 的旧扫描（见 move），故排除。
scoreboard players add @e[type=marker,tag=note_glass_center,tag=note_linear] note_lin_t 1
# 展示实体统一处理（★ 合并遍历 2026-08-09）：混凝土段推进 + 玻璃段推进 + move 一次遍历完成
#   内部顺序：先驱动（写 NBT 视觉位置）再 move（读 NBT 存 note_prev_*），与原一致
execute as @e[type=item_display,tag=note_display] at @s run function rhythm_axe:play/active_note/display_tick

# 音符间引导线每刻更新（读两端音符展示实体 note_prev_* → 更新自身中点/朝向/长度）
execute as @e[type=item_display,tag=note_guide] at @s run function rhythm_axe:play/note/guide/tick

# M2-C/D/E/F：交互实体统一判定（★ 合并遍历 2026-08-09：noteblock/plank/jukebox/concrete 一次遍历分流）
# ★ 性能优化（2026-09-04）：判定窗口上界 3x+1 = #proto_high 在此全局算一次（interact_judge 读取），
#   供 judgement/main_plank 的窗口门控（寿命 > 3x+1 时音符仍在飞向判定位置，无需判定）。
scoreboard players operation #proto_high play_state = #judgement_scale play_state
scoreboard players operation #proto_high play_state *= 3 const
scoreboard players add #proto_high play_state 1
# ★ 性能优化（2026-09-04，O(N²) 消除）：线性音符交互实体位置在此单独遍历自算（move_self），
#   必须在 interact_judge（其 at @s 会捕获进入时的位置）之前，保证 looking_at 判定位置正确。
#   ★ 2026-09-04 恢复玻璃：玻璃交互实体位置虽不参与判定（玻璃走中心 marker 的 glass_sweep 碰撞），
#     但扣血反馈（damage_feedback → feedback）以交互实体位置 at @s 播放音效/粒子，故玻璃交互实体也须
#     跟随视觉位置（之前排除导致反馈播在出生位置，玩家看不到/听不到）。每玻璃多 ~30 条命令，可接受。
execute as @e[type=interaction,tag=note_linear] run function rhythm_axe:play/active_note/move_self
execute as @e[type=interaction,tag=note_interaction] at @s run function rhythm_axe:play/active_note/interact_judge

# ★ 2026-08-29 spawn / tick 事件：
#   spawn 事件在"开始移动"那一刻执行一次（note_spawn_delay 递减归 0 且 note_moving=0 时触发；
#   随后 spawn_delayed 置 note_moving=1、note_spawn_delay=-1 防每刻重放）
#   tick 事件在开始运动后每一刻执行一次（note_moving=1，与 spawn 同条件机制）
scoreboard players remove @e[type=interaction,tag=note_interaction,scores={note_spawn_delay=1..}] note_spawn_delay 1
execute as @e[type=interaction,tag=note_interaction,scores={note_spawn_delay=0}] if score @s note_moving matches 0 at @s run function rhythm_axe:play/feedback/spawn_delayed
execute as @e[type=interaction,tag=note_interaction,scores={note_moving=1}] at @s run function rhythm_axe:play/feedback/tick_event

# M2-G：染色玻璃碰撞判定（“玩家判定箱包含玻璃中心” → 扣血 + 进入冷却；damage 内部处理冷却检查）
# ★ 扫掠采样（CCD，2026-08-07）：玻璃移动是离散的，若每刻位移 > 玩家判定箱宽 0.6 格会“隧穿”
#   （两个采样时刻都在玩家箱外，但中间路径穿过玩家箱 → 视觉撞上却无判定）。
#   解决：沿“上一刻中心 → 当前中心”线段按 0.5 格步长采样多个点，每点做对角区域点检测。
#   玻璃 marker 位置 = 上一刻中心，note_prev_* = 当前中心（move 记录）
#   Java 1.19.70+ dx/dy/dz = 判定箱相交
# ★ 距离过滤（2026-08-09）：仅玩家 6 格内才扫掠——远离玩家的玻璃中心不可能与玩家判定箱相交，
#   直接跳过整段扫掠（省每 tick 对远处 marker 的 CCD 采样）
#   ★ 性能优化（2026-09-04）：6 格 → 4 格。玩家判定箱仅 0.6 格宽，玻璃中心距玩家 >4 格且每刻位移 <=4 格
#   时，其扫掠段不可能触及玩家判定箱；收紧门控减少每刻判定的玻璃 marker 数（玻璃为主谱面的大头）。
# ★ 性能优化（2026-09-04，O(N²) 消除）：玻璃中心 marker（仅线性）在此自算扫掠段（起点=上上一刻中心
#   P(T-2)、终点=上一刻中心 P(T-1)），替代原 move 的"每展示实体全量扫描 marker"O(N²)；必须在 glass_sweep
#   之前（sweep 读 marker 的 Pos/note_prev_*）。非线性玻璃 marker 走 move 的旧扫描，故排除。
execute as @e[type=marker,tag=note_glass_center,tag=note_linear] run function rhythm_axe:play/active_note/marker_self
# ★ 自动模式（2026-08-09）：auto=1 玩家不判定玻璃（不会产生 damage），直接短路不扫掠（省全部 CCD）
execute if score auto play_state matches 0 as @e[type=marker,tag=note_glass_center] at @s if entity @a[distance=..4] run function rhythm_axe:play/active_note/glass_sweep

# M2-C/D：全局出窗检测——所有音符寿命越过 goodL 末刻（< -2x）且未判定
# 音符盒等 → miss；木板/染色玻璃 → 静默清除（无 miss）；混凝土 → 跳过（尾未到判定位置，另有出窗）
# ★ 必须有 at @s：playsound/particle 的 ~ ~ ~ 相对执行位置而非执行者；无 at @s 时在 tick 函数
#   执行位置（世界原点）播放 → 玩家听不到 miss 音效（唱片机/混凝土路径均带 at @s，故正常）
# ★ 自动模式（2026-08-09）：auto 下普通音符/木板在寿命=0 已由 auto_note 判大P并 kill，
#   出窗补判兜底也在 auto_note（寿命< -2x 补判大P）→ 这里 miss/清除必须短路，避免漏判/误清
# 先算 -2x
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
execute if score auto play_state matches 0 as @e[type=interaction,tag=note_interaction] at @s if score @s note_life < #tn2 play_state unless entity @s[tag=note_plank] unless entity @s[tag=note_concrete] unless entity @s[tag=note_stained_glass] run scoreboard players set #judge_life play_state -999
execute if score auto play_state matches 0 as @e[type=interaction,tag=note_interaction] at @s if score @s note_life < #tn2 play_state unless entity @s[tag=note_plank] unless entity @s[tag=note_concrete] unless entity @s[tag=note_stained_glass] run function rhythm_axe:play/judgement/judge
execute if score auto play_state matches 0 as @e[type=interaction,tag=note_interaction] at @s if score @s note_life < #tn2 play_state if entity @s[tag=note_plank] run function rhythm_axe:play/judgement/clear_note
# 混凝土出窗：寿命 ≤ -duration（所有段落已过）→ 静默清除
# （不再用 -m：duration 可能大于 note_base_life，段落要判到 -duration 才结束）
# ★ 必须在单实体函数内计算 #neg_dur：as @e 循环里 *= -1 会对全局变量重复取反
#   （偶数个混凝土共存 → #neg_dur 变正 → 出生即清除）。见 concrete_windowout
execute as @e[type=interaction,tag=note_interaction,tag=note_concrete] run function rhythm_axe:play/judgement/concrete_windowout
# 染色玻璃出窗：寿命 + duration <= 0 → 静默清除（单实体函数算 -duration）
execute as @e[type=interaction,tag=note_interaction,tag=note_stained_glass] run function rhythm_axe:play/judgement/glass_windowout
