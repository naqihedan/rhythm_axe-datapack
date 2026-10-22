#arg:value
# 对话框提交：【自定义角度】11515 —— 角度(度) → 三角函数表索引(0.1°) → cos/sin(×10000) → 走预设同款旋转
# ★ 校验（沿用《数字输入框的校验规范》）：空 / 非数字会让 `set value $(value)` 整条失败 ⇒ 用列表包裹 `[$(value)]`
#   （空输入 → `[]`）+ `data get … [0] 1`（**必须带 scale**）+ `store success` 判定，写值行全挂 #dlg_ok matches 1。
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填角度（度，可带小数与负号，如 37.5 或 -12）","color":"red"}]
# 度 → 表索引（步长 0.1°：×10）→ 归一化到 0..3599（负角 % 后加回 3600）
execute if score #dlg_ok editor matches 1 run execute store result score #rot_idx editor run data get storage rhythm_axe:prop dlg_in[0] 10
execute if score #dlg_ok editor matches 1 run scoreboard players operation #rot_idx editor %= 3600 const
execute if score #dlg_ok editor matches 1 if score #rot_idx editor matches ..-1 run scoreboard players add #rot_idx editor 3600
# 查表（display_animation:trig_table 由 utilization/math/init_trig_table 在 load 时建好，3600 项 = 0.0°~359.9°）
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:prop angle int 1 run scoreboard players get #rot_idx editor
execute if score #dlg_ok editor matches 1 run function rhythm_axe:utilization/math/trig_lookup with storage rhythm_axe:prop
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:prop rotate_cos set from storage display_animation:trig_result.cos
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:prop rotate_sin set from storage display_animation:trig_result.sin
# 走与预设按钮完全相同的旋转（中心 = 锚点；按 [X][Y][Z] 轴；[S] 连带起始位置；一次快照可撤销；结束时下一刻回面板）
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate
# 清理临时数据
data remove storage rhythm_axe:prop dlg_in
data remove storage rhythm_axe:prop angle
scoreboard players reset #rot_idx editor
