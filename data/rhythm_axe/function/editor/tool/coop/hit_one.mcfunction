# 射线命中目标（@s = 目标玩家；操作者 = @a[tag=coop_self]；#coop_kick 0=邀请 1=踢出）
# 会话主不可踢（否则会话没有主人，时间轴/事件的「代表对象」会悬空）
execute if entity @s[tag=editor_host] if score #coop_kick editor matches 1 run tellraw @a[tag=coop_self,limit=1] [{"text":"[编辑器] ","color":"gold"},{"text":"不能踢出会话主（打开编辑器的房主）","color":"red"}]
execute if entity @s[tag=editor_host] run return 0
execute if score #coop_kick editor matches 1 run function rhythm_axe:editor/coop/leave
execute if score #coop_kick editor matches 0 run function rhythm_axe:editor/coop/join
