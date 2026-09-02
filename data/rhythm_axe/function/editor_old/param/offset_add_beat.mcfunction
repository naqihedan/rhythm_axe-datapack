# 偏移量右移一拍：offset += tick_per_beat

# 编辑状态检测
execute if score is_editing editor matches 0 run tellraw @s [{"text":"当前不在时间轴编辑状态","color":"red","bold":true}]
execute if score is_editing editor matches 0 run return 0

# 每次操作后：让玩家重新骑乘，刷新预览显示
execute as @p run ride @s mount @e[type=armor_stand,tag=timeline_mount,limit=1]

# 总长度分数项变更 + 值域钳制
scoreboard players operation old_offset editor = offset editor
scoreboard players operation offset editor += tick_per_beat editor

execute if score offset editor matches ..0 run scoreboard players set offset editor 0
execute if score offset editor matches 512.. run scoreboard players set offset editor 512

# 计算实际位移 delta = offset - old_offset
scoreboard players operation delta editor = offset editor
scoreboard players operation delta editor -= old_offset editor

# 预览范围显示和时间轴原点移动（更新显示实体Z并写入marker实体）
execute as @e[type=block_display,tag=timeline_preview,limit=1] store result score z editor run data get entity @s Pos[2]
scoreboard players operation z editor += delta editor
execute as @e[type=block_display,tag=timeline_preview,limit=1] store result entity @s Pos[2] double 1 run scoreboard players get z editor
# 同步更新 timeline_start marker 实体Z
execute if entity @e[type=marker,tag=timeline_start,limit=1] run \
    execute as @e[type=marker,tag=timeline_start,limit=1] store result entity @s Pos[2] double 1 run scoreboard players get z editor

# 刷新表单、预览显示
function rhythm_axe:editor/show_form
function rhythm_axe:editor/preview/mount/preview

# 2分钟无操作取消编辑状态
schedule function rhythm_axe:editor/cancel 1200t
