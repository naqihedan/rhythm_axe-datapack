# 真正启动（由 good2384 的 running 守护调用一次）
execute unless data storage rhythm_axe:g2384 on run scoreboard objectives add g2384_t dummy
execute unless data storage rhythm_axe:g2384 on run scoreboard objectives add g2384_y dummy
data merge storage rhythm_axe:g2384 {on:1b, running:1b}
scoreboard players set #g2384_left g2384_t 64
function rhythm_axe:maps/goodworld/good2384_6
