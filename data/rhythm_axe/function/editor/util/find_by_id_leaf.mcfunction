#arg:cursor,index
# 按 id 查找的"叶子"（宏）：只处理当前这一个音符，不递归。
# #find_done：1=命中（写 found_index） 2=元素缺失（遍历结束） 0=未命中继续
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run scoreboard players set #find_done editor 2
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run execute store result score #note_index_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run execute store result score #target_id editor run data get storage rhythm_axe:prop note_id
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] if score #note_index_id editor = #target_id editor run data modify storage rhythm_axe:prop found_index set from storage rhythm_axe:prop index
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] if score #note_index_id editor = #target_id editor run scoreboard players set #find_done editor 1
