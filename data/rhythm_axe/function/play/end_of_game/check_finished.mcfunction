# 「本局是否跑完全部谱面」判定 → 写进 rhythm_axe:runtime.finished（供结算写榜判断是否记成绩）
# 依据：谱面定义了 end_time 且当前 time 已走到（主循环正好在 time == end_time 调 end_of_game）；
#   手动 stop / 中途退出时 time 还没到 ⇒ finished=0b。
# 谱面没定义 end_time（老谱/测试谱）⇒ 无法判定，按「跑完」放行（与 map_check 的警告并存）。
# 单独成函数是为了能脱开整局结算单独实测（见《AI常见问题》的排查约定）。
scoreboard players set #finished play_state 1
scoreboard players set #eo_end play_state 0
execute if data storage rhythm_axe:runtime end_time run execute store result score #eo_end play_state run data get storage rhythm_axe:runtime end_time
execute if data storage rhythm_axe:runtime end_time if score time play_state < #eo_end play_state run scoreboard players set #finished play_state 0
execute store result storage rhythm_axe:runtime finished byte 1 run scoreboard players get #finished play_state
