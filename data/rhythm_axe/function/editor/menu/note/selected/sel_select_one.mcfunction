#arg:cursor,idx
# 选中：给工作副本音符加 selected:1b
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)] merge value {selected:1b}
