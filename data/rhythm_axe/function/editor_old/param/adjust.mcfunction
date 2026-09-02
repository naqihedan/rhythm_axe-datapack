# ========== 参数调整（宏函数）==========
#arg: op, param, amount
execute unless score is_editing editor matches 1 run tellraw @s [{"text":"当前不在时间轴编辑状态","color":"red","bold":true}]
execute unless score is_editing editor matches 1 run return 0
# 用法: /function rhythm_axe:editor/util/adjust {"param":"bar","op":"add","amount":1}
#       /function rhythm_axe:editor/util/adjust {"param":"beat_per_bar","op":"remove","amount":1}
#       /function rhythm_axe:editor/util/adjust {"param":"tick_per_beat","op":"add","amount":1}
#       /function rhythm_axe:editor/param/adjust {"param":"index_line","op":"add","amount":1}

# 记录旧值
scoreboard players operation old_index_line editor = index_line editor
# 计算旧长度
scoreboard players operation old_length editor = bar editor
scoreboard players operation old_length editor *= beat_per_bar editor
scoreboard players operation old_length editor *= tick_per_beat editor

$scoreboard players $(op) $(param) editor $(amount)


# 值域钳制
# index_line 被表单限制住了
# offset 相关的调整会在专门的函数里处理，这里不做钳制  
execute if score bar editor matches ..0 run scoreboard players set bar editor 1
execute if score bar editor matches 100.. run scoreboard players set bar editor 99

execute if score beat_per_bar editor matches ..0 run scoreboard players set beat_per_bar editor 1
execute if score beat_per_bar editor matches 17.. run scoreboard players set beat_per_bar editor 16

execute if score tick_per_beat editor matches ..0 run scoreboard players set tick_per_beat editor 1
execute if score tick_per_beat editor matches 41.. run scoreboard players set tick_per_beat editor 40

 

# 重新计算长度和时间轴终点
function rhythm_axe:editor/util/recalculate

# 检测变化类型
scoreboard players set need_translate editor 0
scoreboard players set need_scale editor 0
execute unless score index_line editor = old_index_line editor run scoreboard players set need_translate editor 1
execute unless score length editor = old_length editor run scoreboard players set need_scale editor 1

# --- 准备位移（移动 marker + 更新原点 + 强制完成旧动画 + 设置 DELTA_PX）---
execute if score need_translate editor matches 1 run function rhythm_axe:editor/preview/entity/translate_prep
# --- 准备缩放（切换队伍颜色 + 强制完成旧动画 + 设置 TARGET_SZ）---
execute if score need_scale editor matches 1 run function rhythm_axe:editor/preview/entity/scale_prep

# --- 统一动画：任一变化即启动一次动画，位移和缩放同步执行 ---
scoreboard players set need_anim editor 0
execute if score need_translate editor matches 1 run scoreboard players set need_anim editor 1
execute if score need_scale editor matches 1 run scoreboard players set need_anim editor 1

execute if score need_anim editor matches 1 run scoreboard players set #ANIM_DURATION display_calc 16
execute if score need_anim editor matches 1 run scoreboard players set #ANIM_EASING display_calc 2
execute if score need_anim editor matches 1 run scoreboard players set #ANIM_POWER display_calc 3
execute if score need_anim editor matches 1 run scoreboard players set #ANIM_APPLY_POSITION display_calc 0
execute if score need_anim editor matches 1 run tag @e[type=block_display,tag=timeline_preview,limit=1] add anim_task
execute if score need_anim editor matches 1 run function rhythm_axe:utilization/display_animation/display_animation

# 预览（重新计算mount目标并启动缓动，停止旧动画防止重叠）
function rhythm_axe:editor/preview/mount/preview
# 重新骑乘（防止shift误触）
execute as @p run ride @s mount @e[type=armor_stand,tag=timeline_mount,limit=1]
# 刷新表单
function rhythm_axe:editor/show_form
# 超时取消
schedule function rhythm_axe:editor/cancel 1200t