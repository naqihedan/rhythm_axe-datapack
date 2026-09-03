# 删除音符：前置 prop.note_id（音符 id）；先查找再 begin/commit（未找到不产生快照）
execute unless data storage rhythm_axe:prop note_id run tellraw @s [{"text":"[编辑器] 缺少音符 id（prop.note_id）","color":"red"}]
execute unless data storage rhythm_axe:prop note_id run return fail

data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 未找到该音符","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail

function rhythm_axe:editor/file/begin
function rhythm_axe:editor/note/delete/delete_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
tellraw @s [{"text":"[编辑器] 已删除音符 ","color":"green"},{"nbt":"note_id","storage":"rhythm_axe:prop","color":"aqua"}]

# 从 selection 移除已删除音符的 id（已选中列表/批量计数不再包含删除的音符）
execute if data storage rhythm_axe:maps.editor selection run execute store result score #rm_id editor run data get storage rhythm_axe:prop note_id
execute if data storage rhythm_axe:maps.editor selection run data modify storage rhythm_axe:prop rm_out set value []
execute if data storage rhythm_axe:maps.editor selection run data modify storage rhythm_axe:prop rm_idx set value 0
execute if data storage rhythm_axe:maps.editor selection run function rhythm_axe:editor/menu/note/selected/sel_remove_drive
execute if data storage rhythm_axe:maps.editor selection run data remove storage rhythm_axe:prop rm_out
execute if data storage rhythm_axe:maps.editor selection run data remove storage rhythm_axe:prop rm_idx
# 同步 #sel_count（从 selection 长度重算）
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection

data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop cursor
