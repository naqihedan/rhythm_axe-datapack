#arg: room_mapid
# 【开始游戏】：房间页开局（@s = 点击者）
#   检查：没有正在运行的谱面 + 点击者已在名单里 + 名单里至少一位在线玩家
# ★ 2026-09-26 用户定：总表/房间页可随便开，但「编辑中不能开局」——各开局入口统一拦一道
#   （与 map_list/maps/play 同款；防守旧的房间页按钮：先进房间页 → 再进编辑器 → 点旧【开始游戏】）
execute if entity @s[tag=editor_active] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"请先退出编辑器，再来开始游戏","color":"gray"}]
execute if entity @s[tag=editor_active] run return fail
execute if score is_running play_state matches 1 run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"已有谱面正在运行，无法开始。请先执行 /function rhythm_axe:play/end_of_game/stop","color":"gray"}]
execute if score is_running play_state matches 1 run return fail
execute unless entity @s[team=player] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"请先点【加入游玩】把自己加进名单","color":"gray"}]
execute unless entity @s[team=player] run return fail
scoreboard players set #rm_n menu 0
execute store result score #rm_n menu if entity @a[team=player]
execute if score #rm_n menu matches 0 run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"名单里没有在线玩家（成员可能都已下线）","color":"gray"}]
execute if score #rm_n menu matches 0 run return fail
# 收起房间页：只清菜单状态（**不清屏**：2026-09-26 用户定，十行换行不输出；房间页旧行因 open 被清而点不动）
# （这里原来会广播清屏，已按用户要求去掉）
data remove storage rhythm_axe:map_list open
data remove storage rhythm_axe:map_list panel
data remove storage rhythm_axe:map_list room_mapid
# 走既有开局入口（$(room_mapid) 在本函数实例化时已替换成实际 id，上面的 remove 无影响）
$function rhythm_axe:play/start_of_game/start_of_game {mapid:"$(room_mapid)"}
