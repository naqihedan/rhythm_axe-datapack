#arg:cursor,index,list_name
# 比较：元素 time > 新 time → 在此插入；否则游标 +1 继续找
$execute store result score #insert_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)].time
execute store result score #new_time editor run data get storage rhythm_axe:prop new_time
execute if score #insert_time editor > #new_time editor run function rhythm_axe:editor/util/insert_mark_insert with storage rhythm_axe:prop
execute if score #insert_time editor <= #new_time editor run function rhythm_axe:editor/util/insert_advance
