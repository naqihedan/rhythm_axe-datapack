# 编辑器真实判定：染色玻璃（4）（@s = 玻璃展示实体；at @s 由 tick_one 保证）
# 照搬游玩 glass_sweep（CCD 扫掠）：判定 = 玻璃「中心 0.5³ 方块」∩「玩家判定箱」。
#   玻璃每刻位移可能 > 玩家判定箱宽 0.6 格 ⇒ 沿「上一刻中心 → 当前中心」线段按 1.0 格步长采样，任一点命中即算撞到。
# 与游玩的实现差异（都更省）：
#   ① 中心轨迹直接读 place 每刻写好的计分板：editor_n_vx/vy/vz（当前）+ editor_n_vvx/vvy/vvz（上一刻，tick_one 快照）
#      —— 编辑器视觉中心是服务端算的，不需要游玩那套 note_glass_center marker；
#   ② 采样点坐标复用「本音符自己的交互实体」承载（execute positioned 不能用动态计分板坐标）；
#      玻璃不做视线判定，借它的位置零副作用（下一刻 place 会重写）。
# ★ 不进 trigger_/play_sound/play_particle（三者都有「玻璃零反馈」防线），反馈走 visual/glass_feedback。
# ★ 不扣血、不计成绩；重复命中用 options.damage_cooldown 做冷却（与游玩同款节奏）。
# 前置：实体计分板 editor_n_vx/vy/vz、editor_n_vvx/vvy/vvz、note_id；玩家级冷却 #ed_g_cd（editor 假玩家）

# ===== 冷却说明 =====
# 与游玩同款【玩家级单一冷却】#ed_g_cd（editor 假玩家）：由 visual/tick 每刻递减一次。
# 本文件不做每实体递减 —— 那会按玻璃数量放大递减速度。
# （冷却递减已上移到 visual/tick）

# ===== 位移 d = 当前中心 − 上一刻中心（×1000）=====
scoreboard players operation #gsc_dx editor = @s editor_n_vx
scoreboard players operation #gsc_dx editor -= @s editor_n_vvx
scoreboard players operation #gsc_dy editor = @s editor_n_vy
scoreboard players operation #gsc_dy editor -= @s editor_n_vvy
scoreboard players operation #gsc_dz editor = @s editor_n_vz
scoreboard players operation #gsc_dz editor -= @s editor_n_vvz
# d²（×1e6；坐标 ×1000 ⇒ 1 格² = 1e6）
scoreboard players operation #gsc_d2 editor = #gsc_dx editor
scoreboard players operation #gsc_d2 editor *= #gsc_dx editor
scoreboard players operation #gsc_t editor = #gsc_dy editor
scoreboard players operation #gsc_t editor *= #gsc_dy editor
scoreboard players operation #gsc_d2 editor += #gsc_t editor
scoreboard players operation #gsc_t editor = #gsc_dz editor
scoreboard players operation #gsc_t editor *= #gsc_dz editor
scoreboard players operation #gsc_d2 editor += #gsc_t editor
# 跳转保护 + 钳制（★ 2026-09-21 修正）：
#   ① 任一轴位移 > 25 格（刚出生首帧 vv 初值 / seek 跳转）⇒ 判为跳转，只测当前点；
#   ② 单轴钳到 ±25 格 —— 计分板是 32 位 int（上限 2147483647），位移若达 50 格则 d² = 2.5e9 直接溢出，
#      且 `matches 2500000001..` 这种超上限常量会让【整个函数加载失败】（本文件初版踩过）。
#      钳制后 d² ≤ 3×25000² = 1.875e9 < 上限，安全。正常每刻位移远低于 25 格。
scoreboard players set #gsc_jump editor 0
execute if score #gsc_dx editor matches 25001.. run scoreboard players set #gsc_jump editor 1
execute if score #gsc_dx editor matches ..-25001 run scoreboard players set #gsc_jump editor 1
execute if score #gsc_dy editor matches 25001.. run scoreboard players set #gsc_jump editor 1
execute if score #gsc_dy editor matches ..-25001 run scoreboard players set #gsc_jump editor 1
execute if score #gsc_dz editor matches 25001.. run scoreboard players set #gsc_jump editor 1
execute if score #gsc_dz editor matches ..-25001 run scoreboard players set #gsc_jump editor 1
execute if score #gsc_dx editor matches 25001.. run scoreboard players set #gsc_dx editor 25000
execute if score #gsc_dx editor matches ..-25001 run scoreboard players set #gsc_dx editor -25000
execute if score #gsc_dy editor matches 25001.. run scoreboard players set #gsc_dy editor 25000
execute if score #gsc_dy editor matches ..-25001 run scoreboard players set #gsc_dy editor -25000
execute if score #gsc_dz editor matches 25001.. run scoreboard players set #gsc_dz editor 25000
execute if score #gsc_dz editor matches ..-25001 run scoreboard players set #gsc_dz editor -25000

# ===== 采样数 N = ceil(d/1.0)（步长 1.0 格）；跳转时强制 N=1；上限 16 =====
# 步长 1.0 不会隧穿：单点判定体 = 玩家判定箱各轴外扩 0.25（XZ 宽 0.6+0.5 = 1.1 > 1.0）⇒ 相邻覆盖区重叠
# 阈值 = (N−1)²×1e6（不取 sqrt，省每玻璃每刻的 sqrt 开销）
scoreboard players set #gsc_n editor 1
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 1000001.. run scoreboard players set #gsc_n editor 2
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 4000001.. run scoreboard players set #gsc_n editor 3
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 9000001.. run scoreboard players set #gsc_n editor 4
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 16000001.. run scoreboard players set #gsc_n editor 5
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 25000001.. run scoreboard players set #gsc_n editor 6
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 36000001.. run scoreboard players set #gsc_n editor 7
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 49000001.. run scoreboard players set #gsc_n editor 8
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 64000001.. run scoreboard players set #gsc_n editor 9
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 81000001.. run scoreboard players set #gsc_n editor 10
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 100000001.. run scoreboard players set #gsc_n editor 11
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 121000001.. run scoreboard players set #gsc_n editor 12
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 144000001.. run scoreboard players set #gsc_n editor 13
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 169000001.. run scoreboard players set #gsc_n editor 14
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 196000001.. run scoreboard players set #gsc_n editor 15
execute if score #gsc_jump editor matches 0 if score #gsc_d2 editor matches 225000001.. run scoreboard players set #gsc_n editor 16

# ===== 配对交互实体打临时 tag（采样点坐标载体）=====
scoreboard players operation #gsc_id editor = @s note_id
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #gsc_id editor run tag @s add gs_probe
# 没有交互实体（异常实体）⇒ 放弃本刻采样（避免在错误位置检测）
execute unless entity @e[tag=gs_probe,limit=1] run return 0
# ★ 4 格门控（2026-09-21 与游玩对齐）：玻璃视觉中心 4 格内没有编辑者 ⇒ 本刻不扫掠
#   游玩 active_note 只对 @a[distance=..4] 的 marker 调 glass_sweep（同款性能优化，玻璃为主谱面的大头）。
#   ⚠ 副作用：每刻位移 > 4 格时，扫掠段可能整个落在门控范围外 ⇒ 漏判（见 音符.md 的说明）。
#   基准 = 配对交互实体位置（place 已把它更新到当前刻视觉中心），门控只作粗筛，不要求逐帧精确。
#   （return 前先摘掉 gs_probe，避免 tag 残留）
scoreboard players set #gsc_skip editor 0
execute at @e[tag=gs_probe,limit=1] unless entity @a[tag=editor_active,distance=..4] run scoreboard players set #gsc_skip editor 1
execute if score #gsc_skip editor matches 1 run tag @e[tag=gs_probe] remove gs_probe
execute if score #gsc_skip editor matches 1 run return 0

# ===== 组装反馈宏参数（命中时 glass_feedback 以 with storage 取用；每刻组装，几条命令）=====
scoreboard players operation #gsc_hs editor = @s note_hitsound
execute store result storage rhythm_axe:editor.runtime gf_hs int 1 run scoreboard players get #gsc_hs editor
scoreboard players operation #gsc_hp editor = @s note_hit_particles
execute store result storage rhythm_axe:editor.runtime gf_hp int 1 run scoreboard players get #gsc_hp editor
data modify storage rhythm_axe:editor.runtime gf_case set value "damage"
execute store result storage rhythm_axe:editor.runtime gf_cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:editor.runtime gf_nid int 1 run scoreboard players get #gsc_id editor
scoreboard players operation #gsc_idx editor = @s editor_n_idx
execute store result storage rhythm_axe:editor.runtime gf_idx int 1 run scoreboard players get #gsc_idx editor

# ===== 采样循环 =====
scoreboard players set #ed_g_hit editor 0
scoreboard players set #gsc_i editor 0
function rhythm_axe:editor/judge/glass_sweep_step
tag @e[tag=gs_probe] remove gs_probe
# 清理宏参数（下刻采样前会重新组装）
execute if data storage rhythm_axe:editor.runtime gf_hs run data remove storage rhythm_axe:editor.runtime gf_hs
execute if data storage rhythm_axe:editor.runtime gf_hp run data remove storage rhythm_axe:editor.runtime gf_hp
execute if data storage rhythm_axe:editor.runtime gf_case run data remove storage rhythm_axe:editor.runtime gf_case
execute if data storage rhythm_axe:editor.runtime gf_cursor run data remove storage rhythm_axe:editor.runtime gf_cursor
execute if data storage rhythm_axe:editor.runtime gf_idx run data remove storage rhythm_axe:editor.runtime gf_idx
execute if data storage rhythm_axe:editor.runtime gf_nid run data remove storage rhythm_axe:editor.runtime gf_nid
