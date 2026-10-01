# 逐人写回最高分（入口）。调用前 prop.mapid / prop.score / prop.health / prop.write 就绪：
#   prop.write = 1b → 手动模式且**跑完全部谱面**：比较并写回 rhythm_axe:scores.<key>.<mapid>，首次记录时登记进 scores_index
#   prop.write = 0b → auto 模式 或 中途结束（没跑完）：只读不写，仅把历史最高显示出来
# 名单 runtime.hs_players 由 end_of_game 在 team leave 之前采集（play/highscore/collect_）。
scoreboard players set highest_score play_state 0
scoreboard players set #hs_n play_state 0
execute store result score #hs_n play_state run data get storage rhythm_axe:runtime hs_players
scoreboard players set #hs_i play_state 0
execute if score #hs_n play_state matches 1.. run function rhythm_axe:play/highscore/write_drive
# 自检：名单数 0 = 本局没有任何人被采集到（身份读取失败 / 采集时没有玩家）→ 明示，
#   否则玩家只会看到「最高记录 0」却不知道为什么（2026-10-01 用户实测踩到）
#   没跑完的局已经有另一条提示（score_calculate），这里不再刷屏
execute if score #hs_n play_state matches 0 if data storage rhythm_axe:runtime {finished:1b} run tellraw @a [{"text":"[排行榜] ","color":"gold"},{"text":"本局没有采集到玩家身份，成绩未写入排行榜","color":"red"}]
execute if score #hs_n play_state matches 1.. if score debug_output options matches 1.. run tellraw @a [{"text":"[调试.lv1][排行榜] ","color":"gold"},{"text":"写入 ","color":"gray"},{"score":{"name":"#hs_n","objective":"play_state"},"color":"white"},{"text":" 名参与者，write=","color":"gray"},{"nbt":"write","storage":"rhythm_axe:prop","color":"aqua"}]
