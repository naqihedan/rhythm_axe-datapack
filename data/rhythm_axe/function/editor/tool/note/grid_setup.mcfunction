# 网格参数派生（面板 23「网格尺寸」）：读 note_grid tool_opt（档位 0..3）→ 算 #g_u / #g_o / #g_h
#   格点统一为 0.5 + k×g（永远包含方块中心，g=1 时与旧行为完全一致）
#     档0 = 0.1  → u=100  相位=500 % 100 = 0     （0.5/0.6/0.7…）
#     档1 = 0.25 → u=250  相位=500 % 250 = 0     （0.5/0.75/1.0/1.25）
#     档2 = 0.5  → u=500  相位=500 % 500 = 0     （0.5/1.0/1.5）
#     档3 = 1    → u=1000 相位=500 % 1000 = 500  （0.5/1.5/2.5 = 旧行为）
#   ★ 相位用 500 % u 一行算出，档0 的相位恰好也是 0（因为 0.5 本身是 0.1 的整数倍）。
scoreboard players set #g_u editor 1000
scoreboard players set #gi editor 0
execute store result score #gi editor run scoreboard players get note_grid tool_opt
execute if score #gi editor matches 0 run scoreboard players set #g_u editor 100
execute if score #gi editor matches 1 run scoreboard players set #g_u editor 250
execute if score #gi editor matches 2 run scoreboard players set #g_u editor 500
execute if score #gi editor matches 3 run scoreboard players set #g_u editor 1000
scoreboard players operation #g_o editor = 500 const
scoreboard players operation #g_o editor %= #g_u editor
scoreboard players operation #g_h editor = #g_u editor
scoreboard players operation #g_h editor /= 2 const