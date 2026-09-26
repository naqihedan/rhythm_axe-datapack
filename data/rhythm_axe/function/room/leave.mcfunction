# 【退出游玩】：把自己移出本局名单（队伍 player）
#   注：这是**开局前**的操作；局中退出不会回收冒险模式/效果/斧头（需要额外的回收链，暂不做）
execute if entity @s[team=player] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"已退出本局名单","color":"gray"}]
execute unless entity @s[team=player] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"你本来就不在本局名单里","color":"gray"}]
execute if entity @s[team=player] run team leave @s
function rhythm_axe:room/render_all
