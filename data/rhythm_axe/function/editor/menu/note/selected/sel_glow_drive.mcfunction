# 遍历 selection，对每个选中音符补光（@s = 玩家）
# 前置: prop.glow_idx；整体重建后调用，恢复被选中音符的黄色高亮
execute store result score #sel_n editor run data get storage rhythm_axe:maps.editor selection
execute store result score #glow_i editor run data get storage rhythm_axe:prop glow_idx
execute if score #glow_i editor >= #sel_n editor run return 0
function rhythm_axe:editor/menu/note/selected/sel_glow_leaf with storage rhythm_axe:prop
scoreboard players add #glow_i editor 1
execute store result storage rhythm_axe:prop glow_idx int 1 run scoreboard players get #glow_i editor
execute if score #glow_i editor < #sel_n editor run function rhythm_axe:editor/menu/note/selected/sel_glow_drive
