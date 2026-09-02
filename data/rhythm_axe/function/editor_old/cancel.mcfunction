# ========== 取消编辑，恢复轨道 ==========
# 清除编辑状态
scoreboard players set is_editing editor 0

# 传送玩家回原点并且恢复旋转角度
execute at @e[type=marker,tag=player_origin,limit=1] run tp @s ~ ~ ~

# 清除动画调度与标记坐骑
kill @e[type=marker,tag=player_origin]
kill @e[type=marker,tag=timeline_start]
kill @e[type=block_display,tag=timeline_preview]
kill @e[type=armor_stand,tag=timeline_mount]

# 反馈
tellraw @p [{"text":"编辑已取消","color":"red"}]
schedule clear rhythm_axe:editor/cancel
