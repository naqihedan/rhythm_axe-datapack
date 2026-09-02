# ========== 示例 0：清理所有展示实体 ==========
# 移除所有动画标签 + 清除实体
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
scoreboard players set #ANIM_START_PX display_calc 0
scoreboard players set #ANIM_START_PY display_calc 0
scoreboard players set #ANIM_START_PZ display_calc 0
scoreboard players set #ANIM_START_RX display_calc 0
scoreboard players set #ANIM_START_RY display_calc 0
scoreboard players set #ANIM_START_RZ display_calc 0
scoreboard players set #ANIM_START_SX display_calc 0
scoreboard players set #ANIM_START_SY display_calc 0
scoreboard players set #ANIM_START_SZ display_calc 0
tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"所有实体和参数已清理","color":"green"}]
