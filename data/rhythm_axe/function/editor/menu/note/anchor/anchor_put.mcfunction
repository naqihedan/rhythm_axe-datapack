# 把锚点实体放到 #an_tx/#an_ty/#an_tz（×100 定点）：不存在则先在编辑玩家处 summon（避免在未加载的 0,0,0 生成），再写精确 Pos
# 实体外观：**连锁命令方块**、边长 0.25 格（scale 0.25）、红光（Glowing + glow_color_override=16733525 = #FF5555，**与按钮的「自动」红色一致**，自发光 brightness 15）
# ★ 旋转 / 缩放：默认单位四元数 [0,0,0,1] + scale [0.25,0.25,0.25]。两个都**不归数据包管**（只在本 summon 里写初值，之后从不改写）——
#   它们代表「用户手动给锚点摆的朝向 / 大小」，给「应用锚点变换」（11511）当变换源用：
#   旋转 = left_rotation；缩放倍数 = **三轴各自** scale[n] × 4（默认 0.25 ⇒ ×1 不缩放；某轴 0.5 ⇒ 该轴 ×2；每轴上限 ×4）
# ★ 发光颜色跟随状态：自动（红色 16733525）/ 手动（蓝色 5592575）—— 手动时由 anchor_sync 改蓝，本函数只在自动模式被调用所以恒写红
# 独立 tag：editor_anchor（不带 editor_note → 不会被 refresh/列表/清理逻辑误伤）
execute as @a[tag=editor_active,limit=1] at @s unless entity @e[tag=editor_anchor] run summon item_display ~ ~ ~ {item:{id:"minecraft:chain_command_block",count:1},Tags:["editor_anchor"],Glowing:1b,glow_color_override:16733525,brightness:{block:15,sky:15},transformation:{translation:[0.0,0.0,0.0],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.25f,0.25f,0.25f]}}
execute as @e[tag=editor_anchor,type=item_display] run function rhythm_axe:editor/menu/note/anchor/anchor_move
