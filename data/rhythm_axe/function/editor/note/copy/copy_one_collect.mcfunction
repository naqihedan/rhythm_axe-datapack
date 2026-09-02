#arg:cursor,found_index
# 收集音符本体与 id；剪切模式额外记录删除索引（升序，删除时从后往前）
$data modify storage rhythm_axe:maps.editor clipboard.notes append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)]
$data modify storage rhythm_axe:maps.editor clipboard.note_ids append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)].id
$execute if data storage rhythm_axe:prop {clip_action:"cut"} run data modify storage rhythm_axe:maps.editor clipboard.found_indices append value $(found_index)
