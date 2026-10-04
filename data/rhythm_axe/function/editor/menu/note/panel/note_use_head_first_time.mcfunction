# 判定时间【使用当前时间】(12005) 相对模式辅助：取「选区中时间最早的音符」工作副本的 time → #uh_ref
# 依赖编辑约定：selection / batch_ids 按 notes 顺序升序（见 sel_rebuild / sel_add），故 [0] 即时间最早
# 只用 find_by_id 的临时 prop（cursor/index/note_id/found_index），用完清理
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop note_id set from storage rhythm_axe:maps.editor editing.batch_ids[0]
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/panel/note_use_head_first_time_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
