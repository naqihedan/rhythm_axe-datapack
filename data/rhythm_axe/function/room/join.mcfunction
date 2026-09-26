# 【加入游玩】：把自己加入本局名单（队伍 player）
#   幂等：已在名单里只提示，不重复 join
execute if entity @s[team=player] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"你已经在本局名单里了","color":"gray"}]
execute unless entity @s[team=player] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"已加入本局名单：","color":"gray"},{"selector":"@s"}]
execute unless entity @s[team=player] run team join player @s
function rhythm_axe:room/render_all
