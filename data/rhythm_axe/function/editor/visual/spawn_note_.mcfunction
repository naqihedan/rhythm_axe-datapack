# 音符生成检查（宏参数 note_idx，来自 prop）：音符存在才继续，不存在则链终止
#arg: cursor, note_idx
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run function rhythm_axe:editor/visual/spawn_one_ with storage rhythm_axe:prop
