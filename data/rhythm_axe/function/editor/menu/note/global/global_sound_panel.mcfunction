# 全局击打音效面板：选组号（0-6），current_panel 12
# 备份在 consume 801 分发时做（进入时），刷新不覆盖备份
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 12
tellraw @s [{"text":"====全局音符击打音效====","color":"gold","bold":true}]
tellraw @s [{"text":"选择要编辑的组号（对应音符的 hitsound 值），点选后打开该组详情面板","color":"gray"}]
tellraw @s [\
{"text":"【0】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"查看并编辑组 0"}},\
{"text":"【1】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10101"},"hover_event":{"action":"show_text","value":"查看并编辑组 1"}},\
{"text":"【2】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10201"},"hover_event":{"action":"show_text","value":"查看并编辑组 2"}},\
{"text":"【3】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10301"},"hover_event":{"action":"show_text","value":"查看并编辑组 3"}},\
{"text":"【4】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10401"},"hover_event":{"action":"show_text","value":"查看并编辑组 4"}},\
{"text":"【5】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10501"},"hover_event":{"action":"show_text","value":"查看并编辑组 5"}},\
{"text":"【6】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10601"},"hover_event":{"action":"show_text","value":"查看并编辑组 6"}}\
]
tellraw @s [\
{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10701"},"hover_event":{"action":"show_text","value":"返回音符面板"}}\
]
