# 播放新出生检查（宏参数 note_idx）：音符存在才继续，不存在则链终止
#arg: cursor, note_idx
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run function rhythm_axe:editor/visual/tick_birth_one_ with storage rhythm_axe:prop
