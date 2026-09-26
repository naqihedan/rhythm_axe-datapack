# 协作工具右键入口（@s = 使用者；由 use__ 按 custom_data 分派；站立=邀请、蹲下=踢出）
# ★ 为什么不用「右键到的实体」：原版不会把交互对象告诉命令（consume_item 没有目标信息；
#   interaction 实体那套 UUID 匹配只对 interaction 有效）。⇒ 用探针沿准星直线前推，找「第一个撞到的玩家」。
#   这条规则与原版准星拾取规则一致（都是「沿视线最近的实体」），所以结果 = 你右键的那个玩家。
#   步长 0.4 格，最多 20 步 = 8 格；命中判定用 dx/dy/dz 盒（hitbox 相交；distance 是到脚底 Pos，视线在眼部高度会漏检）。
kill @e[tag=coop_probe]
scoreboard players set #coop_hit editor 0
scoreboard players set #coop_step editor 0
scoreboard players set #coop_kick editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #coop_kick editor 1
# 操作者标记（射线要排除自己；命中后 hit_one 也靠它找回操作者）
tag @s add coop_self
execute at @s anchored eyes run summon minecraft:marker ~ ~ ~ {Tags:["coop_probe"]}
data modify entity @e[tag=coop_probe,limit=1] Rotation set from entity @s Rotation
function rhythm_axe:editor/tool/coop/ray_drive
tag @s remove coop_self
kill @e[tag=coop_probe]
execute if score #coop_hit editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"准星直线上没有玩家（最多 8 格）","color":"red"}]
