#arg:cursor,paste_index
# 剪贴板音符逐个粘贴：新时间 = 原 time + 偏移，重新分配 id，按 time 升序插入
$execute unless data storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)] run function rhythm_axe:editor/note/paste/paste_done
# ★ 终止分支必须 return 0（否则 paste_done 后继续执行剩余行 → 游标+1 → 无限递归 → 200000 超限）
$execute unless data storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)] run return 0

# 计算新时间（原时间 + 偏移）
$execute store result score #paste_time editor run data get storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)].time
execute store result score #time_offset editor run data get storage rhythm_axe:prop time_offset
scoreboard players operation #paste_time editor += #time_offset editor
execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #paste_time editor

# 分配新 id
execute store result score #new_id editor run data get storage rhythm_axe:maps.editor next_note_id
execute store result storage rhythm_axe:prop new_id int 1 run scoreboard players get #new_id editor
scoreboard players add #new_id editor 1
execute store result storage rhythm_axe:maps.editor next_note_id int 1 run scoreboard players get #new_id editor

# 按 time 升序插入
data modify storage rhythm_axe:prop list_name set value "notes"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"append"} run function rhythm_axe:editor/note/paste/paste_apply_append with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"insert"} run function rhythm_axe:editor/note/paste/paste_apply_insert with storage rhythm_axe:prop

# 游标 +1 后粘贴下一个
execute store result score #paste_count editor run data get storage rhythm_axe:prop paste_index
scoreboard players add #paste_count editor 1
execute store result storage rhythm_axe:prop paste_index int 1 run scoreboard players get #paste_count editor
function rhythm_axe:editor/note/paste/paste_one with storage rhythm_axe:prop
