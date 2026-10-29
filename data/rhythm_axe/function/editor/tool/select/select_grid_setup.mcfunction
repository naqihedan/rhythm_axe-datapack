# 选择工具网格参数派生：读 select_grid tool_opt（档位 0..3）→ #g_u / #g_o / #g_h
#   ★ 与音符工具的 note_grid 独立（用户 2026-10-29 定）；与 editor/tool/note/grid_setup 同算法，
#     只换成 select_grid 这一档位来源。吸附本体复用 editor/tool/note/grid_snap_axis。
#     档0 = 0.1 → u=100 / 档1 = 0.25 → u=250 / 档2 = 0.5 → u=500 / 档3 = 1 → u=1000
#   相位 = 500 % u（450 必须是 const 表里的常量 500；见 load.mcfunction）
scoreboard players set #g_u editor 1000
scoreboard players set #gi editor 0
execute store result score #gi editor run scoreboard players get select_grid tool_opt
execute if score #gi editor matches 0 run scoreboard players set #g_u editor 100
execute if score #gi editor matches 1 run scoreboard players set #g_u editor 250
execute if score #gi editor matches 2 run scoreboard players set #g_u editor 500
execute if score #gi editor matches 3 run scoreboard players set #g_u editor 1000
scoreboard players operation #g_o editor = 500 const
scoreboard players operation #g_o editor %= #g_u editor
scoreboard players operation #g_h editor = #g_u editor
scoreboard players operation #g_h editor /= 2 const