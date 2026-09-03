# 已选定音符列表（面板 18）：显示被选区选中的音符（selection[]，按 time 升序），每行复用 note_list_line（按钮值 1400 段）
# 打开即确认选择内容；【返回】(1560) 清空 selection + 音符高亮
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 18
tellraw @s [{"text":"=====已选定音符列表=====","color":"gold","bold":true}]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop sel_index set value 0
function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop sel_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
data remove storage rhythm_axe:prop sel_val
data remove storage rhythm_axe:prop checkbox
tellraw @s [{"text":"【批量编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1562"},"hover_event":{"action":"show_text","value":"对选中的音符批量编辑（相对增量）"}}]
tellraw @s [{"text":"【批量复制】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1563"},"hover_event":{"action":"show_text","value":"把选中音符的字段存入剪贴板"}}]
tellraw @s [{"text":"【批量粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 1564"},"hover_event":{"action":"show_text","value":"把剪贴板音符粘贴到播放头"}}]
tellraw @s [{"text":"【清空选中并返回】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 1561"},"hover_event":{"action":"show_text","value":"清空 selection 与音符高亮并返回主菜单"}}]
tellraw @s [{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1560"},"hover_event":{"action":"show_text","value":"返回主菜单（保留选择）"}}]
