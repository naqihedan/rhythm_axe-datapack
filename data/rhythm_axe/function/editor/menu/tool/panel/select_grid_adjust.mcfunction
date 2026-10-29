# 选择工具网格尺寸选择（面板 23 行 225）：22501 = 0.1 / 22502 = 0.25 / 22503 = 0.5 / 22504 = 1
#   存 tool_opt.select_grid（0..3），与音符工具的 note_grid 相互独立
#   实际吸附在 editor/tool/select/select_grid_setup + editor/tool/note/grid_snap_axis
scoreboard players set select_grid tool_opt 3
execute if score #click_value editor matches 22501 run scoreboard players set select_grid tool_opt 0
execute if score #click_value editor matches 22502 run scoreboard players set select_grid tool_opt 1
execute if score #click_value editor matches 22503 run scoreboard players set select_grid tool_opt 2
execute if score #click_value editor matches 22504 run scoreboard players set select_grid tool_opt 3
# 重绘：选择工具选项栏（分组 5）
data modify storage rhythm_axe:maps.editor tool_panel_gid set value 5
function rhythm_axe:editor/menu/tool/panel/tool_panel