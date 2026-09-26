# 判定延迟补偿 · 线性音符分支（@s = 音符交互实体，tag=note_linear；#st_lag = 要回退的刻数）
# 线性音符的视觉位置有闭式公式，直接让 move_self 把进度 t 再减 #st_lag 重算位置即可（精确、无需历史）。
#   t 的下界钳制（0）会把「还没开始飞」退回出生位置；上界钳制（note_lin_dur）会停在终点
#   ⇒ 出生前 / 抵达判定位置后都自动落在正确位置，不需要额外分支。

scoreboard players operation #lag_extra play_state = #st_lag play_state
function rhythm_axe:play/active_note/move_self
scoreboard players set #lag_extra play_state 0
