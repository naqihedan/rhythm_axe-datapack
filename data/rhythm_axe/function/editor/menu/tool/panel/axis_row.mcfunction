#arg: label, color, tkey, vkey, a_tgl, b1, b2, b3, b4, look, center
# 工具选项栏 · 单轴设置行（面板 23，宏叶子；参数经 storage rhythm_axe:prop 传入）
#   渲染：  X：[开] [-1][-0.1] 1.0 [+0.1][+1] 【使用注视位置】【对齐方块中心】
#   label = 轴名（X/Y/Z）；color = 轴名颜色（X 红 / Y 绿 / Z 淡蓝）
#   tkey = 开关计分项名（tool_opt）；vkey = 值计分项名（tool_opt，×10 一位小数）
#   a_tgl = 已构好的开关按钮 JSON；b1..b4 = −1 / −0.1 / +0.1 / +1 四个步进；look = 使用注视位置；center = 对齐方块中心
# 读开关（缺失 → 视为关）
scoreboard players set #tp_on editor 0
$execute store result score #tp_on editor run scoreboard players get $(tkey) tool_opt
# 读值（×10；缺失 → 0）
scoreboard players set #tp_v editor 0
$execute store result score #tp_v editor run scoreboard players get $(vkey) tool_opt
# 拆符号/整数/小数（/= 向下取整、%= floorMod，直接拆负数会错位 ⇒ 取绝对值拆 + 独立符号；负零另标 #tvnz）
scoreboard players set #tvn editor 0
execute if score #tp_v editor matches ..-1 run scoreboard players set #tvn editor 1
scoreboard players operation #tvi editor = #tp_v editor
execute if score #tvi editor matches ..-1 run scoreboard players operation #tvi editor *= -1 const
scoreboard players operation #tvf editor = #tvi editor
scoreboard players operation #tvi editor /= 10 const
scoreboard players operation #tvf editor %= 10 const
scoreboard players set #tvnz editor 0
execute if score #tvn editor matches 1 if score #tvi editor matches 0 run scoreboard players set #tvnz editor 1
execute if score #tvn editor matches 1 run scoreboard players operation #tvi editor *= -1 const
# 输出（非负零 / 负零 两个分支）
$execute if score #tvnz editor matches 0 run tellraw @s [{"text":"$(label)：","color":"$(color)"},$(a_tgl),{"text":" "},{"text":"[-1]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(b1)"},"hover_event":{"action":"show_text","value":"$(label) −1"}},{"text":"[-0.1]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(b2)"},"hover_event":{"action":"show_text","value":"$(label) −0.1"}},{"text":" "},{"score":{"name":"#tvi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#tvf","objective":"editor"},"color":"gold"},{"text":" "},{"text":"[+0.1]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(b3)"},"hover_event":{"action":"show_text","value":"$(label) +0.1"}},{"text":"[+1]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(b4)"},"hover_event":{"action":"show_text","value":"$(label) +1"}},{"text":"  "},{"text":"【使用注视位置】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(look)"},"hover_event":{"action":"show_text","value":"把 $(label) 设为视线前方方块中心的坐标"}},{"text":"【对齐方块中心】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(center)"},"hover_event":{"action":"show_text","value":"把 $(label) 吸附到所在方块的中心"}}]
$execute if score #tvnz editor matches 1 run tellraw @s [{"text":"$(label)：","color":"$(color)"},$(a_tgl),{"text":" "},{"text":"[-1]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(b1)"},"hover_event":{"action":"show_text","value":"$(label) −1"}},{"text":"[-0.1]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(b2)"},"hover_event":{"action":"show_text","value":"$(label) −0.1"}},{"text":" "},{"text":"-","color":"gold"},{"score":{"name":"#tvi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#tvf","objective":"editor"},"color":"gold"},{"text":" "},{"text":"[+0.1]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(b3)"},"hover_event":{"action":"show_text","value":"$(label) +0.1"}},{"text":"[+1]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(b4)"},"hover_event":{"action":"show_text","value":"$(label) +1"}},{"text":"  "},{"text":"【使用注视位置】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(look)"},"hover_event":{"action":"show_text","value":"把 $(label) 设为视线前方方块中心的坐标"}},{"text":"【对齐方块中心】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(center)"},"hover_event":{"action":"show_text","value":"把 $(label) 吸附到所在方块的中心"}}]
