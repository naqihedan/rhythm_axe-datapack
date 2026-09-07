#arg:cursor,found_index
# 收集音符本体与 id；剪切模式额外记录删除索引（升序，删除时从后往前）
$data modify storage rhythm_axe:maps.editor clipboard.notes append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)]
# 剔除 selected：复制/粘贴的新音符不应继承选中状态（selected 是编辑器状态，非音符本身数据）
data remove storage rhythm_axe:maps.editor clipboard.notes[-1].selected
$data modify storage rhythm_axe:maps.editor clipboard.note_ids append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)].id
$execute if data storage rhythm_axe:prop {clip_action:"cut"} run data modify storage rhythm_axe:maps.editor clipboard.found_indices append value $(found_index)
