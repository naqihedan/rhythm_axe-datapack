# 音符设置面板：显示暂存 editing.temp（类型循环/时间±可编辑，其余属性后续接入）
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 11
tellraw @s [{"text":"====音符属性控制面板====","color":"gold","bold":true}]
tellraw @s [\
{"text":"音符 #","color":"gray"},\
{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"white"}\
]
# 类型（显示类型名；0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #temp editor matches 0 run tellraw @s [\
{"text":"类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 音符盒 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 1 run tellraw @s [\
{"text":"类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 木板 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 2 run tellraw @s [\
{"text":"类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 唱片机 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 3 run tellraw @s [\
{"text":"类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 混凝土 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 4 run tellraw @s [\
{"text":"类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 染色玻璃 ","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 762"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
# 判定时间：绝对模式显示 temp.time（下界 0 时减号禁用）；相对模式显示增量（加减均可）
scoreboard players set #rel_on editor 0
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute store result score #disp_time editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #rel_on editor matches 1 run execute store result score #disp_time editor run data get storage rhythm_axe:maps.editor editing.rel.delta.time
execute if score #rel_on editor matches 1 run tellraw @s [\
{"text":"判定时间：","color":"gray"},\
{"text":"[--]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 783"},"hover_event":{"action":"show_text","value":"判定时间 -tpb"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 760"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 761"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 784"},"hover_event":{"action":"show_text","value":"判定时间 +tpb"}},\
{"text":"  【切换绝对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 787"},"hover_event":{"action":"show_text","value":"切换为绝对（写入设定值）"}}\
]
execute if score #rel_on editor matches 0 if score #disp_time editor matches ..0 run tellraw @s [\
{"text":"判定时间：","color":"gray"},\
{"text":"[--]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 783"},"hover_event":{"action":"show_text","value":"判定时间 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 760"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻（最少 0）"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 761"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 784"},"hover_event":{"action":"show_text","value":"判定时间 +tpb（当前播放头时间点）"}},\
{"text":"  【切换相对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 787"},"hover_event":{"action":"show_text","value":"切换为相对（在原值基础上加增量）"}}\
]
execute if score #rel_on editor matches 0 if score #disp_time editor matches 1.. run tellraw @s [\
{"text":"判定时间：","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 783"},"hover_event":{"action":"show_text","value":"判定时间 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 760"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻（最少 0）"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 761"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 784"},"hover_event":{"action":"show_text","value":"判定时间 +tpb（当前播放头时间点）"}},\
{"text":"  【切换相对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 787"},"hover_event":{"action":"show_text","value":"切换为相对（在原值基础上加增量）"}}\
]
# 基础寿命（全类型）
tellraw @s [\
{"text":"基础寿命：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 776"},"hover_event":{"action":"show_text","value":"基础寿命 -1（最少 1）"}},\
{"nbt":"editing.temp.note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 777"},"hover_event":{"action":"show_text","value":"基础寿命 +1"}}\
]
# 引导线（仅 0/1/2 型：音符盒/木板/唱片机；开=当前音符与前一个 0/1/2 音符生成引导线；默认开启）
scoreboard players set #fp_tmp editor 0
execute store result score #fp_tmp editor run data get storage rhythm_axe:maps.editor editing.temp.following_point
# ★ #temp 在判定时间段已被改为 time，引导线判断须用独立 #ntype（=音符 type 0/1/2），否则开关恒不显示
scoreboard players set #ntype editor 0
execute store result score #ntype editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #ntype editor matches 0..2 if score #fp_tmp editor matches ..0 run tellraw @s [{"text":"引导线：","color":"gray"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 794"},"hover_event":{"action":"show_text","value":"当前禁用：不连接前一个 0/1/2 音符的引导线"}}]
execute if score #ntype editor matches 0..2 if score #fp_tmp editor matches 1 run tellraw @s [{"text":"引导线：","color":"gray"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 794"},"hover_event":{"action":"show_text","value":"当前启用：生成前后 0/1/2 音符的引导线"}}]
# 无视流速（开=出生时刻=判定时间-基础寿命，忽略流速；出生时刻不再可指定，游玩时自动计算）
execute unless data storage rhythm_axe:maps.editor editing.temp.ignore_note_speed run tellraw @s [{"text":"无视流速：","color":"gray"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 795"},"hover_event":{"action":"show_text","value":"当前禁用：出生时刻=判定时间-基础寿命×16/流速"}}]
execute if data storage rhythm_axe:maps.editor editing.temp.ignore_note_speed run tellraw @s [{"text":"无视流速：","color":"gray"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 795"},"hover_event":{"action":"show_text","value":"当前启用：出生时刻=判定时间-基础寿命（忽略流速）"}}]
# 持续（仅 3/4 型：混凝土/染色玻璃）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute store result score #dur editor run data get storage rhythm_axe:maps.editor editing.temp.duration
execute if score #temp editor matches 3..4 if score #dur editor matches ..0 run tellraw @s [\
{"text":"持续时长：","color":"gray"},\
{"text":"[--]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 785"},"hover_event":{"action":"show_text","value":"持续 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 768"},"hover_event":{"action":"show_text","value":"持续 -1"}},\
{"nbt":"editing.temp.duration","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 769"},"hover_event":{"action":"show_text","value":"持续 +1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 786"},"hover_event":{"action":"show_text","value":"持续 +tpb（当前播放头时间点）"}}\
]
execute if score #temp editor matches 3..4 if score #dur editor matches 1.. run tellraw @s [\
{"text":"持续时长：","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 785"},"hover_event":{"action":"show_text","value":"持续 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 768"},"hover_event":{"action":"show_text","value":"持续 -1"}},\
{"nbt":"editing.temp.duration","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 769"},"hover_event":{"action":"show_text","value":"持续 +1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 786"},"hover_event":{"action":"show_text","value":"持续 +tpb（当前播放头时间点）"}}\
]
# 颜色（仅 3/4 型；0=无 1-16=16 色，显示颜色名且字体为当前颜色）
execute if score #temp editor matches 3..4 run execute store result score #cv editor run data get storage rhythm_axe:maps.editor editing.temp.color
execute if score #temp editor matches 3..4 if score #cv editor matches 0 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 无 ","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 1 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 白 ","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 2 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 灰 ","color":"gray"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 3 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 淡灰 ","color":"#9d9d97"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 4 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 黑 ","color":"black"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 5 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 棕 ","color":"#835432"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 6 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 红 ","color":"red"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 7 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 橙 ","color":"#f9801d"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 8 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 黄 ","color":"yellow"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 9 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 黄绿 ","color":"#80c71f"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 10 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 绿 ","color":"green"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 11 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 青 ","color":"#169c9c"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 12 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 淡蓝 ","color":"#3ab3da"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 13 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 蓝 ","color":"blue"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 14 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 紫 ","color":"#8932b8"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 15 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 品红 ","color":"#c74ebd"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
execute if score #temp editor matches 3..4 if score #cv editor matches 16 run tellraw @s [\
{"text":"颜色：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},\
{"text":" 粉 ","color":"#ff00ea"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}\
]
# 密度（仅 3 型混凝土）
execute if score #temp editor matches 3 run tellraw @s [\
{"text":"判定密度：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 772"},"hover_event":{"action":"show_text","value":"密度 -1（最少 1）"}},\
{"nbt":"editing.temp.density","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 773"},"hover_event":{"action":"show_text","value":"密度 +1"}}\
]
# 大小（全类型，float 一位小数去 f；与文档一致 1.0）
# 相对模式显示增量（delta.size 为 ×100，转为 ×10 与绝对同尺度），绝对显示 temp.size
scoreboard players set #rel_on editor 0
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.size
execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.temp.size 10
execute if score #rel_on editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.rel.delta.size
execute if score #rel_on editor matches 1 run scoreboard players operation #v editor /= 10 const
scoreboard players operation #vi editor = #v editor
scoreboard players operation #vi editor /= 10 const
scoreboard players operation #vf editor = #v editor
scoreboard players operation #vf editor %= 10 const
execute if score #vf editor matches ..-1 run scoreboard players operation #vf editor *= -1 const
scoreboard players set #nz editor 0
execute if score #v editor matches ..-1 if score #vi editor matches 0 run scoreboard players set #nz editor 1
execute if score #nz editor matches 1 run tellraw @s [\
{"text":"大小：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 774"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 775"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
execute if score #nz editor matches 0 run tellraw @s [\
{"text":"大小：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 774"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 775"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
# 大小 相对/绝对 切换（动作导向：点击后切换到的模式）
execute if score #rel_on editor matches 1 run tellraw @s [{"text":"  【切换绝对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 788"},"hover_event":{"action":"show_text","value":"切换为绝对（写入设定值）"}}]
execute if score #rel_on editor matches 0 run tellraw @s [{"text":"  【切换相对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 788"},"hover_event":{"action":"show_text","value":"切换为相对（在原值基础上加增量）"}}]
# 判定位置（position 三轴一位小数；±0.1；【使用玩家位置】【对齐方块中心】）
# ★ 修负数值颠倒/补数：/= 向下取整、%= floorMod，直接拆分负数会错位；改为绝对值拆分 + 独立符号（负零分支在 note_pos_row）。
# 相对模式读增量（delta 为 ×100，/10 转 ×10 与绝对同尺度）
scoreboard players set #rel_pos editor 0
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.temp.position[0] 10
execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.temp.position[1] 10
execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.temp.position[2] 10
execute if score #rel_pos editor matches 1 run execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[0]
execute if score #rel_pos editor matches 1 run execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[1]
execute if score #rel_pos editor matches 1 run execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[2]
execute if score #rel_pos editor matches 1 run scoreboard players operation #vx editor /= 10 const
execute if score #rel_pos editor matches 1 run scoreboard players operation #vy editor /= 10 const
execute if score #rel_pos editor matches 1 run scoreboard players operation #vz editor /= 10 const
scoreboard players set #vxneg editor 0
execute if score #vx editor matches ..-1 run scoreboard players set #vxneg editor 1
scoreboard players operation #vxi editor = #vx editor
execute if score #vxi editor matches ..-1 run scoreboard players operation #vxi editor *= -1 const
scoreboard players operation #vxf editor = #vxi editor
scoreboard players operation #vxi editor /= 10 const
scoreboard players operation #vxf editor %= 10 const
scoreboard players set #nx editor 0
execute if score #vxneg editor matches 1 if score #vxi editor matches 0 run scoreboard players set #nx editor 1
execute if score #vxneg editor matches 1 run scoreboard players operation #vxi editor *= -1 const
scoreboard players set #vyneg editor 0
execute if score #vy editor matches ..-1 run scoreboard players set #vyneg editor 1
scoreboard players operation #vyi editor = #vy editor
execute if score #vyi editor matches ..-1 run scoreboard players operation #vyi editor *= -1 const
scoreboard players operation #vyf editor = #vyi editor
scoreboard players operation #vyi editor /= 10 const
scoreboard players operation #vyf editor %= 10 const
scoreboard players set #ny editor 0
execute if score #vyneg editor matches 1 if score #vyi editor matches 0 run scoreboard players set #ny editor 1
execute if score #vyneg editor matches 1 run scoreboard players operation #vyi editor *= -1 const
scoreboard players set #vzneg editor 0
execute if score #vz editor matches ..-1 run scoreboard players set #vzneg editor 1
scoreboard players operation #vzi editor = #vz editor
execute if score #vzi editor matches ..-1 run scoreboard players operation #vzi editor *= -1 const
scoreboard players operation #vzf editor = #vzi editor
scoreboard players operation #vzi editor /= 10 const
scoreboard players operation #vzf editor %= 10 const
scoreboard players set #nz editor 0
execute if score #vzneg editor matches 1 if score #vzi editor matches 0 run scoreboard players set #nz editor 1
execute if score #vzneg editor matches 1 run scoreboard players operation #vzi editor *= -1 const
data modify storage rhythm_axe:prop label set value "判定位置："
data modify storage rhythm_axe:prop bxm set value 860
data modify storage rhythm_axe:prop bxp set value 861
data modify storage rhythm_axe:prop bym set value 862
data modify storage rhythm_axe:prop byp set value 863
data modify storage rhythm_axe:prop bzm set value 864
data modify storage rhythm_axe:prop bzp set value 865
data modify storage rhythm_axe:prop bxm2 set value 876
data modify storage rhythm_axe:prop bxp2 set value 877
data modify storage rhythm_axe:prop bym2 set value 878
data modify storage rhythm_axe:prop byp2 set value 879
data modify storage rhythm_axe:prop bzm2 set value 880
data modify storage rhythm_axe:prop bzp2 set value 881
tellraw @s [{"text":"（[-][+]精调0.1格；[--][++]粗调1格）","color":"gray"}]
function rhythm_axe:editor/menu/note/pos/note_pos_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop label
data remove storage rhythm_axe:prop bxm
data remove storage rhythm_axe:prop bxp
data remove storage rhythm_axe:prop bym
data remove storage rhythm_axe:prop byp
data remove storage rhythm_axe:prop bzm
data remove storage rhythm_axe:prop bzp
data remove storage rhythm_axe:prop bxm2
data remove storage rhythm_axe:prop bxp2
data remove storage rhythm_axe:prop bym2
data remove storage rhythm_axe:prop byp2
data remove storage rhythm_axe:prop bzm2
data remove storage rhythm_axe:prop bzp2
tellraw @s [{"text":"  【使用玩家位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 866"},"hover_event":{"action":"show_text","value":"判定位置设为玩家当前位置"}},{"text":"  【对齐方块中心】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 867"},"hover_event":{"action":"show_text","value":"判定位置对齐玩家所在方块中心"}}]
# 判定位置 相对/绝对 切换
execute if score #rel_pos editor matches 1 run tellraw @s [{"text":"  【切换绝对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 789"},"hover_event":{"action":"show_text","value":"切换为绝对（写入设定值）"}}]
execute if score #rel_pos editor matches 0 run tellraw @s [{"text":"  【切换相对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 789"},"hover_event":{"action":"show_text","value":"切换为相对（在原值基础上加增量）"}}]
# 起始位置（start_pos 三轴一位小数；±0.1；相对判定位置的偏移）
# ★ 修负数值颠倒/补数：/= 向下取整、%= floorMod，直接拆分负数会错位；改为绝对值拆分 + 独立符号（负零分支在 note_pos_row）。
# 相对模式读增量（delta 为 ×100，/10 转 ×10 与绝对同尺度）
scoreboard players set #rel_sp editor 0
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[0] 10
execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[1] 10
execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[2] 10
execute if score #rel_sp editor matches 1 run execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[0]
execute if score #rel_sp editor matches 1 run execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[1]
execute if score #rel_sp editor matches 1 run execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[2]
execute if score #rel_sp editor matches 1 run scoreboard players operation #vx editor /= 10 const
execute if score #rel_sp editor matches 1 run scoreboard players operation #vy editor /= 10 const
execute if score #rel_sp editor matches 1 run scoreboard players operation #vz editor /= 10 const
scoreboard players set #vxneg editor 0
execute if score #vx editor matches ..-1 run scoreboard players set #vxneg editor 1
scoreboard players operation #vxi editor = #vx editor
execute if score #vxi editor matches ..-1 run scoreboard players operation #vxi editor *= -1 const
scoreboard players operation #vxf editor = #vxi editor
scoreboard players operation #vxi editor /= 10 const
scoreboard players operation #vxf editor %= 10 const
scoreboard players set #nx editor 0
execute if score #vxneg editor matches 1 if score #vxi editor matches 0 run scoreboard players set #nx editor 1
execute if score #vxneg editor matches 1 run scoreboard players operation #vxi editor *= -1 const
scoreboard players set #vyneg editor 0
execute if score #vy editor matches ..-1 run scoreboard players set #vyneg editor 1
scoreboard players operation #vyi editor = #vy editor
execute if score #vyi editor matches ..-1 run scoreboard players operation #vyi editor *= -1 const
scoreboard players operation #vyf editor = #vyi editor
scoreboard players operation #vyi editor /= 10 const
scoreboard players operation #vyf editor %= 10 const
scoreboard players set #ny editor 0
execute if score #vyneg editor matches 1 if score #vyi editor matches 0 run scoreboard players set #ny editor 1
execute if score #vyneg editor matches 1 run scoreboard players operation #vyi editor *= -1 const
scoreboard players set #vzneg editor 0
execute if score #vz editor matches ..-1 run scoreboard players set #vzneg editor 1
scoreboard players operation #vzi editor = #vz editor
execute if score #vzi editor matches ..-1 run scoreboard players operation #vzi editor *= -1 const
scoreboard players operation #vzf editor = #vzi editor
scoreboard players operation #vzi editor /= 10 const
scoreboard players operation #vzf editor %= 10 const
scoreboard players set #nz editor 0
execute if score #vzneg editor matches 1 if score #vzi editor matches 0 run scoreboard players set #nz editor 1
execute if score #vzneg editor matches 1 run scoreboard players operation #vzi editor *= -1 const
data modify storage rhythm_axe:prop label set value "起始位置："
data modify storage rhythm_axe:prop bxm set value 868
data modify storage rhythm_axe:prop bxp set value 869
data modify storage rhythm_axe:prop bym set value 870
data modify storage rhythm_axe:prop byp set value 871
data modify storage rhythm_axe:prop bzm set value 872
data modify storage rhythm_axe:prop bzp set value 873
data modify storage rhythm_axe:prop bxm2 set value 882
data modify storage rhythm_axe:prop bxp2 set value 883
data modify storage rhythm_axe:prop bym2 set value 884
data modify storage rhythm_axe:prop byp2 set value 885
data modify storage rhythm_axe:prop bzm2 set value 886
data modify storage rhythm_axe:prop bzp2 set value 887
tellraw @s [{"text":"（[-][+]精调0.1格；[--][++]粗调1格）","color":"gray"}]
function rhythm_axe:editor/menu/note/pos/note_pos_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop label
data remove storage rhythm_axe:prop bxm
data remove storage rhythm_axe:prop bxp
data remove storage rhythm_axe:prop bym
data remove storage rhythm_axe:prop byp
data remove storage rhythm_axe:prop bzm
data remove storage rhythm_axe:prop bzp
data remove storage rhythm_axe:prop bxm2
data remove storage rhythm_axe:prop bxp2
data remove storage rhythm_axe:prop bym2
data remove storage rhythm_axe:prop byp2
data remove storage rhythm_axe:prop bzm2
data remove storage rhythm_axe:prop bzp2
# 起始位置 相对/绝对 切换
execute if score #rel_sp editor matches 1 run tellraw @s [{"text":"  【切换绝对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 790"},"hover_event":{"action":"show_text","value":"切换为绝对（写入设定值）"}}]
execute if score #rel_sp editor matches 0 run tellraw @s [{"text":"  【切换相对】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 790"},"hover_event":{"action":"show_text","value":"切换为相对（在原值基础上加增量）"}}]
# 动画类型（缓动类型+强度，全类型；左显示缓动名，右显示幂次）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.anim_easing
execute if score #temp editor matches 1 run tellraw @s [\
{"text":"动画类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 778"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓入 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 779"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 780"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 781"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
execute if score #temp editor matches 2 run tellraw @s [\
{"text":"动画类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 778"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓出 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 779"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 780"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 781"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
execute if score #temp editor matches 3 run tellraw @s [\
{"text":"动画类型：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 778"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓入缓出 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 779"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 780"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 781"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 击打音效（组号 0-6）
tellraw @s [\
{"text":"击打音效：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 799"},"hover_event":{"action":"show_text","value":"上一个音效组（0-6）"}},\
{"nbt":"editing.temp.hitsound","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 800"},"hover_event":{"action":"show_text","value":"下一个音效组"}},\
{"text":" 【编辑全局击打音效】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 801"},"hover_event":{"action":"show_text","value":"打开全局击打音效编辑"}}\
]
# 击打视效（组号 0-6）
tellraw @s [\
{"text":"击打视效：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 802"},"hover_event":{"action":"show_text","value":"上一个视效组（0-6）"}},\
{"nbt":"editing.temp.hit_particles","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 803"},"hover_event":{"action":"show_text","value":"下一个视效组"}},\
{"text":" 【编辑全局击打视效】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 804"},"hover_event":{"action":"show_text","value":"打开全局击打视效编辑"}}\
]
# 击打特效（hit_events 列表；二级菜单编辑）
tellraw @s [\
{"text":"击打特效：","color":"gray"},\
{"text":"【进入编辑二级菜单】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 856"},"hover_event":{"action":"show_text","value":"编辑该音符的击打特效指令列表"}}\
]
# 音符标签
tellraw @s [\
{"text":"音符标签：","color":"gray"},\
{"nbt":"editing.temp.custom_tag","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【设置标签】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 805"},"hover_event":{"action":"show_text","value":"设置音符标签"}}\
]
execute unless data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 764"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 763"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},\
{"text":"  【删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 765"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
execute if data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 764"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 763"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},\
{"text":"  【确认删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 766"},"hover_event":{"action":"show_text","value":"再次点击确认删除"}}\
]
execute if data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [{"text":"【取消删除】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 767"},"hover_event":{"action":"show_text","value":"取消删除"}}]
