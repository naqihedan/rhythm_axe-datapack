#arg:cursor,new_id,new_time,paste_index
# 追加剪贴板第 $(paste_index) 个音符副本到 notes 末尾，并覆盖 id 与 time
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes append from storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)]
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[-1].id set value $(new_id)
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[-1].time set value $(new_time)
# 粘贴不继承选中状态（selected 是编辑器状态，非音符数据）
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[-1].selected
