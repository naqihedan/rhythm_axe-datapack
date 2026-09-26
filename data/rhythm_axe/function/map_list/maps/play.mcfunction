#arg: mapid
# 总表行【游玩】（列码 1）：按**在线玩家数**分流（2026-09-26 用户定）
#   只有 1 人 → 直接开局（把这个人加进队伍 player 后走既有开局入口）
#   多人 → 先收起总表，转「房间页」（room/open，页面 21）确认名单，再由房间页【开始游戏】开局
# 注：$(mapid) 在本函数**实例化时**就已替换成实际 id，所以下面 close 清掉 prop.mapid 也无影响。
# ★ 2026-09-26 用户定：总表可无条件打开（编辑中也能翻看）；「编辑中不能开局」的拦截放在这里（游玩按钮）
execute if entity @s[tag=editor_active] run tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"请先退出编辑器，再来游玩","color":"gray"}]
execute if entity @s[tag=editor_active] run return fail
scoreboard players set #ml_online menu 0
execute store result score #ml_online menu if entity @a
execute if score #ml_online menu matches 1 run team join player @s
execute if score #ml_online menu matches 1 run function rhythm_axe:map_list/close
$execute if score #ml_online menu matches 1 run function rhythm_axe:play/start_of_game/start_of_game {mapid:"$(mapid)"}
$execute if score #ml_online menu matches 2.. run function rhythm_axe:room/open {mapid:"$(mapid)"}
