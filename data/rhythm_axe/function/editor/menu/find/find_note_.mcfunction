#arg:cursor,index
# 查找音符遍历：id == #target_id 输出 time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run function rhythm_axe:editor/menu/find/find_note_cmp with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run return 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/find/find_note_ with storage rhythm_axe:prop
