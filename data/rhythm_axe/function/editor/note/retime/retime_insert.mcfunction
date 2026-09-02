#arg:cursor,insert_index
# 在 insert_index 处插回摘出的音符
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes insert $(insert_index) from storage rhythm_axe:prop note_copy
