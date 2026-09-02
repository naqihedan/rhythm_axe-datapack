#arg:cursor
# 追加摘出的音符到 notes 末尾
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes append from storage rhythm_axe:prop note_copy
