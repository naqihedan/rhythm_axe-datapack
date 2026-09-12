# 音符设置面板：显示暂存 editing.temp（类型循环/时间±可编辑，其余属性后续接入）
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 11
# 批量模式：复用完整面板（所有字段 + 相对/绝对开关）；editing.temp 作"同值"、editing.rel.delta 作"相对增量"
scoreboard players set #batch_mode editor 0
execute if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_mode editor 1
execute if score #batch_mode editor matches 0 run tellraw @s [{"text":"====音符属性控制面板====","color":"gold","bold":true}]
execute if score #batch_mode editor matches 1 run execute store result score #batch_n editor run data get storage rhythm_axe:maps.editor editing.batch_ids
execute if score #batch_mode editor matches 1 run tellraw @s [{"text":"====批量编辑","color":"gold","bold":true},{"score":{"name":"#batch_n","objective":"editor"},"color":"gold","bold":true},{"text":" 个音符====","color":"gold","bold":true}]
execute if score #batch_mode editor matches 0 run tellraw @s [\
{"text":"音符 #","color":"gray"},\
{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"gray"}\
]
# 类型（显示类型名；0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
# 类型（行首[x]= 已修改红可点重置(893)/未修改灰；批量未修改显示 -）
execute if score #temp editor matches 0 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 音符盒 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 0 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":"-","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 0 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 音符盒 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 0 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 音符盒 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 1 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 木板 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 1 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":"-","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 1 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 木板 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 1 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 木板 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 2 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 唱片机 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 2 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":"-","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 2 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 唱片机 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 2 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 唱片机 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 3 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 混凝土 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 3 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":"-","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 3 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 混凝土 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 3 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 混凝土 ","color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 4 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 染色玻璃 ","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 4 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":"-","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 4 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14004"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 染色玻璃 ","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
execute if score #temp editor matches 4 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.type run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"上一个类型（0 音符盒/1 木板/2 唱片机/3 混凝土/4 染色玻璃）"}},\
{"text":" 染色玻璃 ","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12101"},"hover_event":{"action":"show_text","value":"下一个类型（循环切换）"}}\
]
# 判定时间：绝对模式显示 temp.time（下界 0 时减号禁用）；相对模式显示增量（加减均可）
scoreboard players set #rel_on editor 0
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute store result score #disp_time editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #rel_on editor matches 1 run execute store result score #disp_time editor run data get storage rhythm_axe:maps.editor editing.rel.delta.time
execute if score #rel_on editor matches 1 unless score #disp_time editor matches 0 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14016"},"hover_event":{"action":"show_text","value":"取消本项修改（增量归 0）"}},\
{"text":"[~]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 13301"},"hover_event":{"action":"show_text","value":"相对模式：在原值基础上增减；点击切换为绝对"}},\
{"text":"判定时间：","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"判定时间 -tpb"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"判定时间 +tpb"}}\
]
execute if score #rel_on editor matches 1 if score #disp_time editor matches 0 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：增量归 0"}},\
{"text":"[~]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 13301"},"hover_event":{"action":"show_text","value":"相对模式：在原值基础上增减；点击切换为绝对"}},\
{"text":"判定时间：","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"判定时间 -tpb"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"判定时间 +tpb"}}\
]
# 绝对模式：temp.time != orig.time → 已修改（红 [x]）；否则灰
scoreboard players set #mod_time editor 0
# 批量 + 绝对：看 batch_set 标记（批量模式没有 editing.orig）
execute if score #rel_on editor matches 0 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.time run scoreboard players set #mod_time editor 1
# 单音符 + 绝对：temp vs orig
execute if score #batch_mode editor matches 0 run execute store result score #orig_t editor run data get storage rhythm_axe:maps.editor editing.orig.time
execute if score #rel_on editor matches 0 if score #batch_mode editor matches 0 unless score #disp_time editor = #orig_t editor run scoreboard players set #mod_time editor 1
# 绝对模式，time ≤ 0（红/灰按是否修改）
execute if score #rel_on editor matches 0 if score #mod_time editor matches 1 if score #disp_time editor matches ..0 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14016"},"hover_event":{"action":"show_text","value":"取消本项修改（还原为打开时的值）"}},\
{"text":"[~]","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13301"},"hover_event":{"action":"show_text","value":"绝对模式：直接设为设定值；点击切换为相对"}},\
{"text":"判定时间：","color":"white"},\
{"text":"[--]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"判定时间 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻（最少 0）"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"判定时间 +tpb（当前播放头时间点）"}}\
]
execute if score #rel_on editor matches 0 unless score #mod_time editor matches 1 if score #disp_time editor matches ..0 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"[~]","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13301"},"hover_event":{"action":"show_text","value":"绝对模式：直接设为设定值；点击切换为相对"}},\
{"text":"判定时间：","color":"white"},\
{"text":"[--]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"判定时间 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻（最少 0）"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"判定时间 +tpb（当前播放头时间点）"}}\
]
# 绝对模式，time ≥ 1（红/灰按是否修改）
execute if score #rel_on editor matches 0 if score #mod_time editor matches 1 if score #disp_time editor matches 1.. run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14016"},"hover_event":{"action":"show_text","value":"取消本项修改（还原为打开时的值）"}},\
{"text":"[~]","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13301"},"hover_event":{"action":"show_text","value":"绝对模式：直接设为设定值；点击切换为相对"}},\
{"text":"判定时间：","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"判定时间 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻（最少 0）"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"判定时间 +tpb（当前播放头时间点）"}}\
]
execute if score #rel_on editor matches 0 unless score #mod_time editor matches 1 if score #disp_time editor matches 1.. run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"[~]","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13301"},"hover_event":{"action":"show_text","value":"绝对模式：直接设为设定值；点击切换为相对"}},\
{"text":"判定时间：","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"判定时间 -tpb（当前播放头时间点）"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"判定时间 -1 刻（最少 0）"}},\
{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"判定时间 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"判定时间 +tpb（当前播放头时间点）"}}\
]
# 基础寿命（全类型；行首[x]= 已修改红可点重置(890)/未修改灰；批量未修改显示 -）
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.base_life run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14001"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"基础寿命：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12601"},"hover_event":{"action":"show_text","value":"基础寿命 -1（最少 1）"}},\
{"nbt":"editing.temp.note_base_life","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12602"},"hover_event":{"action":"show_text","value":"基础寿命 +1"}}\
]
execute if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.base_life run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"基础寿命：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12601"},"hover_event":{"action":"show_text","value":"基础寿命 -1（最少 1）"}},\
{"text":"-","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12602"},"hover_event":{"action":"show_text","value":"基础寿命 +1"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.base_life run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14001"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"基础寿命：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12601"},"hover_event":{"action":"show_text","value":"基础寿命 -1（最少 1）"}},\
{"nbt":"editing.temp.note_base_life","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12602"},"hover_event":{"action":"show_text","value":"基础寿命 +1"}}\
]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.base_life run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"基础寿命：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12601"},"hover_event":{"action":"show_text","value":"基础寿命 -1（最少 1）"}},\
{"nbt":"editing.temp.note_base_life","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12602"},"hover_event":{"action":"show_text","value":"基础寿命 +1"}}\
]
# 引导线（仅 0/1/2 型：音符盒/木板/唱片机；开=当前音符与前一个 0/1/2 音符生成引导线；默认开启）
scoreboard players set #fp_tmp editor 0
execute store result score #fp_tmp editor run data get storage rhythm_axe:maps.editor editing.temp.following_point
# ★ #temp 在判定时间段已被改为 time，引导线判断须用独立 #ntype（=音符 type 0/1/2），否则开关恒不显示
scoreboard players set #ntype editor 0
execute store result score #ntype editor run data get storage rhythm_axe:maps.editor editing.temp.type
# ★ 批量编辑：所有属性一律显示（不按音符类型隐藏），引导线同样按 0/1/2 型放行
execute if score #batch_mode editor matches 1 run scoreboard players set #ntype editor 0
execute if score #ntype editor matches 0..2 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.following_point if score #fp_tmp editor matches ..0 run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14005"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为 -）"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"当前禁用：不连接前一个 0/1/2 音符的引导线"}}]
execute if score #ntype editor matches 0..2 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.following_point if score #fp_tmp editor matches 1 run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14005"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为 -）"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"当前启用：生成前后 0/1/2 音符的引导线"}}]
execute if score #ntype editor matches 0..2 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.following_point run tellraw @s [{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【-】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"未修改：点击切换为启用/禁用"}}]
execute if score #ntype editor matches 0..2 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.following_point if score #fp_tmp editor matches ..0 run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14005"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"当前禁用：不连接前一个 0/1/2 音符的引导线"}}]
execute if score #ntype editor matches 0..2 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.following_point if score #fp_tmp editor matches 1 run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14005"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"当前启用：生成前后 0/1/2 音符的引导线"}}]
execute if score #ntype editor matches 0..2 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.following_point if score #fp_tmp editor matches ..0 run tellraw @s [{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"当前禁用：不连接前一个 0/1/2 音符的引导线"}}]
execute if score #ntype editor matches 0..2 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.following_point if score #fp_tmp editor matches 1 run tellraw @s [{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},{"text":"      ","color":"white"},{"text":"引导线：","color":"white"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13201"},"hover_event":{"action":"show_text","value":"当前启用：生成前后 0/1/2 音符的引导线"}}]
# 无视流速（开=出生时刻=判定时间-基础寿命，忽略流速；出生时刻不再可指定，游玩时自动计算）
scoreboard players set #igit editor 0
execute store result score #igit editor run data get storage rhythm_axe:maps.editor editing.temp.ignore_note_speed
execute if score #igit editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14006"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为 -）"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"当前启用：出生时刻=判定时间-基础寿命（忽略流速）"}}]
execute if score #igit editor matches 0 if data storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14006"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为 -）"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"当前禁用：出生时刻=判定时间-基础寿命×16/流速"}}]
execute if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed run tellraw @s [{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【-】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"未修改：点击切换为启用/禁用"}}]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.ignore_note_speed if score #igit editor matches 1 run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14006"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"当前启用：出生时刻=判定时间-基础寿命（忽略流速）"}}]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.ignore_note_speed if score #igit editor matches 0 run tellraw @s [{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14006"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"当前禁用：出生时刻=判定时间-基础寿命×16/流速"}}]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.ignore_note_speed if score #igit editor matches 1 run tellraw @s [{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【当前启用】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"当前启用：出生时刻=判定时间-基础寿命（忽略流速）"}}]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.ignore_note_speed if score #igit editor matches 0 run tellraw @s [{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},{"text":"      ","color":"white"},{"text":"无视流速：","color":"white"},{"text":"【当前禁用】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13202"},"hover_event":{"action":"show_text","value":"当前禁用：出生时刻=判定时间-基础寿命×16/流速"}}]
# 持续时长（3/4 型；批量模式下不看音符类型，一律显示；支持相对/绝对）
# ★ 组件化渲染（note_dur_row 宏叶子）：相对=显示增量，绝对=显示设定值
# #temp 供下方颜色/密度行复用：批量模式强制按 3 型放行，使混凝土/玻璃专属属性也可显示
scoreboard players set #temp editor 0
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #batch_mode editor matches 1 run scoreboard players set #temp editor 3
# 相对开关与显示值
scoreboard players set #rel_dur editor 0
execute store result score #rel_dur editor run data get storage rhythm_axe:maps.editor editing.rel.on.duration
scoreboard players set #disp_dur editor 0
execute store result score #disp_dur editor run data get storage rhythm_axe:maps.editor editing.temp.duration
execute if score #rel_dur editor matches 1 run execute store result score #disp_dur editor run data get storage rhythm_axe:maps.editor editing.rel.delta.duration
# 已修改标志：相对=增量非 0；批量绝对=batch_set 标记；单音符绝对=changed 标记
scoreboard players set #mod_dur editor 0
execute if score #rel_dur editor matches 1 unless score #disp_dur editor matches 0 run scoreboard players set #mod_dur editor 1
execute if score #rel_dur editor matches 0 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.duration run scoreboard players set #mod_dur editor 1
execute if score #rel_dur editor matches 0 if score #batch_mode editor matches 0 if data storage rhythm_axe:maps.editor editing.changed.duration run scoreboard players set #mod_dur editor 1
# [x] 组件（红=已修改，点击 14002 重置；灰=未修改）
data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：此项暂未更改\"}}"
execute if score #mod_dur editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14002\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（相对=增量归 0 / 绝对=恢复原值）\"}}"
# [~] 组件（黄=相对，灰=绝对；点击 13305 切换）
data modify storage rhythm_axe:prop tcomp set value "{\"text\":\"[~]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13305\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"绝对模式：直接设为设定值；点击切换为相对\"}}"
execute if score #rel_dur editor matches 1 run data modify storage rhythm_axe:prop tcomp set value "{\"text\":\"[~]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13305\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"相对模式：在原值基础上增减；点击切换为绝对\"}}"
# [--]/[-] 组件（绝对模式且当前值 ≤0 时减号禁用显示红色；相对模式增量可负）
data modify storage rhythm_axe:prop mcomp set value "{\"text\":\"[--]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12203\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"持续 -tpb（当前播放头时间点）\"}},{\"text\":\"[-]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12201\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"持续 -1（最少 0）\"}}"
execute if score #rel_dur editor matches 1 run data modify storage rhythm_axe:prop mcomp set value "{\"text\":\"[--]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12203\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"增量 -tpb（当前播放头时间点）\"}},{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12201\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"增量 -1\"}}"
execute if score #rel_dur editor matches 0 if score #disp_dur editor matches 1.. run data modify storage rhythm_axe:prop mcomp set value "{\"text\":\"[--]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12203\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"持续 -tpb（当前播放头时间点）\"}},{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12201\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"持续 -1\"}}"
# 数值组件（相对=增量，绝对=设定值）
data modify storage rhythm_axe:prop vcomp set value "{\"score\":{\"name\":\"#disp_dur\",\"objective\":\"editor\"},\"color\":\"gold\"}"
# 渲染：批量模式一律显示；单音符仅 3/4 型显示
execute if score #batch_mode editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_dur_row with storage rhythm_axe:prop
execute if score #batch_mode editor matches 0 if score #ntype editor matches 3..4 run function rhythm_axe:editor/menu/note/panel/note_dur_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop xcomp
data remove storage rhythm_axe:prop tcomp
data remove storage rhythm_axe:prop mcomp
data remove storage rhythm_axe:prop vcomp
# 颜色（3/4 型，或批量模式一律显示；1-16=16 色，无 0；显示颜色名且字体为当前颜色）
execute if score #temp editor matches 3..4 run execute store result score #cv editor run data get storage rhythm_axe:maps.editor editing.temp.color
# ★ 批量模式：颜色尚未设定（0 或越界）→ 补默认 1（白），否则 #cv 不在 1..16 时颜色行不渲染
# （temp.color 只有被 batch_set.color 标记时才会写回，故补默认不影响未修改的批量应用）
execute if score #batch_mode editor matches 1 if score #cv editor matches ..0 run data modify storage rhythm_axe:maps.editor editing.temp.color set value 1b
execute if score #batch_mode editor matches 1 if score #cv editor matches ..0 run scoreboard players set #cv editor 1
execute if score #batch_mode editor matches 1 if score #cv editor matches 17.. run data modify storage rhythm_axe:maps.editor editing.temp.color set value 1b
execute if score #batch_mode editor matches 1 if score #cv editor matches 17.. run scoreboard players set #cv editor 1
# 已修改标志（绝=temp.color!=orig.color；批量=batch_set.color）
scoreboard players set #mod_c editor 0
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.color run scoreboard players set #mod_c editor 1
execute if score #batch_mode editor matches 0 run execute store result score #ov_c editor run data get storage rhythm_axe:maps.editor editing.orig.color
execute if score #batch_mode editor matches 0 unless score #cv editor = #ov_c editor run scoreboard players set #mod_c editor 1
# [x] 组件（红=已修改/灰=未修改）
data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：此项暂未更改\"}}"
execute if score #mod_c editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14015\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（重置为未修改，显示 -）\"}}"
# 颜色名（按 #cv 取值）
execute if score #cv editor matches 1 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 白 \",\"color\":\"white\"}"
execute if score #cv editor matches 2 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 灰 \",\"color\":\"gray\"}"
execute if score #cv editor matches 3 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 淡灰 \",\"color\":\"#9d9d97\"}"
execute if score #cv editor matches 4 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 黑 \",\"color\":\"black\"}"
execute if score #cv editor matches 5 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 棕 \",\"color\":\"#835432\"}"
execute if score #cv editor matches 6 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 红 \",\"color\":\"red\"}"
execute if score #cv editor matches 7 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 橙 \",\"color\":\"#f9801d\"}"
execute if score #cv editor matches 8 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 黄 \",\"color\":\"yellow\"}"
execute if score #cv editor matches 9 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 黄绿 \",\"color\":\"#80c71f\"}"
execute if score #cv editor matches 10 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 绿 \",\"color\":\"green\"}"
execute if score #cv editor matches 11 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 青 \",\"color\":\"#169c9c\"}"
execute if score #cv editor matches 12 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 淡蓝 \",\"color\":\"#3ab3da\"}"
execute if score #cv editor matches 13 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 蓝 \",\"color\":\"blue\"}"
execute if score #cv editor matches 14 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 紫 \",\"color\":\"#8932b8\"}"
execute if score #cv editor matches 15 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 品红 \",\"color\":\"#c74ebd\"}"
execute if score #cv editor matches 16 run data modify storage rhythm_axe:prop cname set value "{\"text\":\" 粉 \",\"color\":\"#ff00ea\"}"
# 渲染颜色行（仅 3/4 型且有颜色）
execute if score #temp editor matches 3..4 if score #cv editor matches 1.. run function rhythm_axe:editor/menu/note/panel/note_color_row with storage rhythm_axe:prop
# 清理
data remove storage rhythm_axe:prop xcomp
data remove storage rhythm_axe:prop cname
# 密度（仅 3 型混凝土；行首[x]= 已修改红可点重置(892)/未修改灰；批量未修改显示 -）
execute if score #temp editor matches 3 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.density run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14003"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"判定密度：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12401"},"hover_event":{"action":"show_text","value":"密度 -1（最少 1）"}},\
{"nbt":"editing.temp.density","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12402"},"hover_event":{"action":"show_text","value":"密度 +1"}}\
]
execute if score #temp editor matches 3 if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.density run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"判定密度：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12401"},"hover_event":{"action":"show_text","value":"密度 -1（最少 1）"}},\
{"text":"-","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12402"},"hover_event":{"action":"show_text","value":"密度 +1"}}\
]
execute if score #temp editor matches 3 unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.density run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14003"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"判定密度：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12401"},"hover_event":{"action":"show_text","value":"密度 -1（最少 1）"}},\
{"nbt":"editing.temp.density","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12402"},"hover_event":{"action":"show_text","value":"密度 +1"}}\
]
execute if score #temp editor matches 3 unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.density run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"判定密度：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12401"},"hover_event":{"action":"show_text","value":"密度 -1（最少 1）"}},\
{"nbt":"editing.temp.density","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12402"},"hover_event":{"action":"show_text","value":"密度 +1"}}\
]
# 大小（全类型，float 一位小数去 f；与文档一致 1.0）
# 相对模式显示增量（delta.size 为 ×100，转为 ×10 与绝对同尺度），绝对显示 temp.size
scoreboard players set #rel_on editor 0
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.size
execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.temp.size 100
scoreboard players operation #v editor += 5 const
scoreboard players operation #v editor /= 10 const
execute if score #rel_on editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.rel.delta.size
execute if score #rel_on editor matches 1 run scoreboard players operation #v editor /= 10 const
scoreboard players set #nz editor 0
execute if score #v editor matches ..-1 run scoreboard players set #nz editor 1
scoreboard players operation #vi editor = #v editor
execute if score #vi editor matches ..-1 run scoreboard players operation #vi editor *= -1 const
scoreboard players operation #vf editor = #vi editor
scoreboard players operation #vi editor /= 10 const
scoreboard players operation #vf editor %= 10 const
execute if score #rel_on editor matches 1 unless score #v editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14017"},"hover_event":{"action":"show_text","value":"取消本项修改（增量归 0）"}},\
{"text":"[~]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 13302"},"hover_event":{"action":"show_text","value":"相对模式：在原值基础上增减；点击切换为绝对"}},\
{"text":"音符尺寸：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
execute if score #rel_on editor matches 1 unless score #v editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14017"},"hover_event":{"action":"show_text","value":"取消本项修改（增量归 0）"}},\
{"text":"[~]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 13302"},"hover_event":{"action":"show_text","value":"相对模式：在原值基础上增减；点击切换为绝对"}},\
{"text":"音符尺寸：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
execute if score #rel_on editor matches 1 if score #v editor matches 0 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：增量归 0"}},\
{"text":"[~]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 13302"},"hover_event":{"action":"show_text","value":"相对模式：在原值基础上增减；点击切换为绝对"}},\
{"text":"音符尺寸：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
# 绝对模式：temp.size != orig.size → 已修改（红 [x]）；否则灰
scoreboard players set #mod_size editor 0
execute if score #rel_on editor matches 0 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.size run scoreboard players set #mod_size editor 1
execute if score #batch_mode editor matches 0 run execute store result score #orig_s editor run data get storage rhythm_axe:maps.editor editing.orig.size 100
execute if score #batch_mode editor matches 0 run scoreboard players operation #orig_s editor += 5 const
execute if score #batch_mode editor matches 0 run scoreboard players operation #orig_s editor /= 10 const
execute if score #rel_on editor matches 0 if score #batch_mode editor matches 0 unless score #v editor = #orig_s editor run scoreboard players set #mod_size editor 1
execute if score #rel_on editor matches 0 if score #mod_size editor matches 1 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14017"},"hover_event":{"action":"show_text","value":"取消本项修改（还原为打开时的值）"}},\
{"text":"[~]","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13302"},"hover_event":{"action":"show_text","value":"绝对模式：直接设为设定值；点击切换为相对"}},\
{"text":"音符尺寸：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
execute if score #rel_on editor matches 0 unless score #mod_size editor matches 1 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"[~]","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 13302"},"hover_event":{"action":"show_text","value":"绝对模式：直接设为设定值；点击切换为相对"}},\
{"text":"音符尺寸：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"大小 -0.1（最少 0.1）"}},\
{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"大小 +0.1"}}\
]
# ★ 修负数值颠倒/补数：/= 向下取整、%= floorMod，直接拆分负数会错位；改为绝对值拆分 + 独立符号（负零分支在 note_pos_row）。
# 相对模式读增量（delta 为 ×100，/10 转 ×10 与绝对同尺度）
scoreboard players set #rel_pos editor 0
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.temp.position[0] 100
scoreboard players operation #vx editor += 5 const
scoreboard players operation #vx editor /= 10 const
execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.temp.position[1] 100
scoreboard players operation #vy editor += 5 const
scoreboard players operation #vy editor /= 10 const
execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.temp.position[2] 100
scoreboard players operation #vz editor += 5 const
scoreboard players operation #vz editor /= 10 const
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
# 判定位置：三轴一行，行首[x][~]（相对：红=有增量/灰=未改；绝对：红=已改/灰=未改）
scoreboard players set #mod_pos editor 0
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.position run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 1 if score #vx editor matches 1.. run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 1 if score #vx editor matches ..-1 run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 1 if score #vy editor matches 1.. run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 1 if score #vy editor matches ..-1 run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 1 if score #vz editor matches 1.. run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 1 if score #vz editor matches ..-1 run scoreboard players set #mod_pos editor 1
# 绝对模式：任一轴 temp != orig → 已修改
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run execute store result score #ox editor run data get storage rhythm_axe:maps.editor editing.orig.position[0] 100
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #ox editor += 5 const
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #ox editor /= 10 const
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run execute store result score #oy editor run data get storage rhythm_axe:maps.editor editing.orig.position[1] 100
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oy editor += 5 const
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oy editor /= 10 const
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run execute store result score #oz editor run data get storage rhythm_axe:maps.editor editing.orig.position[2] 100
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oz editor += 5 const
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oz editor /= 10 const
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 unless score #vx editor = #ox editor run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 unless score #vy editor = #oy editor run scoreboard players set #mod_pos editor 1
execute if score #rel_pos editor matches 0 if score #batch_mode editor matches 0 unless score #vz editor = #oz editor run scoreboard players set #mod_pos editor 1
data modify storage rhythm_axe:prop xcomp set value "\"\""
execute if score #rel_pos editor matches 1 if score #mod_pos editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14018\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（增量归 0）\"}}"
execute if score #rel_pos editor matches 1 if score #mod_pos editor matches 0 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：增量归 0\"}}"
execute if score #rel_pos editor matches 0 if score #mod_pos editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14018\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（还原为打开时的值）\"}}"
execute if score #rel_pos editor matches 0 unless score #mod_pos editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：此项暂未更改\"}}"
data modify storage rhythm_axe:prop tcomp set value "{\"text\":\"[~]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13303\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"绝对模式：直接设为设定值；点击切换为相对\"}}"
execute if score #rel_pos editor matches 1 run data modify storage rhythm_axe:prop tcomp set value "{\"text\":\"[~]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13303\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"相对模式：在原值基础上增减；点击切换为绝对\"}}"
data modify storage rhythm_axe:prop label set value "判定位置："
data modify storage rhythm_axe:prop paux set value "{\"text\":\"  【使用玩家位置】\",\"color\":\"red\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"仅绝对模式下使用\"}},{\"text\":\"  【对齐方块中心】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13602\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"判定位置对齐玩家所在方块中心\"}}"
execute if score #rel_pos editor matches 0 run data modify storage rhythm_axe:prop paux set value "{\"text\":\"  【使用玩家位置】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13601\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"判定位置设为玩家当前位置\"}},{\"text\":\"  【对齐方块中心】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13602\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"判定位置对齐玩家所在方块中心\"}}"
data modify storage rhythm_axe:prop bxm set value 13401
data modify storage rhythm_axe:prop bxp set value 13402
data modify storage rhythm_axe:prop bym set value 13403
data modify storage rhythm_axe:prop byp set value 13404
data modify storage rhythm_axe:prop bzm set value 13405
data modify storage rhythm_axe:prop bzp set value 13406
data modify storage rhythm_axe:prop bxm2 set value 13407
data modify storage rhythm_axe:prop bxp2 set value 13408
data modify storage rhythm_axe:prop bym2 set value 13409
data modify storage rhythm_axe:prop byp2 set value 13410
data modify storage rhythm_axe:prop bzm2 set value 13411
data modify storage rhythm_axe:prop bzp2 set value 13412
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
data remove storage rhythm_axe:prop xcomp
data remove storage rhythm_axe:prop tcomp
data remove storage rhythm_axe:prop paux
# 起始位置（start_pos 三轴一位小数；±0.1；相对判定位置的偏移）
# ★ 修负数值颠倒/补数：/= 向下取整、%= floorMod，直接拆分负数会错位；改为绝对值拆分 + 独立符号（负零分支在 note_pos_row）。
# 相对模式读增量（delta 为 ×100，/10 转 ×10 与绝对同尺度）
scoreboard players set #rel_sp editor 0
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[0] 100
scoreboard players operation #vx editor += 5 const
scoreboard players operation #vx editor /= 10 const
execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[1] 100
scoreboard players operation #vy editor += 5 const
scoreboard players operation #vy editor /= 10 const
execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[2] 100
scoreboard players operation #vz editor += 5 const
scoreboard players operation #vz editor /= 10 const
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
# 起始位置：三轴一行，行首[x][~]（相对：红=有增量/灰=未改；绝对：红=已改/灰=未改）
scoreboard players set #mod_sp editor 0
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.start_pos run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 1 if score #vx editor matches 1.. run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 1 if score #vx editor matches ..-1 run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 1 if score #vy editor matches 1.. run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 1 if score #vy editor matches ..-1 run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 1 if score #vz editor matches 1.. run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 1 if score #vz editor matches ..-1 run scoreboard players set #mod_sp editor 1
# 绝对模式：任一轴 temp != orig → 已修改
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run execute store result score #ox editor run data get storage rhythm_axe:maps.editor editing.orig.start_pos[0] 100
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #ox editor += 5 const
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #ox editor /= 10 const
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run execute store result score #oy editor run data get storage rhythm_axe:maps.editor editing.orig.start_pos[1] 100
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oy editor += 5 const
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oy editor /= 10 const
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run execute store result score #oz editor run data get storage rhythm_axe:maps.editor editing.orig.start_pos[2] 100
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oz editor += 5 const
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 run scoreboard players operation #oz editor /= 10 const
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 unless score #vx editor = #ox editor run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 unless score #vy editor = #oy editor run scoreboard players set #mod_sp editor 1
execute if score #rel_sp editor matches 0 if score #batch_mode editor matches 0 unless score #vz editor = #oz editor run scoreboard players set #mod_sp editor 1
data modify storage rhythm_axe:prop xcomp set value "\"\""
execute if score #rel_sp editor matches 1 if score #mod_sp editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14019\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（增量归 0）\"}}"
execute if score #rel_sp editor matches 1 if score #mod_sp editor matches 0 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：增量归 0\"}}"
execute if score #rel_sp editor matches 0 if score #mod_sp editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14019\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（还原为打开时的值）\"}}"
execute if score #rel_sp editor matches 0 unless score #mod_sp editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：此项暂未更改\"}}"
data modify storage rhythm_axe:prop tcomp set value "{\"text\":\"[~]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13304\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"绝对模式：直接设为设定值；点击切换为相对\"}}"
execute if score #rel_sp editor matches 1 run data modify storage rhythm_axe:prop tcomp set value "{\"text\":\"[~]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 13304\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"相对模式：在原值基础上增减；点击切换为绝对\"}}"
data modify storage rhythm_axe:prop label set value "起始位置："
data modify storage rhythm_axe:prop paux set value "\"\""
data modify storage rhythm_axe:prop bxm set value 13501
data modify storage rhythm_axe:prop bxp set value 13502
data modify storage rhythm_axe:prop bym set value 13503
data modify storage rhythm_axe:prop byp set value 13504
data modify storage rhythm_axe:prop bzm set value 13505
data modify storage rhythm_axe:prop bzp set value 13506
data modify storage rhythm_axe:prop bxm2 set value 13507
data modify storage rhythm_axe:prop bxp2 set value 13508
data modify storage rhythm_axe:prop bym2 set value 13509
data modify storage rhythm_axe:prop byp2 set value 13510
data modify storage rhythm_axe:prop bzm2 set value 13511
data modify storage rhythm_axe:prop bzp2 set value 13512
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
data remove storage rhythm_axe:prop xcomp
data remove storage rhythm_axe:prop tcomp
data remove storage rhythm_axe:prop paux
# 动画类型（缓动类型+强度，全类型；行首[x]= 重置899；红色可点/灰色未修改）
scoreboard players set #mod_e editor 0
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.anim_easing run scoreboard players set #mod_e editor 1
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.anim_power run scoreboard players set #mod_e editor 1
execute if score #batch_mode editor matches 0 if data storage rhythm_axe:maps.editor editing.changed.anim_easing run scoreboard players set #mod_e editor 1
execute if score #batch_mode editor matches 0 if data storage rhythm_axe:maps.editor editing.changed.anim_power run scoreboard players set #mod_e editor 1
# ★ 缓动行显示必须先读 anim_easing 到 #temp：上方 #temp 被复用为 type（此处须重新取缓动类型 1/2/3），否则缓动行按 type 值错位/消失
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.anim_easing
# 缓入（已修改）
execute if score #temp editor matches 1 if score #mod_e editor matches 1 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14010"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"动画类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓入 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 缓入（未修改）
execute if score #temp editor matches 1 if score #mod_e editor matches 0 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"动画类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓入 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 缓出（已修改）
execute if score #temp editor matches 2 if score #mod_e editor matches 1 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14010"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"动画类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓出 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 缓出（未修改）
execute if score #temp editor matches 2 if score #mod_e editor matches 0 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"动画类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓出 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 缓入缓出（已修改）
execute if score #temp editor matches 3 if score #mod_e editor matches 1 run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14010"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"动画类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓入缓出 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 缓入缓出（未修改）
execute if score #temp editor matches 3 if score #mod_e editor matches 0 run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"动画类型：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},\
{"text":" 缓入缓出 ","color":"gold"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},\
{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},\
{"nbt":"editing.temp.anim_power","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}\
]
# 击打音效（行首[x]= 已修改红可点重置(904)/未修改灰；批量未修改显示 -）
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.hitsound run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14011"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"击打音效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12801"},"hover_event":{"action":"show_text","value":"上一个音效组（0-6）"}},\
{"nbt":"editing.temp.hitsound","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12802"},"hover_event":{"action":"show_text","value":"下一个音效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12806"},"hover_event":{"action":"show_text","value":"打开全局击打音效编辑"}}\
]
execute if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.hitsound run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"击打音效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12801"},"hover_event":{"action":"show_text","value":"上一个音效组（0-6）"}},\
{"text":"-","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12802"},"hover_event":{"action":"show_text","value":"下一个音效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12806"},"hover_event":{"action":"show_text","value":"打开全局击打音效编辑"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.hitsound run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14011"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"击打音效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12801"},"hover_event":{"action":"show_text","value":"上一个音效组（0-6）"}},\
{"nbt":"editing.temp.hitsound","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12802"},"hover_event":{"action":"show_text","value":"下一个音效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12806"},"hover_event":{"action":"show_text","value":"打开全局击打音效编辑"}}\
]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.hitsound run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"击打音效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12801"},"hover_event":{"action":"show_text","value":"上一个音效组（0-6）"}},\
{"nbt":"editing.temp.hitsound","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12802"},"hover_event":{"action":"show_text","value":"下一个音效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12806"},"hover_event":{"action":"show_text","value":"打开全局击打音效编辑"}}\
]
# 击打视效（行首[x]= 已修改红可点重置(905)/未修改灰；批量未修改显示 -）
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.hit_particles run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14012"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"击打视效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12901"},"hover_event":{"action":"show_text","value":"上一个视效组（0-6）"}},\
{"nbt":"editing.temp.hit_particles","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12902"},"hover_event":{"action":"show_text","value":"下一个视效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12906"},"hover_event":{"action":"show_text","value":"打开全局击打视效编辑"}}\
]
execute if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.hit_particles run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"击打视效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12901"},"hover_event":{"action":"show_text","value":"上一个视效组（0-6）"}},\
{"text":"-","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12902"},"hover_event":{"action":"show_text","value":"下一个视效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12906"},"hover_event":{"action":"show_text","value":"打开全局击打视效编辑"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.hit_particles run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14012"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"击打视效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12901"},"hover_event":{"action":"show_text","value":"上一个视效组（0-6）"}},\
{"nbt":"editing.temp.hit_particles","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12902"},"hover_event":{"action":"show_text","value":"下一个视效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12906"},"hover_event":{"action":"show_text","value":"打开全局击打视效编辑"}}\
]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.hit_particles run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"击打视效：","color":"white"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12901"},"hover_event":{"action":"show_text","value":"上一个视效组（0-6）"}},\
{"nbt":"editing.temp.hit_particles","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12902"},"hover_event":{"action":"show_text","value":"下一个视效组"}},\
{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12906"},"hover_event":{"action":"show_text","value":"打开全局击打视效编辑"}}\
]
# 击打事件（行首[x]= 已修改红可点重置(906)/未修改灰；批量未修改显示 -）
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.hit_events run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14013"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"击打事件：","color":"white"},\
{"text":"【二级菜单】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13006"},"hover_event":{"action":"show_text","value":"编辑该音符的击打事件指令列表"}}\
]
execute if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.hit_events run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"击打事件：","color":"white"},\
{"text":"-","color":"gold"},\
{"text":"【二级菜单】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13006"},"hover_event":{"action":"show_text","value":"编辑该音符的击打事件指令列表"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.hit_events run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14013"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"击打事件：","color":"white"},\
{"text":"【二级菜单】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13006"},"hover_event":{"action":"show_text","value":"编辑该音符的击打事件指令列表"}}\
]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.hit_events run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"击打事件：","color":"white"},\
{"text":"【二级菜单】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13006"},"hover_event":{"action":"show_text","value":"编辑该音符的击打事件指令列表"}}\
]
# 音符标签（行首[x]= 已修改红可点重置(907)/未修改灰；批量未修改显示 -）
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.custom_tag run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14014"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为未修改，显示 -）"}},\
{"text":"      ","color":"white"},\
{"text":"音符标签：","color":"white"},\
{"nbt":"editing.temp.custom_tag","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" 【设置标签】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13106"},"hover_event":{"action":"show_text","value":"设置音符标签"}}\
]
execute if score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch_set.custom_tag run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符标签：","color":"white"},\
{"text":"-","color":"gold"},\
{"text":" 【设置标签】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13106"},"hover_event":{"action":"show_text","value":"设置音符标签"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.changed.custom_tag run tellraw @s [\
{"text":"[x]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14014"},"hover_event":{"action":"show_text","value":"取消本项修改（重置为打开时的值）"}},\
{"text":"      ","color":"white"},\
{"text":"音符标签：","color":"white"},\
{"nbt":"editing.temp.custom_tag","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" 【设置标签】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13106"},"hover_event":{"action":"show_text","value":"设置音符标签"}}\
]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.changed.custom_tag run tellraw @s [\
{"text":"[x]","color":"gray","hover_event":{"action":"show_text","value":"未修改：此项暂未更改"}},\
{"text":"      ","color":"white"},\
{"text":"音符标签：","color":"white"},\
{"nbt":"editing.temp.custom_tag","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" 【设置标签】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 13106"},"hover_event":{"action":"show_text","value":"设置音符标签"}}\
]
# 批量模式底部：无删除
execute if score #batch_mode editor matches 1 run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13702"},"hover_event":{"action":"show_text","value":"丢弃批量修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13701"},"hover_event":{"action":"show_text","value":"把批量增量应用到所选音符（可撤销）"}}\
]
execute unless score #batch_mode editor matches 1 unless data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13702"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13701"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},\
{"text":"  【删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13703"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13702"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13701"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},\
{"text":"  【确认删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13704"},"hover_event":{"action":"show_text","value":"再次点击确认删除"}}\
]
execute unless score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [{"text":"【取消删除】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 13705"},"hover_event":{"action":"show_text","value":"取消删除"}}]
