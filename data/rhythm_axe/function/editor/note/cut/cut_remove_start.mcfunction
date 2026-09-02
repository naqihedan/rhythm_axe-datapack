# 剪切收集完：begin 后从后往前删除原音符（found_indices 升序，倒序删除避免索引漂移）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor

# 没有收集到任何音符（id 全部未找到）→ 直接结束，防止空索引误删
execute unless data storage rhythm_axe:maps.editor clipboard.found_indices[0] run function rhythm_axe:editor/note/cut/cut_finish
execute if data storage rhythm_axe:maps.editor clipboard.found_indices[0] run function rhythm_axe:editor/note/cut/cut_remove_count
