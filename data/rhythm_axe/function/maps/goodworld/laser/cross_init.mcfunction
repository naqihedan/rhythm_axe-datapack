# 叉号入口：每 2 刻一个、共 128 刻（64 个）
scoreboard objectives add cross_time dummy "叉号寿命"
# 硬重置：清掉上一轮可能残留下来的实体（否则会混进这一批）
kill @e[tag=cross]
scoreboard players set #cr_shot cross_time 0
function rhythm_axe:maps/goodworld/laser/cross_main
