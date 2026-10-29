# 网格尺寸选择（面板 23 行 224）：22401 = 0.1 / 22402 = 0.25 / 22403 = 0.5 / 22404 = 1
#   存 tool_opt.note_grid（0..3），全局、跨谱面（与坐标锁定同板，不受【恢复默认】影响）
#   实际吸附在 editor/tool/note/grid_setup + grid_snap_axis（放置 / 光标玻璃）
scoreboard players set note_grid tool_opt 0
execute if score #click_value editor matches 22401 run scoreboard players set note_grid tool_opt 0
execute if score #click_value editor matches 22402 run scoreboard players set note_grid tool_opt 1
execute if score #click_value editor matches 22403 run scoreboard players set note_grid tool_opt 2
execute if score #click_value editor matches 22404 run scoreboard players set note_grid tool_opt 3
# 重绘本面板
function rhythm_axe:editor/menu/tool/panel/note