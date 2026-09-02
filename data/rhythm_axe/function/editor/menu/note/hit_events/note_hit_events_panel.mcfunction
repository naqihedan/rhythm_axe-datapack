# 击打特效二级菜单面板：标题 + 所属音符（时间/类型/id）+ 指令列表（每指令一行）+ 操作按钮
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 14
tellraw @s [{"text":"====音符击打事件====","color":"gold","bold":true}]
# 所属音符行：{时间} {音符类型} #{音符id}（共 n 条指令）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute store result score #he_count editor run data get storage rhythm_axe:maps.editor editing.he_events
execute if score #temp editor matches 0 run tellraw @s [{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" 音符盒 #","color":"aqua"},{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"white"},{"text":"（共 ","color":"gray"},{"score":{"name":"#he_count","objective":"editor"}},{"text":" 条指令）","color":"gray"}]
execute if score #temp editor matches 1 run tellraw @s [{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" 木板 #","color":"aqua"},{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"white"},{"text":"（共 ","color":"gray"},{"score":{"name":"#he_count","objective":"editor"}},{"text":" 条指令）","color":"gray"}]
execute if score #temp editor matches 2 run tellraw @s [{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" 唱片机 #","color":"aqua"},{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"white"},{"text":"（共 ","color":"gray"},{"score":{"name":"#he_count","objective":"editor"}},{"text":" 条指令）","color":"gray"}]
execute if score #temp editor matches 3 run tellraw @s [{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" 混凝土 #","color":"aqua"},{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"white"},{"text":"（共 ","color":"gray"},{"score":{"name":"#he_count","objective":"editor"}},{"text":" 条指令）","color":"gray"}]
execute if score #temp editor matches 4 run tellraw @s [{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" 染色玻璃 #","color":"aqua"},{"nbt":"editing.temp.id","storage":"rhythm_axe:maps.editor","color":"white"},{"text":"（共 ","color":"gray"},{"score":{"name":"#he_count","objective":"editor"}},{"text":" 条指令）","color":"gray"}]
tellraw @s [{"text":"","color":"gray"}]
# 指令列表（递归渲染，从 0 开始；行按钮值 10000+idx*10+off 由 panel 与 row_advance 算好传入 prop，宏行直接引用）
data modify storage rhythm_axe:prop idx set value 0
scoreboard players set #he_base editor 10000
execute store result storage rhythm_axe:prop he_edit int 1 run scoreboard players get #he_base editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 1
execute store result storage rhythm_axe:prop he_copy int 1 run scoreboard players get #he_tmp editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 2
execute store result storage rhythm_axe:prop he_paste int 1 run scoreboard players get #he_tmp editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 3
execute store result storage rhythm_axe:prop he_del int 1 run scoreboard players get #he_tmp editor
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop he_edit
data remove storage rhythm_axe:prop he_copy
data remove storage rhythm_axe:prop he_paste
data remove storage rhythm_axe:prop he_del
tellraw @s [{"text":"","color":"gray"}]
# 操作按钮
tellraw @s [{"text":"【添加指令】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 857"},"hover_event":{"action":"show_text","value":"在列表末尾追加一条空指令"}},{"text":"  【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 858"},"hover_event":{"action":"show_text","value":"丢弃修改并返回音符面板"}},{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 859"},"hover_event":{"action":"show_text","value":"把修改写回音符的击打特效（可撤销）"}}]