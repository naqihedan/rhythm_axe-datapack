# 发射队首任务：把 queue[0] 当作宏参数（含 x / angle）传给 laser_summon，再弹出。
function rhythm_axe:maps/goodworld/laser/laser_summon with storage rhythm_axe:laser queue[0]
data remove storage rhythm_axe:laser queue[0]

# ── 同刻连发 ──
# 弹出后若「新的队首」也已到点（delay ≤ 0），同一刻继续发。
# ⇒ 连续的 delay:0 会真正同刻齐发；delay:1 则仍是隔 1 刻。
# （#q2 与 tick 里的 #q 分开，避免相互覆盖）
scoreboard players set #q2 laser_time 0
execute if data storage rhythm_axe:laser queue[0] run \
    execute store result score #q2 laser_time run data get storage rhythm_axe:laser queue[0].delay
execute if data storage rhythm_axe:laser queue[0] if score #q2 laser_time matches ..0 run \
    function rhythm_axe:maps/goodworld/laser/laser_queue_fire
