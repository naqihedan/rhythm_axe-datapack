#arg:cursor,index
# 时间轴翻转应用单个音符（宏叶子）：读 history[$(cursor)].notes[$(index)]（此时 $(index)=found_index）→
#   算 new_time=min+max-old → 改 tmp_elem.time → 移除原元素 → 按 new_time 重插（仅改 time，其它字段原样）
$data modify storage rhythm_axe:prop tmp_elem set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
$execute store result score #old_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
# new_time = min + max - old_time（钳下界 0）
scoreboard players operation #new_t editor = #flip_min editor
scoreboard players operation #new_t editor += #flip_max editor
scoreboard players operation #new_t editor -= #old_t editor
execute if score #new_t editor matches ..-1 run scoreboard players set #new_t editor 0
execute store result storage rhythm_axe:prop tmp_elem.time int 1 run scoreboard players get #new_t editor
# 移除原元素
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
# 按 new_time 重插（insert_find 从 0 扫描；与 note_panel_confirm_ 同款，保持数组按 time 升序）
execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #new_t editor
data modify storage rhythm_axe:prop list_name set value "notes"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_at with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_append with storage rhythm_axe:prop
# 清理本音符临时字段
data remove storage rhythm_axe:prop tmp_elem
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
