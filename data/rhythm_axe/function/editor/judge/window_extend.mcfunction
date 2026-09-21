# 真实判定模式：把普通音符（type 0..2）的存活窗口延长到 miss 时刻（time + 2x + 1）
# 输入：#n_type / #n_end（spawn 算好的消失刻）/ #ed_scale（当前时间点 judgement_scale）；输出：#n_end
# ★ 为什么 +1：tick_one 的清理条件是 playhead > editor_n_end，而 miss 判定在 life < -2x 时发生
#   （life = editor_n_time − playhead）⇒ miss 落在 playhead = time+2x+1。若 end = time+2x，
#   该刻会先被 tick_kill 清掉、根本走不到 judge → 漏 miss。故多留 1 刻给 judge 先判（判定后自行 kill）。
# ★ 混凝土(3)/玻璃(4) 不走这里：混凝土判定到 time+dur（阶段 2），玻璃零反馈。
# （自动预览模式 editor_note_judge=0 时本函数什么都不做，保持原窗口）
scoreboard players operation #n_wext editor = #ed_scale editor
scoreboard players operation #n_wext editor *= 2 const
scoreboard players add #n_wext editor 1
execute if score editor_note_judge options matches 1 if score #n_type editor matches 0..2 run scoreboard players operation #n_end editor += #n_wext editor
