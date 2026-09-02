# 初始化倒序删除游标（最后一个索引 = 长度 - 1）
execute store result score #remove_count editor run data get storage rhythm_axe:maps.editor clipboard.found_indices
scoreboard players remove #remove_count editor 1
execute store result storage rhythm_axe:prop remove_index int 1 run scoreboard players get #remove_count editor
function rhythm_axe:editor/note/cut/cut_remove with storage rhythm_axe:prop
