# 定第一角：存 corner1 + state=1（此后 cursor_tick 从第一角拉伸黄绿玻璃预览选区）
data modify storage rhythm_axe:maps.editor select_tool.corner1 set value [0.0d,0.0d,0.0d]
data modify storage rhythm_axe:maps.editor select_tool.corner1[0] set from storage rhythm_axe:prop sx
data modify storage rhythm_axe:maps.editor select_tool.corner1[1] set from storage rhythm_axe:prop sy
data modify storage rhythm_axe:maps.editor select_tool.corner1[2] set from storage rhythm_axe:prop sz
data modify storage rhythm_axe:maps.editor select_tool.state set value 1
tellraw @s [{"text":"[编辑器] 第一选取点已设为 ","color":"yellow"},{"nbt":"select_tool.corner1","storage":"rhythm_axe:maps.editor","color":"aqua"}]
