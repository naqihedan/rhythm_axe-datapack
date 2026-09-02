#arg:cursor,index
# 比较音符的 id 与查找目标，匹配则输出 id 与 time
$execute store result score #note_index_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
$execute if score #note_index_id editor = #target_id editor run tellraw @s [{"text":"[查找] 音符 id ","color":"green"},{"score":{"name":"#note_index_id","objective":"editor"},"color":"aqua"},{"text":"：time ","color":"gray"},{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"}]
