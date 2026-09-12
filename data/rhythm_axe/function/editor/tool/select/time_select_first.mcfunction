# 定入点：当前播放头 → time_select.in；清出点 + 清上一轮选中（开启新一轮），state=1
# 位置与注视方块无关（纯时间轴操作），故不读注视方块坐标
data modify storage rhythm_axe:maps.editor time_select.in set from storage rhythm_axe:maps.editor playhead
data remove storage rhythm_axe:maps.editor time_select.out
data modify storage rhythm_axe:maps.editor time_select.state set value 1
# 清上一轮选中（selected 标记 + selection + 黄光 + 交互实体标记）
function rhythm_axe:editor/menu/note/selected/sel_clear_all
execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
tellraw @s [{"text":"[编辑器] 入点已设为第 ","color":"yellow"},{"nbt":"time_select.in","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":" 刻（再蹲下右键一次定出点并选中区间内音符）","color":"yellow"}]
