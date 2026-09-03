# 清理 selection：仅保留 find_by_id 能找到的有效音符 id（@s = 玩家）
# 用途：批量编辑/已选中列表打开前，剔除已被删除但仍残留在 selection 里的音符 id，保证计数一致
# 前置: prop.slc_idx；结束时把 prop.slc_out 写回 maps.editor.selection
execute store result score #sel_n editor run data get storage rhythm_axe:maps.editor selection
execute store result score #slc_i editor run data get storage rhythm_axe:prop slc_idx
# 越界 → 完成：把 slc_out 写回 selection
execute if score #slc_i editor >= #sel_n editor run data modify storage rhythm_axe:maps.editor selection set from storage rhythm_axe:prop slc_out
execute if score #slc_i editor >= #sel_n editor run return 0
function rhythm_axe:editor/menu/note/selected/sel_clean_leaf with storage rhythm_axe:prop
scoreboard players add #slc_i editor 1
execute store result storage rhythm_axe:prop slc_idx int 1 run scoreboard players get #slc_i editor
# 继续递归；若已到末尾（#slc_i >= #sel_n），此调用即为最后一次，写回 slc_out
execute if score #slc_i editor < #sel_n editor run function rhythm_axe:editor/menu/note/selected/sel_clean_drive
execute if score #slc_i editor >= #sel_n editor run data modify storage rhythm_axe:maps.editor selection set from storage rhythm_axe:prop slc_out
