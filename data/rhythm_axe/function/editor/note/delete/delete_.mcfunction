#arg:cursor,found_index
# 删除 notes[$(found_index)] 处的音符
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)]
