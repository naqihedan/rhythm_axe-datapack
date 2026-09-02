# ========== 示例 1：生成展示实体 ==========
# 生成一个展示实体的铁块，标记 anim_demo 供后续动画使用
# 运行前需先加载数据包（/reload）

summon minecraft:item_display ~2 ~1 ~2 {item:{id:"minecraft:lightning_rod",count:1},Tags:["anim_demo"],transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],translation:[0.0d,0.0d,0.0d]}}

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"已生成展示实体（避雷针），标签: anim_demo","color":"green"}]
