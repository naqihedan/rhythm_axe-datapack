# 全局击打视效面板：选组号（0-6），current_panel 13
# 备份在 consume 804 分发时做（进入时），刷新不覆盖备份
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 13
tellraw @s [{"text":"====全局音符击打视效====","color":"gold","bold":true}]
tellraw @s [{"text":"选择要编辑的组号（对应音符的 hit_particles 值），点选后打开该组详情面板","color":"gray"}]
tellraw @s [{"text":"你也可以修改editor/init.mcfunction来快速编辑","color":"gray"}]
tellraw @s [\
{"text":"【0】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 830"},"hover_event":{"action":"show_text","value":"查看并编辑组 0"}},\
{"text":"【1】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 831"},"hover_event":{"action":"show_text","value":"查看并编辑组 1"}},\
{"text":"【2】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 832"},"hover_event":{"action":"show_text","value":"查看并编辑组 2"}},\
{"text":"【3】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 833"},"hover_event":{"action":"show_text","value":"查看并编辑组 3"}},\
{"text":"【4】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 834"},"hover_event":{"action":"show_text","value":"查看并编辑组 4"}},\
{"text":"【5】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 835"},"hover_event":{"action":"show_text","value":"查看并编辑组 5"}},\
{"text":"【6】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 836"},"hover_event":{"action":"show_text","value":"查看并编辑组 6"}}\
]

tellraw @s [\
{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 837"},"hover_event":{"action":"show_text","value":"返回音符面板"}}\
]
