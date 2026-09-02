# 时间点列表：遍历 timing_points 逐行显示 + 【新增一个时间点】+【返回】
# 剪贴板会话：打开列表即清空本面板剪贴板（复制内容只在本会话内有效，离开面板再进入即失效）
data remove storage rhythm_axe:maps.editor timing_clip
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 3
tellraw @s [{"text":"====时间点列表====","color":"gold","bold":true}]
# 宏参数：cursor = history 游标、index = 行号（edit_val 由行函数按 201+行号 计算）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/timing/list/timing_list_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
data remove storage rhythm_axe:prop is_red
data remove storage rhythm_axe:prop prev
tellraw @s [\
{"text":"【新增一个时间点】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 280"},"hover_event":{"action":"show_text","value":"在播放头位置新增时间点"}},\
{"text":"  【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}\
]
