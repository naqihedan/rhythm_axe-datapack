#arg:cursor,index
# 比较：notes[$(index)].id == 目标 id → 记录 found_index；否则游标 +1 继续找
$execute store result score #note_index_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
execute store result score #target_id editor run data get storage rhythm_axe:prop note_id
execute if score #note_index_id editor = #target_id editor run function rhythm_axe:editor/util/id_apply with storage rhythm_axe:prop
execute unless score #note_index_id editor = #target_id editor run function rhythm_axe:editor/util/id_advance
