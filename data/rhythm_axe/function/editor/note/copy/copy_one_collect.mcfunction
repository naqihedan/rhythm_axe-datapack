#arg:cursor,found_index
# 收集音符本体与 id；并记录数组下标（剪切/批量剪切/批量删除的删除阶段要用，升序 → 删除时从后往前）
$data modify storage rhythm_axe:maps.editor clipboard.notes append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)]
# 剔除 selected：复制/粘贴的新音符不应继承选中状态（selected 是编辑器状态，非音符本身数据）
data remove storage rhythm_axe:maps.editor clipboard.notes[-1].selected
$data modify storage rhythm_axe:maps.editor clipboard.note_ids append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)].id
$data modify storage rhythm_axe:maps.editor clipboard.found_indices append value $(found_index)
