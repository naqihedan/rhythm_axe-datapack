#arg:cursor,i
# 读当前音符 id → prop.nid（供判断/追加用）
$execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
