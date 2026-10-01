#arg:mapid
# 排行榜准备：把该谱面的玩家名单拷进临时 storage rhythm_axe:lb.keys（遍历/删除都在副本上做，不动原名单）
#   人数写进 #lb_n（menu）；#lb_total 记总人数（#lb_n 在取榜过程中会递减）
# ⚠️ 存储 id 会把点分名字吃掉 ⇒ 键要放路径里（空格分隔）
data remove storage rhythm_axe:lb keys
$execute if data storage rhythm_axe:scores_index $(mapid) run data modify storage rhythm_axe:lb keys set from storage rhythm_axe:scores_index $(mapid)
scoreboard players set #lb_n menu 0
$execute store result score #lb_n menu run data get storage rhythm_axe:scores_index $(mapid)
scoreboard players operation #lb_total menu = #lb_n menu
