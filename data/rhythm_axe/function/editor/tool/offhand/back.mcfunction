# 从工具选项栏返回"上一个不是工具选项栏的面板"。
# 由【返回】按钮（值 1）或"同一个工具再次放进副手"触发。
scoreboard players set #tp_prev editor 1
execute store result score #tp_prev editor run data get storage rhythm_axe:maps.editor tool_panel_prev
data remove storage rhythm_axe:maps.editor tool_panel_gid
data remove storage rhythm_axe:maps.editor tool_panel_prev
execute store result storage rhythm_axe:maps.editor current_panel int 1 run scoreboard players get #tp_prev editor
function rhythm_axe:editor/menu/resume
