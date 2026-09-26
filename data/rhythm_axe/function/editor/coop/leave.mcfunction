# 踢出协作（@s = 被踢者；操作者 = @a[tag=coop_self,limit=1]）
# 广播要放在清理之前（被踢者此刻还带 editor_active，能收到这条广播）
execute unless entity @s[tag=editor_active] run tellraw @a[tag=coop_self,limit=1] [{"text":"[编辑器] ","color":"gold"},{"text":"该玩家不在协作中","color":"yellow"}]
execute unless entity @s[tag=editor_active] run return 0
tag @s add coop_just_now
tellraw @a[tag=editor_active] [{"text":"[编辑器] ","color":"gold"},{"selector":"@a[tag=coop_just_now]"},{"text":" 已被移出协作","color":"yellow"}]
function rhythm_axe:editor/coop/leave_core
tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"你已被移出协作（编辑工具已收回，音乐已停）","color":"yellow"}]
tag @s remove coop_just_now
