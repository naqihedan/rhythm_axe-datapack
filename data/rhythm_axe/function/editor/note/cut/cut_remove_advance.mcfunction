#arg:cursor,remove_index
# remove_index 到 0 → 删除完成；否则游标 -1 继续
execute store result score #remove_count editor run data get storage rhythm_axe:prop remove_index
execute if score #remove_count editor matches 0 run function rhythm_axe:editor/note/cut/cut_finish
execute unless score #remove_count editor matches 0 run function rhythm_axe:editor/note/cut/cut_remove_prev with storage rhythm_axe:prop
