# 音符列表：只显示当前存活的音符（每行 4 按钮，按钮值按存活序 600/640/680/720+序）
# 剪贴板会话：打开列表即清空本面板剪贴板（复制内容只在本会话内有效，离开面板再进入即失效）
data remove storage rhythm_axe:maps.editor note_clip
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 10
tellraw @s [{"text":"=====当前活跃音符列表=====","color":"gold","bold":true}]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
scoreboard players set #note_alive editor 0
# ★ 2026-08-25 重构：由普通函数驱动器 note_list_row_advance 驱动遍历（宏行是叶子，不递归）
function rhythm_axe:editor/menu/note/list/note_list_row_advance
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
# 返回
tellraw @s [{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}]
