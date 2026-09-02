#arg:cursor
# 撤销标签：labels[cursor]（字符串）读不到则用 last_label 兜底
$execute if data storage rhythm_axe:maps.editor history_labels[$(cursor)] run data modify storage rhythm_axe:prop lb set from storage rhythm_axe:maps.editor history_labels[$(cursor)]
execute unless data storage rhythm_axe:prop lb run data modify storage rhythm_axe:prop lb set from storage rhythm_axe:maps.editor last_label
execute if data storage rhythm_axe:prop lb run function rhythm_axe:editor/file/undo_label_go with storage rhythm_axe:prop
data remove storage rhythm_axe:prop lb
