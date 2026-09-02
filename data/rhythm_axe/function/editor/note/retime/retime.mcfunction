# 移动音符到新判定时间：前置 prop.note_id + prop.time（新判定时间刻）
# 摘出原音符 → 改 time → 按 time 升序重新插入（id 不变）
execute unless data storage rhythm_axe:prop note_id run tellraw @s [{"text":"[编辑器] 缺少音符 id（prop.note_id）","color":"red"}]
execute unless data storage rhythm_axe:prop note_id run return fail
execute unless data storage rhythm_axe:prop time run tellraw @s [{"text":"[编辑器] 缺少时间（prop.time）","color":"red"}]
execute unless data storage rhythm_axe:prop time run return fail

# 查找目标音符（未找到不产生快照）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 未找到该音符","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail

# 类型规范化（宏展开输出正确 NBT 后缀）
execute store result storage rhythm_axe:prop time int 1 run data get storage rhythm_axe:prop time

# 摘出音符并改时间
function rhythm_axe:editor/file/begin
function rhythm_axe:editor/note/retime/retime_copy with storage rhythm_axe:prop
function rhythm_axe:editor/note/retime/retime_set_time with storage rhythm_axe:prop

# 按新 time 升序插入
data modify storage rhythm_axe:prop list_name set value "notes"
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop time
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"append"} run function rhythm_axe:editor/note/retime/retime_append with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"insert"} run function rhythm_axe:editor/note/retime/retime_insert with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
tellraw @s [{"text":"[编辑器] 已移动音符 ","color":"green"},{"nbt":"note_id","storage":"rhythm_axe:prop","color":"aqua"},{"text":" → ","color":"green"},{"nbt":"time","storage":"rhythm_axe:prop","color":"aqua"},{"text":"刻","color":"green"}]

# 清理 prop
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop note_copy
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop cursor
