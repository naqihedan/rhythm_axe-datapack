# 音符生成检查（宏参数 note_idx）：每刻只检查游标指向的这一个音符
# 若音符存在则交给 spawn_one 判断出生时刻；匹配时由 spawn_one 负责游标+1与递归
# 不匹配时此处不做任何事，游标不动，下一刻 main_loop 会再次调用本函数检查同一音符
# ★ 2026-09-13 哨兵重置（同 event/advance 的 cur_cmd 残留同类问题）：
#   #birth 是 store result 残留分数，而「刷新 #birth」在 spawn_one 内（守卫 if data notes[]._birth）、
#   「用 #birth 判定」在 spawn_one 里（守卫 if score #birth = time）——两者是**不同**的守卫。
#   游标越界后 spawn_one 不再被调用，#birth 会一直保留最后一个音符的 _birth（跨局也不清）；
#   一旦某刻 time 恰好等于该残留值（游标已越界、音符早就生成完的新局），
#   就会用残留的 cur_note 再 summon 一个重复音符。
#   解法：每刻先置哨兵（int 上限，永不等于 time），只有真正读到 _birth 才会被覆盖。
#arg: note_idx
scoreboard players set #birth play_state 2147483647
$execute if data storage rhythm_axe:runtime notes[$(note_idx)].id run function rhythm_axe:play/note/spawn_one with storage rhythm_axe:runtime
