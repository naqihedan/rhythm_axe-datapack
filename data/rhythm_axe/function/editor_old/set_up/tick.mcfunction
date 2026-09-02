
# 暂时不需要在最后一个 tick 标记终点，不过判断条件现在这留着以便需要使用
# execute if score bar set_up_timeline = bar editor \
#         if score beat_per_bar set_up_timeline = beat_per_bar editor \
#         if score tick_per_beat set_up_timeline = tick_per_beat editor \
#     at @e[tag=point] run XXXXX

# ========= 刻度循环（底面）==========
# 底部侧面颜色（基于颜色组+颜色号）
execute if score color_group set_up_timeline matches 0 \
        if score color_group_number set_up_timeline matches 0 \
    at @e[tag=point] run fill ~-3 ~-1 ~ ~3 ~-1 ~ light_blue_terracotta
execute if score color_group set_up_timeline matches 0 \
        if score color_group_number set_up_timeline matches 1 \
    at @e[tag=point] run fill ~-3 ~-1 ~ ~3 ~-1 ~ yellow_terracotta
execute if score color_group set_up_timeline matches 1 \
        if score color_group_number set_up_timeline matches 0 \
    at @e[tag=point] run fill ~-3 ~-1 ~ ~3 ~-1 ~ blue_terracotta
execute if score color_group set_up_timeline matches 1 \
        if score color_group_number set_up_timeline matches 1 \
    at @e[tag=point] run fill ~-3 ~-1 ~ ~3 ~-1 ~ orange_terracotta

# 比侧面更外一格铺设轨道, 读取谱面时如果找不到黑色陶瓦则换行读取。
execute at @e[tag=point] run setblock ~4 ~-1 ~ black_terracotta
execute at @e[tag=point] run setblock ~-4 ~-1 ~ black_terracotta

# 刻度背景（白色）
execute at @e[tag=point] run fill ~2 ~-1 ~ ~-2 ~-1 ~ white_terracotta

# 刻度线（按 tick_per_beat 分段）
# 先用 divisible 检测 tick_per_beat 是否能被 N 整除
# 若能，则 step = tick_per_beat/N 作为步长
# 若当前 tick 号 % step == 1，且 tick_per_beat >= 最小要求，则放置刻度

# 16分段（已移除）

# 12分段（灰色，需 tick >= 24）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 12 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 12 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor >= 24 const \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ light_gray_terracotta

# 9分段（灰色，需 tick >= 18）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 9 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 9 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor >= 18 const \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ light_gray_terracotta

# 8分段（黄色，tick 16~23 和 tick >= 25）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 8 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 8 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 16..23 \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ yellow_terracotta
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 25.. \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ yellow_terracotta

# 6分段（紫色，tick 12~17 和 tick >= 19）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 6 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 6 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 12..17 \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ purple_terracotta
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 19.. \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ purple_terracotta

# 4分段（蓝色，需 tick >= 25，三格宽）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 4 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 4 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 25.. \
    run execute at @e[tag=point] run fill ~1 ~-1 ~ ~-1 ~-1 ~ blue_terracotta

# 3分段（品红色，tick 12~23 一格宽，tick >= 24 三格宽）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 3 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 3 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor >= 24 const \
    run execute at @e[tag=point] run fill ~1 ~-1 ~ ~-1 ~-1 ~ magenta_terracotta
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 12..23 \
    run execute at @e[tag=point] run setblock ~ ~-1 ~ magenta_terracotta

# 2分段（红色，tick 12~17 三格宽，tick >= 25 三格宽）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 2 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 2 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 12..17 \
    run execute at @e[tag=point] run fill ~1 ~-1 ~ ~-1 ~-1 ~ red_terracotta
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 25.. \
    run execute at @e[tag=point] run fill ~1 ~-1 ~ ~-1 ~-1 ~ red_terracotta

# 起始刻度（黑色，需 tick_per_beat >= 12）
# 每拍出现：小节开头宽5格，其他拍宽3格
execute if score tick_per_beat editor >= 12 const \
    if score tick_per_beat set_up_timeline matches 1 \
    if score beat_per_bar set_up_timeline matches 1 \
    at @e[tag=point] run fill ~2 ~-1 ~ ~-2 ~-1 ~ black_terracotta
execute if score tick_per_beat editor >= 12 const \
    if score tick_per_beat set_up_timeline matches 1 \
    unless score beat_per_bar set_up_timeline matches 1 \
    at @e[tag=point] run fill ~1 ~-1 ~ ~-1 ~-1 ~ black_terracotta


# ========= 刻度循环（侧面）==========

# ===== 侧面刻度（玻璃板，位于 ~4 处）=====
# 刻度背景（黑色玻璃板，高度3）
execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~2 ~ black_stained_glass_pane

# 16分段（已移除）

# 12分段（淡灰色，高度1，需 tick >= 32）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 12 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 12 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor >= 32 const \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ light_gray_stained_glass_pane

# 9分段（淡灰色，高度1，需 tick 18~23）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 9 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 9 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 19..23 \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ light_gray_stained_glass_pane

# 8分段（黄色，高度1，需 tick >= 16）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 8 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 8 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor >= 16 const \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ yellow_stained_glass_pane

# 6分段（紫色，高度1，需 tick 18~23）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 6 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 6 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 18..23 \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ purple_stained_glass_pane

# 4分段（蓝色，tick 8~11 高1，tick >= 12 高2）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 4 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 4 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor >= 12 const \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~1 ~ blue_stained_glass_pane
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 8..11 \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ blue_stained_glass_pane

# 3分段（品红色，高度1，需 tick 18~23）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 3 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 3 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 18..23 \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ magenta_stained_glass_pane

# 2分段（红色，tick <= 4 高1，tick > 4 高2）
scoreboard players operation divisible set_up_timeline = tick_per_beat editor
scoreboard players operation divisible set_up_timeline %= 2 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline = tick_per_beat editor
execute if score divisible set_up_timeline matches 0 run scoreboard players operation step set_up_timeline /= 2 const
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline = tick_per_beat set_up_timeline
execute if score divisible set_up_timeline matches 0 run scoreboard players operation remainder set_up_timeline %= step set_up_timeline
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches 5.. \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~1 ~ red_stained_glass_pane
execute if score divisible set_up_timeline matches 0 run execute if score remainder set_up_timeline matches 1 \
    run execute if score tick_per_beat editor matches ..4 \
    run execute at @e[tag=point] run fill ~4 ~ ~ ~4 ~ ~ red_stained_glass_pane

# 起始刻度（白色玻璃板）
# tick > 4：每拍均高3；tick <= 4：小节开头高3，其他拍高2
execute if score tick_per_beat editor matches 5.. \
    if score tick_per_beat set_up_timeline matches 1 \
    at @e[tag=point] run fill ~4 ~ ~ ~4 ~2 ~ white_stained_glass_pane
execute if score tick_per_beat editor matches ..4 \
    if score tick_per_beat set_up_timeline matches 1 \
    if score beat_per_bar set_up_timeline matches 1 \
    at @e[tag=point] run fill ~4 ~ ~ ~4 ~2 ~ white_stained_glass_pane
execute if score tick_per_beat editor matches ..4 \
    if score tick_per_beat set_up_timeline matches 1 \
    unless score beat_per_bar set_up_timeline matches 1 \
    at @e[tag=point] run fill ~4 ~ ~ ~4 ~1 ~ white_stained_glass_pane



# 指针向前移动一格
execute as @e[tag=point] at @s run tp @s ~ ~ ~1

# 循环控制
scoreboard players add tick_per_beat set_up_timeline 1
execute if score tick_per_beat set_up_timeline <= tick_per_beat editor run \
    function rhythm_axe:editor/set_up/tick

