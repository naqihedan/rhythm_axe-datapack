# 音符生成检查（宏参数 note_idx）：每刻只检查游标指向的这一个音符
# 若音符存在则交给 spawn_one 判断出生时刻；匹配时由 spawn_one 负责游标+1与递归
# 不匹配时此处不做任何事，游标不动，下一刻 main_loop 会再次调用本函数检查同一音符
#arg: note_idx
$execute if data storage rhythm_axe:runtime notes[$(note_idx)].id run function rhythm_axe:play/note/spawn_one with storage rhythm_axe:runtime
