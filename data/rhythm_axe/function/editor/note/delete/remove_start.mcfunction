# 删除引擎入口（中立原语）：收集已完成（clipboard.found_indices 升序）→ begin 快照 → 从后往前删除原音符
# 剪切 / 批量剪切 / 批量删除 三种操作都走这里；收尾由 remove_finish 按 prop.clip_action 分派
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor

# 没有收集到任何音符（id 全部未找到）→ 直接结束，防止空索引误删
execute unless data storage rhythm_axe:maps.editor clipboard.found_indices[0] run function rhythm_axe:editor/note/delete/remove_finish
execute if data storage rhythm_axe:maps.editor clipboard.found_indices[0] run function rhythm_axe:editor/note/delete/remove_count
