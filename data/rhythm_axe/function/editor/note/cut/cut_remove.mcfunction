#arg:cursor,remove_index
# 读出要删的 notes 索引（写入 prop 后交由 apply 宏删除）
$execute store result storage rhythm_axe:prop remove_target int 1 run data get storage rhythm_axe:maps.editor clipboard.found_indices[$(remove_index)]
function rhythm_axe:editor/note/cut/cut_remove_apply with storage rhythm_axe:prop
