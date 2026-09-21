# 玻璃扫掠单采样点（@s = 玻璃展示实体；glass_check 初始化后递归）
# 采样点 P = A + d×i/N（×1000 整数运算，先乘后除保精度）；A = 上一刻中心（editor_n_vv*）
# 坐标写进配对交互实体（tag gs_probe）→ at 它做对角两点检测
# 命中 → visual/glass_feedback（damage 组反馈，内部设冷却）；#ed_g_hit=1 后本刻不再采样

# 采样点坐标（×1000）
scoreboard players operation #gsc_px editor = #gsc_dx editor
scoreboard players operation #gsc_px editor *= #gsc_i editor
scoreboard players operation #gsc_px editor /= #gsc_n editor
scoreboard players operation #gsc_px editor += @s editor_n_vvx
scoreboard players operation #gsc_py editor = #gsc_dy editor
scoreboard players operation #gsc_py editor *= #gsc_i editor
scoreboard players operation #gsc_py editor /= #gsc_n editor
scoreboard players operation #gsc_py editor += @s editor_n_vvy
scoreboard players operation #gsc_pz editor = #gsc_dz editor
scoreboard players operation #gsc_pz editor *= #gsc_i editor
scoreboard players operation #gsc_pz editor /= #gsc_n editor
scoreboard players operation #gsc_pz editor += @s editor_n_vvz
# 写进交互实体（×1000 → double 0.001）
execute store result entity @e[tag=gs_probe,limit=1] Pos[0] double 0.001 run scoreboard players get #gsc_px editor
execute store result entity @e[tag=gs_probe,limit=1] Pos[1] double 0.001 run scoreboard players get #gsc_py editor
execute store result entity @e[tag=gs_probe,limit=1] Pos[2] double 0.001 run scoreboard players get #gsc_pz editor
# 对角两点检测（= 玻璃中心 0.5³ 方块与玩家判定箱相交）：两点相距 0.5 ⇒ 有效范围 ±0.50 格
# ★ at 只改执行位置，@s 仍是玻璃展示实体（glass_feedback 要用它读 note_*）
# ★ 冷却中（#ed_g_cd > 0，玩家级）不重复反馈；用 unless「matches 1..」⇒ 未赋值 / 为 0 都放行
execute at @e[tag=gs_probe,limit=1] positioned ~-0.75 ~-0.75 ~-0.75 if entity @a[tag=editor_active,dx=0,dy=0,dz=0] positioned ~0.5 ~0.5 ~0.5 if entity @a[tag=editor_active,dx=0,dy=0,dz=0] unless score #ed_g_cd editor matches 1.. run function rhythm_axe:editor/visual/glass_feedback with storage rhythm_axe:editor.runtime

# 游标推进：i = N 是终点（含在内）；命中则不再继续
scoreboard players add #gsc_i editor 1
execute if score #ed_g_hit editor matches 0 if score #gsc_i editor <= #gsc_n editor run function rhythm_axe:editor/judge/glass_sweep_step
