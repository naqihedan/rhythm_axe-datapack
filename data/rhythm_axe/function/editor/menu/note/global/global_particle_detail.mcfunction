# 全局击打视效详情面板：当前组 0-6，逐项显示当前值并提供单项编辑
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 13
execute store result score #group editor run data get storage rhythm_axe:prop particle_group
execute store result storage rhythm_axe:prop group int 1 run scoreboard players get #group editor

tellraw @s [{"text":"====全局音符击打视效#","color":"gold","bold":true},{"score":{"name":"#group","objective":"editor"}},{"text":"====","color":"gold","bold":true}]

data modify storage rhythm_axe:prop label set value "spawn"
data modify storage rhythm_axe:prop case set value "spawn"
data modify storage rhythm_axe:prop color set value "yellow"
data modify storage rhythm_axe:prop edit set value 840
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "tick"
data modify storage rhythm_axe:prop case set value "tick"
data modify storage rhythm_axe:prop color set value "light_purple"
data modify storage rhythm_axe:prop edit set value 841
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "bad"
data modify storage rhythm_axe:prop case set value "bad"
data modify storage rhythm_axe:prop color set value "aqua"
data modify storage rhythm_axe:prop edit set value 842
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "good_early"
data modify storage rhythm_axe:prop case set value "good_early"
data modify storage rhythm_axe:prop color set value "green"
data modify storage rhythm_axe:prop edit set value 843
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "perfect_early"
data modify storage rhythm_axe:prop case set value "perfect_early"
data modify storage rhythm_axe:prop color set value "yellow"
data modify storage rhythm_axe:prop edit set value 844
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "perfect"
data modify storage rhythm_axe:prop case set value "perfect"
data modify storage rhythm_axe:prop color set value "gold"
data modify storage rhythm_axe:prop edit set value 845
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "perfect_late"
data modify storage rhythm_axe:prop case set value "perfect_late"
data modify storage rhythm_axe:prop color set value "yellow"
data modify storage rhythm_axe:prop edit set value 846
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "good_late"
data modify storage rhythm_axe:prop case set value "good_late"
data modify storage rhythm_axe:prop color set value "green"
data modify storage rhythm_axe:prop edit set value 847
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "miss"
data modify storage rhythm_axe:prop case set value "miss"
data modify storage rhythm_axe:prop color set value "gray"
data modify storage rhythm_axe:prop edit set value 848
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop
data modify storage rhythm_axe:prop label set value "damage"
data modify storage rhythm_axe:prop case set value "damage"
data modify storage rhythm_axe:prop color set value "red"
data modify storage rhythm_axe:prop edit set value 849
function rhythm_axe:editor/menu/note/global/global_particle_detail_case with storage rhythm_axe:prop

tellraw @s [\
{"text":"【确定】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 850"},"hover_event":{"action":"show_text","value":"保存当前组并返回音符面板"}},\
{"text":"  【取消】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 851"},"hover_event":{"action":"show_text","value":"返回全局视效组选择面板"}}\
]
