#arg:cursor,found_index
# 摘出音符到 prop.note_copy 并从列表移除
$data modify storage rhythm_axe:prop note_copy set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)]
