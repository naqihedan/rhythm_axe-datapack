# 批量编辑面板（复用面板11，editing.batch=1b）：只显示相对增量字段（判定时间/大小/判定位置/起始位置）
# 每个字段带【x】= 撤销本项修改（增量归 0）；底部【取消】【确认】。调整按钮复用现有 click 值（760/783/774/860..887），
# note_panel_adjust / note_pos_adjust 已是模式感知（相对→写 editing.rel.delta），末尾回调 note_panel → 此处。
data modify storage rhythm_axe:maps.editor current_panel set value 11
execute store result score #batch_n editor run data get storage rhythm_axe:maps.editor editing.batch_ids
tellraw @s [{"text":"====批量编辑 ","color":"gold","bold":true},{"score":{"name":"#batch_n","objective":"editor"},"color":"gold","bold":true},{"text":" 个音符（相对增量）====","color":"gold","bold":true}]
# 判定时间（增量，整数刻）
execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.rel.delta.time
tellraw @s [\
{"text":"判定时间：","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12003"},"hover_event":{"action":"show_text","value":"增量 -tpb"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12001"},"hover_event":{"action":"show_text","value":"增量 -1 刻"}},\
{"score":{"name":"#v","objective":"editor"},"color":"white"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12002"},"hover_event":{"action":"show_text","value":"增量 +1 刻"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12004"},"hover_event":{"action":"show_text","value":"增量 +tpb"}},\
{"text":" 【x】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14016"},"hover_event":{"action":"show_text","value":"撤销本项修改（增量归 0）"}}\
]
# 大小（增量，一位小数；负数符号处理）
execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.rel.delta.size
scoreboard players operation #v editor /= 10 const
scoreboard players set #sneg editor 0
execute if score #v editor matches ..-1 run scoreboard players set #sneg editor 1
execute if score #sneg editor matches 1 run scoreboard players operation #v editor *= -1 const
scoreboard players operation #vi editor = #v editor
scoreboard players operation #vi editor /= 10 const
scoreboard players operation #vf editor = #v editor
scoreboard players operation #vf editor %= 10 const
execute if score #sneg editor matches 1 run tellraw @s [\
{"text":"大小：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"增量 -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"增量 +0.1"}},\
{"text":" 【x】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14017"},"hover_event":{"action":"show_text","value":"撤销本项修改（增量归 0）"}}\
]
execute if score #sneg editor matches 0 run tellraw @s [\
{"text":"大小：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12501"},"hover_event":{"action":"show_text","value":"增量 -0.1"}},\
{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12502"},"hover_event":{"action":"show_text","value":"增量 +0.1"}},\
{"text":" 【x】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14017"},"hover_event":{"action":"show_text","value":"撤销本项修改（增量归 0）"}}\
]
# 判定位置（三个轴增量）
scoreboard players set #rel_pos editor 0
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[0]
execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[1]
execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[2]
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
data modify storage rhythm_axe:prop xcomp set value "\"\""
data modify storage rhythm_axe:prop tcomp set value "\"\""
data modify storage rhythm_axe:prop paux set value "\"\""
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
tellraw @s [{"text":"  【x】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14018"},"hover_event":{"action":"show_text","value":"撤销判定位置增量改动（三轴归 0）"}}]
# 起始位置（三个轴增量）
scoreboard players set #rel_sp editor 0
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute store result score #vx editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[0]
execute store result score #vy editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[1]
execute store result score #vz editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[2]
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
data modify storage rhythm_axe:prop xcomp set value "\"\""
data modify storage rhythm_axe:prop tcomp set value "\"\""
data modify storage rhythm_axe:prop paux set value "\"\""
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
tellraw @s [{"text":"  【x】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 14019"},"hover_event":{"action":"show_text","value":"撤销起始位置增量改动（三轴归 0）"}}]
# 底部
tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 13702"},"hover_event":{"action":"show_text","value":"丢弃批量修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 13701"},"hover_event":{"action":"show_text","value":"把批量增量应用到所选音符（可撤销）"}}\
]
