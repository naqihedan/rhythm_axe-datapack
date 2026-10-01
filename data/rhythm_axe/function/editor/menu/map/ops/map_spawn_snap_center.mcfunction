# 【对齐方块中心（XZ）】(11303)：初始位置的 X/Z 对齐到所在方块中心 floor(x)+0.5，Y 不变（只改暂存）
#   与音符属性面板的【对齐方块中心】(note/pos/note_pos_snap_center) 同算法，只做 XZ 两轴。
# ⚠️ 这里**不能用** round_score：它的「取绝对值再取整」在 |值| < 1 的负数上会丢符号
#    （-0.6 → 取绝对值取整成 0 → ×-1 还是 0 → +0.5 变正）。floor 必须直接算：
#    ×1000 读入（data get 的 scale，本身即 floor）→ /1000（计分板向下取整）→ *1000 → +500 → 0.001 精度写回
#    实测：-3.2→-3.5、-0.6→-0.5、3.0→3.5、-3.0→-2.5
execute store result score #rnd_v editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_x 1000
scoreboard players operation #rnd_v editor /= 1000 const
scoreboard players operation #rnd_v editor *= 1000 const
scoreboard players add #rnd_v editor 500
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_x double 0.001 run scoreboard players get #rnd_v editor
execute store result score #rnd_v editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_z 1000
scoreboard players operation #rnd_v editor /= 1000 const
scoreboard players operation #rnd_v editor *= 1000 const
scoreboard players add #rnd_v editor 500
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_z double 0.001 run scoreboard players get #rnd_v editor
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
