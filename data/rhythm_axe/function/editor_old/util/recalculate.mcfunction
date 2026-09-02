# timeline_start = offset
# length = bar × beat_per_bar × tick_per_beat
# timeline_end = length + offset

scoreboard players operation length editor = bar editor
scoreboard players operation length editor *= beat_per_bar editor
scoreboard players operation length editor *= tick_per_beat editor

scoreboard players operation timeline_end editor = length editor
scoreboard players operation timeline_end editor += offset editor

# 注意：不要在 recalculate 中调用 scale！
# show_form 也会调用 recalculate，如果在其中启动 scale 会覆盖正在运行的 translate_index 动画。
# scale 由调用 recalculate 的上层函数根据需要显式调用。
