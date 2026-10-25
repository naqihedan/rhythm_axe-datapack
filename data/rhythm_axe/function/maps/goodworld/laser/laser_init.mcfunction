scoreboard objectives add laser_time dummy "激光特效寿命"

# ── 硬重置：清掉上一轮遗留，否则旧实体 / 计数值 / running 标记都会污染本轮 ──
# ① 旧激光实体：上一轮若被中途打断，没死透的实体不会自己消失 ⇒ 会混进这一批
kill @e[tag=laser]
# ② 兜底计时 i：归零，否则上一轮遗留的刻数会让兜底上限提前触发
scoreboard players set i laser_time 0
# ③ running 标记：保证本轮一定重新排程 tick
#    （schedule 同名函数是 replace 语义，重复排程也只会留一个，不会双倍触发）
data remove storage rhythm_axe:laser running

# 启动计时器
schedule function rhythm_axe:maps/goodworld/laser/laser_queue_tick 1t
data modify storage rhythm_axe:laser running set value 1b

function rhythm_axe:maps/goodworld/laser/laser_main