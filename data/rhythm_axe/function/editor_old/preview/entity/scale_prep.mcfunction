# ===== 缩放准备（供 adjust.mcfunction 统一调度）=====
# 根据长度切换发光颜色（长度>512 用红色 0xFF0000=16711680，否则绿色 0x00FF00=65280）
execute if score length editor matches 513.. run data merge entity @e[type=block_display,tag=timeline_preview,limit=1] {glow_color_override:16711680}
execute if score length editor matches ..512 run data merge entity @e[type=block_display,tag=timeline_preview,limit=1] {glow_color_override:65280}

# 强制完成所有旧动画轴（PX + SZ），避免半路值被当做起点
execute as @e[type=block_display,tag=timeline_preview,limit=1] if score @s anim_status matches 1 run \
    execute store result entity @s transformation.translation[0] float 0.01 run scoreboard players get @s anim_end_px
execute as @e[type=block_display,tag=timeline_preview,limit=1] if score @s anim_status matches 1 run \
    execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get @s anim_end_sz

# 设置缩放动画目标（绝对目标值，由 adjust.mcfunction 统一启动）
scoreboard players operation #ANIM_TARGET_SZ display_calc = length editor
scoreboard players operation #ANIM_TARGET_SZ display_calc *= 100 const
