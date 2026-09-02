# ========== 生成时间轴轨道 ==========
# 从起始点生成指针标记（先清理可能残留的旧标记）
kill @e[type=marker,tag=point]
execute as @e[tag=timeline_start,limit=1] at @s run summon marker ~ ~ ~ {Tags:["point"]}

# 创建循环计分板
scoreboard objectives add set_up_timeline dummy
scoreboard players set color_group set_up_timeline 0
scoreboard players set color_group_number set_up_timeline 0

# 设置循环计数器初始值
scoreboard players set bar set_up_timeline 1
function rhythm_axe:editor/set_up/bar

# 生成完成后清理指针
kill @e[type=marker,tag=point]


