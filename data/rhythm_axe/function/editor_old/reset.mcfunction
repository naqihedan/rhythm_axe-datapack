# 重置时间轴参数为默认值并刷新表单
# index_line 和 index_map 不重置
scoreboard players set bar editor 8
scoreboard players set beat_per_bar editor 4
scoreboard players set tick_per_beat editor 8
scoreboard players set offset editor 0
scoreboard players set length editor -1

# 重置展示实体 NBT（包括 scale/translation）
data merge entity @e[type=block_display,tag=timeline_preview,limit=1] \
    {transformation:{translation:[-3.0d,-0.3d,0.0d],scale:[7.0,1.0,1.0]}}

# 恢复时间轴原点位置 
execute if entity @e[type=marker,tag=timeline_start,limit=1] run \
    execute as @e[type=marker,tag=timeline_start,limit=1] store result entity @s Pos[0] double 1 run scoreboard players get preview_origin_x editor
execute if entity @e[type=marker,tag=timeline_start,limit=1] run \
    execute as @e[type=marker,tag=timeline_start,limit=1] store result entity @s Pos[2] double 1 run scoreboard players get preview_origin_z editor

# 恢复展示实体的位置
tp @e[type=block_display,tag=timeline_preview,limit=1] @e[type=marker,tag=timeline_start,limit=1]


# 重新计算长度并启动缩放动画
function rhythm_axe:editor/util/recalculate
function rhythm_axe:editor/preview/entity/scale
# 刷新显示
function rhythm_axe:editor/show_form
function rhythm_axe:editor/preview/mount/preview
