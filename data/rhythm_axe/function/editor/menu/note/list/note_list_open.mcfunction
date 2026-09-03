# 音符列表：只显示当前存活的音符（每行 4 按钮，按钮值按存活序 600/640/680/720+序）
# 剪贴板会话：打开列表即清空本面板剪贴板（复制内容只在本会话内有效，离开面板再进入即失效）
data remove storage rhythm_axe:maps.editor note_clip
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 10
tellraw @s [{"text":"=====当前活跃音符列表=====","color":"gold","bold":true}]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #note_alive editor 0
# ★ 2026-08-25 重构：由普通函数驱动器 note_list_row_advance 驱动遍历（宏行是叶子，不递归）
# 两次遍历：先未选中，再选中（选中音符置底显示）
scoreboard players set #list_pass editor 0
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/note/list/note_list_row_advance
scoreboard players set #list_pass editor 1
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/note/list/note_list_row_advance
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
# 批量编辑选中音符 / 取消选中（仅有选中时显示）
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
execute if score #sel_count editor matches 1.. run tellraw @s [{"text":"【批量编辑选中音符】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1562"},"hover_event":{"action":"show_text","value":"对选中的音符批量编辑（相对增量）"}}]
execute if score #sel_count editor matches 1.. run tellraw @s [{"text":"【批量复制】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1641"},"hover_event":{"action":"show_text","value":"把选中音符的字段存入剪贴板"}}]
execute if score #sel_count editor matches 1.. run tellraw @s [{"text":"【批量粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 1642"},"hover_event":{"action":"show_text","value":"把剪贴板音符粘贴到播放头"}}]
execute if score #sel_count editor matches 1.. run tellraw @s [{"text":"【取消选中】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 1640"},"hover_event":{"action":"show_text","value":"取消所有选中（不退出列表）"}}]
# 返回
tellraw @s [{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}]
