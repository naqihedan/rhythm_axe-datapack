# ========== 示例 6：多组实体不同参数混合测试 ==========
# 模拟实际场景：两拨实体同时动画，不同缓动类型、不同幂次、混合 target/delta
#
# Group A（红混凝土，X-4）：缓入 三次方，target 为主
#   - TARGET_PY = 300（绝对目标：上移 3 格）
#   - DELTA_RY = 360（相对增量：转一整圈）
#   - 其他轴不变
#
# Group B（蓝混凝土，X+4）：缓出 五次方，delta + target 混合
#   - DELTA_PY = 300（相对：从当前位置上移 3 格）
#   - TARGET_RX = 180（绝对：旋转到 180°）
#   - DELTA_SX/Y/Z = 100（相对：从 1.0 倍缩放到 2.0 倍）

# ===== 1. 清理旧实体 =====
kill @e[type=minecraft:item_display,tag=anim_demo]
scoreboard players set #ANIM_DURATION display_calc 0
scoreboard players set #ANIM_EASING display_calc 0
scoreboard players set #ANIM_POWER display_calc 0
scoreboard players set #ANIM_APPLY_POSITION display_calc 0
scoreboard players set #ANIM_DELTA_PX display_calc 0
scoreboard players set #ANIM_DELTA_PY display_calc 0
scoreboard players set #ANIM_DELTA_PZ display_calc 0
scoreboard players set #ANIM_DELTA_RX display_calc 0
scoreboard players set #ANIM_DELTA_RY display_calc 0
scoreboard players set #ANIM_DELTA_RZ display_calc 0
scoreboard players set #ANIM_DELTA_SX display_calc 0
scoreboard players set #ANIM_DELTA_SY display_calc 0
scoreboard players set #ANIM_DELTA_SZ display_calc 0
scoreboard players set #ANIM_TARGET_PX display_calc 0
scoreboard players set #ANIM_TARGET_PY display_calc 0
scoreboard players set #ANIM_TARGET_PZ display_calc 0
scoreboard players set #ANIM_TARGET_RX display_calc 0
scoreboard players set #ANIM_TARGET_RY display_calc 0
scoreboard players set #ANIM_TARGET_RZ display_calc 0
scoreboard players set #ANIM_TARGET_SX display_calc 0
scoreboard players set #ANIM_TARGET_SY display_calc 0
scoreboard players set #ANIM_TARGET_SZ display_calc 0
scoreboard players set #ANIM_START_PX display_calc 0
scoreboard players set #ANIM_START_PY display_calc 0
scoreboard players set #ANIM_START_PZ display_calc 0
scoreboard players set #ANIM_START_RX display_calc 0
scoreboard players set #ANIM_START_RY display_calc 0
scoreboard players set #ANIM_START_RZ display_calc 0
scoreboard players set #ANIM_START_SX display_calc 0
scoreboard players set #ANIM_START_SY display_calc 0
scoreboard players set #ANIM_START_SZ display_calc 0

# ===== 2. 生成展示实体 =====
# Group A（左排 5 个，红混凝土），沿 Z 轴排开
summon minecraft:item_display ~-4 ~1 ~4 {item:{id:"minecraft:red_concrete",count:1},Tags:["anim_demo","group_a"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~-4 ~1 ~2 {item:{id:"minecraft:red_concrete",count:1},Tags:["anim_demo","group_a"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~-4 ~1 ~0 {item:{id:"minecraft:red_concrete",count:1},Tags:["anim_demo","group_a"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~-4 ~1 ~-2 {item:{id:"minecraft:red_concrete",count:1},Tags:["anim_demo","group_a"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~-4 ~1 ~-4 {item:{id:"minecraft:red_concrete",count:1},Tags:["anim_demo","group_a"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}

# Group B（右排 5 个，蓝混凝土），沿 Z 轴排开
summon minecraft:item_display ~4 ~1 ~4 {item:{id:"minecraft:blue_concrete",count:1},Tags:["anim_demo","group_b"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~4 ~1 ~2 {item:{id:"minecraft:blue_concrete",count:1},Tags:["anim_demo","group_b"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~4 ~1 ~0 {item:{id:"minecraft:blue_concrete",count:1},Tags:["anim_demo","group_b"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~4 ~1 ~-2 {item:{id:"minecraft:blue_concrete",count:1},Tags:["anim_demo","group_b"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}
summon minecraft:item_display ~4 ~1 ~-4 {item:{id:"minecraft:blue_concrete",count:1},Tags:["anim_demo","group_b"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"已生成 10 个展示实体（红=GroupA 蓝=GroupB）","color":"green"}]

# ===== 3. Group A 参数（缓入 三次方，target+delta）=====
scoreboard players set #ANIM_DURATION display_calc 40
scoreboard players set #ANIM_EASING display_calc 1
scoreboard players set #ANIM_POWER display_calc 3
scoreboard players set #ANIM_APPLY_POSITION display_calc 0

# target 为主：绝对上移 3 格
scoreboard players set #ANIM_TARGET_PY display_calc 300
# delta 叠加：转一整圈
scoreboard players set #ANIM_DELTA_RY display_calc 360
# 其他轴不设置（保留 0）

tag @e[tag=group_a] add anim_task
function rhythm_axe:utilization/display_animation/display_animation

# ===== 4. Group B 参数（缓出 五次方，delta+target 混合）=====
scoreboard players set #ANIM_DURATION display_calc 40
scoreboard players set #ANIM_EASING display_calc 2
scoreboard players set #ANIM_POWER display_calc 5
scoreboard players set #ANIM_APPLY_POSITION display_calc 0

# delta：从当前位置上移 3 格
scoreboard players set #ANIM_DELTA_PY display_calc 300
# target：绝对旋转到 180°
scoreboard players set #ANIM_TARGET_RX display_calc 180
# delta：缩放 +1.0 倍（从 1.0 到 2.0）
scoreboard players set #ANIM_DELTA_SX display_calc 100
scoreboard players set #ANIM_DELTA_SY display_calc 100
scoreboard players set #ANIM_DELTA_SZ display_calc 100

tag @e[tag=group_b] add anim_task
function rhythm_axe:utilization/display_animation/display_animation

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"06 多组测试已启动！红=缓入 蓝=缓出","color":"green"}]
