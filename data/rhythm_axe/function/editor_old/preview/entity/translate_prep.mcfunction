# ===== 位移准备（供 adjust.mcfunction 统一调度）=====
# 计算 delta_x = (old_index_line - index_line) * 8
# index 增大 → X 减小，反之亦然
scoreboard players operation delta_x editor = old_index_line editor
scoreboard players operation delta_x editor -= index_line editor
scoreboard players operation delta_x editor *= 8 const

# 移动 timeline_start marker（供 mount/preview 计算目标位置用）
execute as @e[type=marker,tag=timeline_start,limit=1] store result score current_x editor run data get entity @s Pos[0] 1
scoreboard players operation current_x editor += delta_x editor
execute as @e[type=marker,tag=timeline_start,limit=1] store result entity @s Pos[0] double 1 run scoreboard players get current_x editor

# 更新预览原点（用于重置）
scoreboard players operation preview_origin_x editor += delta_x editor

# 强制完成所有旧动画轴（PX + SZ），避免半路值被当做起点
execute as @e[type=block_display,tag=timeline_preview,limit=1] if score @s anim_status matches 1 run \
    execute store result entity @s transformation.translation[0] float 0.01 run scoreboard players get @s anim_end_px
execute as @e[type=block_display,tag=timeline_preview,limit=1] if score @s anim_status matches 1 run \
    execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get @s anim_end_sz

# 计算绝对目标 translation.X
# TARGET_PX = (marker_Pos_X - block_display_Pos_X) × 100 + base_offset
# base_offset = -300（初始 translation -3.0 的居中偏移 × 100）
execute as @e[type=marker,tag=timeline_start,limit=1] store result score marker_x editor run data get entity @s Pos[0] 100
execute as @e[type=block_display,tag=timeline_preview,limit=1] store result score bd_x editor run data get entity @s Pos[0] 100
scoreboard players operation #ANIM_TARGET_PX display_calc = marker_x editor
scoreboard players operation #ANIM_TARGET_PX display_calc -= bd_x editor
scoreboard players set base_tx editor -300
scoreboard players operation #ANIM_TARGET_PX display_calc += base_tx editor
