#arg:cursor,remove_target
# 删除 notes[$(remove_target)] 并继续倒序删除
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(remove_target)]
function rhythm_axe:editor/note/cut/cut_remove_advance with storage rhythm_axe:prop
