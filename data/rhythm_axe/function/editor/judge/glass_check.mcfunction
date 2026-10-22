# 编辑器真实判定：染色玻璃（4）（@s = 玻璃展示实体；at @s 由 tick_one 保证）
# 照搬游玩 glass_sweep（CCD 扫掠）：判定 = 玻璃「中心 0.5³ 方块」∩「玩家判定箱」。
#   玻璃每刻位移可能 > 玩家判定箱宽 0.6 格 ⇒ 沿「上一刻中心 → 当前中心」线段按 1.0 格步长采样，任一点命中即算撞到。
# 与游玩的实现差异：
#   ① 中心轨迹不用 marker、也不借交互实体：直接用【玻璃展示实体自身】做锚——
#      Pos 恒 = 判定位置（中心高度，y 无偏移）、Rotation = 运动方向、translation[2] = 局部 z（= 当前偏移）。
#      ★ 2026-10-21 重写：旧版把采样点坐标写进配对交互实体 Pos 承载（execute positioned 不能吃动态计分板坐标），
#        但采样循环后不归还 ⇒ 交互实体永久停在采样点（= 玻璃中心，比正确位置高 size/2）→ 判定箱不再套住展示实体。
#        症状：只有玩家 4 格内的玻璃会犯（4 格门控才进采样循环），暂停/停止后位置永久错。
#      现改为【宏注入起点 + 字面量 ^ ^ ^1 步进】：交互实体自始至终不被触碰。
#   ② 扫掠段 = [P(T-1), P(T)]（局部 z 历史 editor_n_ptz/editor_n_p2tz，由 place 每刻滚动）。
# ★ 不进 trigger_/play_sound/play_particle（三者都有「玻璃零反馈」防线），反馈走 visual/glass_feedback。
# ★ 不扣血、不计成绩；重复命中用 options.damage_cooldown 做冷却（与游玩同款节奏）。
# 前置：实体计分板 editor_n_ptz/editor_n_p2tz（局部 z×100）、note_id；玩家级冷却 #ed_g_cd（editor 假玩家）

# ===== 冷却说明 =====
# 与游玩同款【玩家级单一冷却】#ed_g_cd（editor 假玩家）：由 visual/tick 每刻递减一次。
# 本文件不做每实体递减 —— 那会按玻璃数量放大递减速度。
# （冷却递减已上移到 visual/tick）

# ===== 扫掠段端点：局部 z（×100）=====
# tz_end = 当前局部 z（place 刚写进 translation[2]）
# tz_start = 上一刻局部 z = 实体计分板 editor_n_ptz（本函数末尾回写，形成历史）
#   ⇒ 扫掠段 = [P(T-1), P(T)]，与旧版 [editor_n_vv, editor_n_v] 完全同段
# ★ 提前回写（存当前 → 供下刻当起点）：放在最前，使后面所有 early-return 路径都不会断历史
execute store result score #gsc_tze editor run data get entity @s transformation.translation[2] 100
# 哨兵兜底：editor_n_ptz 未赋值（旧实体 / 未走 fill_disp 的异常路径）→ 用当前 tz 初始化（d=0，只测当前点）
execute unless score @s editor_n_ptz matches -2147483648.. run scoreboard players operation @s editor_n_ptz = #gsc_tze editor
scoreboard players operation #gsc_tzs editor = @s editor_n_ptz
scoreboard players operation @s editor_n_ptz = #gsc_tze editor

# ===== 段长 d = |tz_end − tz_start|（×100，沿运动方向标量）=====
# ★ 跳转保护（同旧版）：单轴位移 > 25 格（刚出生/seek 跳转）⇒ 只测当前点（起=终、d=0）
#   —— 沿路径的标量差，只需一次比较（比旧版三轴 d² 检查省十余条）
scoreboard players operation #gsc_d editor = #gsc_tze editor
scoreboard players operation #gsc_d editor -= #gsc_tzs editor
execute if score #gsc_d editor matches 2500.. run scoreboard players operation #gsc_tzs editor = #gsc_tze editor
execute if score #gsc_d editor matches ..-2500 run scoreboard players operation #gsc_tzs editor = #gsc_tze editor
scoreboard players operation #gsc_d editor = #gsc_tze editor
scoreboard players operation #gsc_d editor -= #gsc_tzs editor
# 绝对值 + 钳到 1600（16 格/刻，与旧版 N≤16 同语义）
execute if score #gsc_d editor matches ..-1 run scoreboard players operation #gsc_d editor *= -1 const
execute if score #gsc_d editor matches 1601.. run scoreboard players set #gsc_d editor 1600

# ===== 组装反馈宏参数（命中时 glass_feedback 以 with storage 取用；每刻组装，几条命令）=====
scoreboard players operation #gsc_id editor = @s note_id
scoreboard players operation #gsc_hs editor = @s note_hitsound
execute if score #gsc_hs editor matches 0 run execute store result storage rhythm_axe:editor.runtime gf_hs int 1 run scoreboard players get note_hitsound options
execute unless score #gsc_hs editor matches 0 run execute store result storage rhythm_axe:editor.runtime gf_hs int 1 run scoreboard players get #gsc_hs editor
scoreboard players operation #gsc_hp editor = @s note_hit_particles
execute if score #gsc_hp editor matches 0 run execute store result storage rhythm_axe:editor.runtime gf_hp int 1 run scoreboard players get note_particle options
execute unless score #gsc_hp editor matches 0 run execute store result storage rhythm_axe:editor.runtime gf_hp int 1 run scoreboard players get #gsc_hp editor
data modify storage rhythm_axe:editor.runtime gf_case set value "damage"
execute store result storage rhythm_axe:editor.runtime gf_cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:editor.runtime gf_nid int 1 run scoreboard players get #gsc_id editor
scoreboard players operation #gsc_idx editor = @s editor_n_idx
execute store result storage rhythm_axe:editor.runtime gf_idx int 1 run scoreboard players get #gsc_idx editor

# ===== 采样循环（宏注入起点 + 字面量步进；交互实体零触碰）=====
# 起点 tz_start（×100 → double 0.01）；保精度写法同 build_.mcfunction：
#   26.x store result storage double/int 会截断小数 ⇒ 走 entity data.<字段> double → data modify set from
# 终止条件由 glass_sweep_step 读 #gsc_i/#gsc_d 控制（每个采样点判定后沿 ^ ^ ^1 前进）
scoreboard players set #ed_g_hit editor 0
scoreboard players set #gsc_i editor 0
execute store result entity @s data.ed_sweep_tz double 0.01 run scoreboard players get #gsc_tzs editor
data modify storage rhythm_axe:prop tz_start set from entity @s data.ed_sweep_tz
function rhythm_axe:editor/judge/glass_sweep_entry with storage rhythm_axe:prop
# 清理宏参数（下刻采样前会重新组装）
execute if data storage rhythm_axe:editor.runtime gf_hs run data remove storage rhythm_axe:editor.runtime gf_hs
execute if data storage rhythm_axe:editor.runtime gf_hp run data remove storage rhythm_axe:editor.runtime gf_hp
execute if data storage rhythm_axe:editor.runtime gf_case run data remove storage rhythm_axe:editor.runtime gf_case
execute if data storage rhythm_axe:editor.runtime gf_cursor run data remove storage rhythm_axe:editor.runtime gf_cursor
execute if data storage rhythm_axe:editor.runtime gf_idx run data remove storage rhythm_axe:editor.runtime gf_idx
execute if data storage rhythm_axe:editor.runtime gf_nid run data remove storage rhythm_axe:editor.runtime gf_nid
execute if data storage rhythm_axe:prop tz_start run data remove storage rhythm_axe:prop tz_start
