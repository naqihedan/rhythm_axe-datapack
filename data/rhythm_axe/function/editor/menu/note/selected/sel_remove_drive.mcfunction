# 重建 selection，跳过 id==#rm_id 的元素（@s = 玩家）
# 前置: prop.rm_idx；结束时把 prop.rm_out 写回 maps.editor.selection
execute store result score #sel_n editor run data get storage rhythm_axe:maps.editor selection
execute store result score #rm_i editor run data get storage rhythm_axe:prop rm_idx
# 越界 → 完成：把 rm_out 写回 selection
execute if score #rm_i editor >= #sel_n editor run data modify storage rhythm_axe:maps.editor selection set from storage rhythm_axe:prop rm_out
execute if score #rm_i editor >= #sel_n editor run return 0
function rhythm_axe:editor/menu/note/selected/sel_remove_leaf with storage rhythm_axe:prop
scoreboard players add #rm_i editor 1
execute store result storage rhythm_axe:prop rm_idx int 1 run scoreboard players get #rm_i editor
# 继续递归；若已到末尾（#rm_i >= #sel_n），此调用即为最后一次，写回 rm_out
execute if score #rm_i editor < #sel_n editor run function rhythm_axe:editor/menu/note/selected/sel_remove_drive
execute if score #rm_i editor >= #sel_n editor run data modify storage rhythm_axe:maps.editor selection set from storage rhythm_axe:prop rm_out
