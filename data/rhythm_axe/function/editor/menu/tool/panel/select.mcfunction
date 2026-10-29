# 选择工具选项栏（面板 23，@s = 查看者；分组 5）
# 设置：网格尺寸 —— 决定框选两角对齐世界网格的尺寸（选区因此支持亚方块精度）
#   ★ 与音符工具的 note_grid 相互独立（存 select_grid）；档3（1 格）= 旧行为（方块中心）
#   行 225，列码 1..4 = 0.1 / 0.25 / 0.5 / 1
tellraw @s [{"text":"====选择工具选项栏====","color":"gold","bold":true}]
tellraw @s [{"text":"----网格尺寸----------","color":"gray"}]
tellraw @s [{"text":"两次右键定两角：角点会对齐到下面的网格。","color":"gray","italic":true}]
scoreboard players set #sg editor 3
execute store result score #sg editor run scoreboard players get select_grid tool_opt
data modify storage rhythm_axe:prop s0 set value "{\"text\":\"[0.1]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22501\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"网格 0.1：角点落在 0.50 / 0.60 / … / 1.00\"}}"
data modify storage rhythm_axe:prop s1 set value "{\"text\":\"[0.25]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"网格 0.25：角点落在 0.50 / 0.75 / 1.00 / 1.25\"}}"
data modify storage rhythm_axe:prop s2 set value "{\"text\":\"[0.5]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"网格 0.5：角点落在方块中心或方块交界处\"}}"
data modify storage rhythm_axe:prop s3 set value "{\"text\":\"[1]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"网格 1：角点落在方块中心（默认）\"}}"
execute if score #sg editor matches 0 run data modify storage rhythm_axe:prop s0 set value "{\"text\":\"[0.1]\",\"color\":\"green\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22501\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前网格：0.1（0.50 / 0.60 / … / 1.00）\"}}"
execute if score #sg editor matches 1 run data modify storage rhythm_axe:prop s1 set value "{\"text\":\"[0.25]\",\"color\":\"green\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前网格：0.25（0.50 / 0.75 / 1.00 / 1.25）\"}}"
execute if score #sg editor matches 2 run data modify storage rhythm_axe:prop s2 set value "{\"text\":\"[0.5]\",\"color\":\"green\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前网格：0.5（方块中心 / 方块交界处）\"}}"
execute if score #sg editor matches 3 run data modify storage rhythm_axe:prop s3 set value "{\"text\":\"[1]\",\"color\":\"green\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 22504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前网格：1（方块中心）\"}}"
function rhythm_axe:editor/menu/tool/panel/grid_row_sel with storage rhythm_axe:prop
data remove storage rhythm_axe:prop s0
data remove storage rhythm_axe:prop s1
data remove storage rhythm_axe:prop s2
data remove storage rhythm_axe:prop s3
tellraw @s [{"text":""},{"text":"【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回上一个打开的面板"}}]