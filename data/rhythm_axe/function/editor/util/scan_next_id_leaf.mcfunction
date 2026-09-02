#arg: cursor, idx
# 扫描"叶子"（宏）：读取当前音符 id，若大于 #next_max 则更新
# #scan_note_total = notes 长度（供驱动器判断越界）；#scan_cur_id = 当前音符 id
scoreboard players set #scan_note_total editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes run execute store result score #scan_note_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].id run execute store result score #scan_cur_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].id
execute if score #scan_cur_id editor > #next_max editor run scoreboard players operation #next_max editor = #scan_cur_id editor
