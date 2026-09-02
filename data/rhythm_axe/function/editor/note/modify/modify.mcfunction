# 修改音符字段：前置 prop.note_id + prop.note_fields（只 merge 传入的字段，不含 time）
# 改判定时间请用 editor/note/retime/retime（保持 notes 按 time 升序）
execute unless data storage rhythm_axe:prop note_id run tellraw @s [{"text":"[编辑器] 缺少音符 id（prop.note_id）","color":"red"}]
execute unless data storage rhythm_axe:prop note_id run return fail
execute if data storage rhythm_axe:prop note_fields.time run tellraw @s [{"text":"[编辑器] 判定时间请用 note/retime 修改","color":"red"}]
execute if data storage rhythm_axe:prop note_fields.time run return fail

# 查找目标音符（未找到不产生快照）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 未找到该音符","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail

# 修改并提交
function rhythm_axe:editor/file/begin
function rhythm_axe:editor/note/modify/modify_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
tellraw @s [{"text":"[编辑器] 已修改音符 ","color":"green"},{"nbt":"note_id","storage":"rhythm_axe:prop","color":"aqua"}]

# 清理 prop
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop note_fields
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop cursor
