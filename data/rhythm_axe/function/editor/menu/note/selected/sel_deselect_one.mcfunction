#arg:cursor,idx
# 取消选中：移除音符的 selected 标记
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected
