#arg:cursor,index
# 确认写入：移除原音符后按新 time 升序重插
data modify storage rhythm_axe:prop tmp_elem set from storage rhythm_axe:maps.editor editing.temp
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
execute store result storage rhythm_axe:prop new_time int 1 run data get storage rhythm_axe:maps.editor editing.temp.time
data modify storage rhythm_axe:prop list_name set value "notes"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_at with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_append with storage rhythm_axe:prop
