#arg:cursor,insert_index,new_id,new_time,paste_index
# 在 insert_index 处插入剪贴板第 $(paste_index) 个音符副本，并覆盖 id 与 time
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes insert $(insert_index) from storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)]
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(insert_index)].id set value $(new_id)
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(insert_index)].time set value $(new_time)
# 粘贴不继承选中状态（selected 是编辑器状态，非音符数据）
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(insert_index)].selected
