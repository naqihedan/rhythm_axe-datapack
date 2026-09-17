# 把锚点实体移到 #an_tx/#an_ty/#an_tz（×100 定点）；@s = 锚点展示实体
# ★ 必须用 `store result entity @s Pos[n] double 0.01 run scoreboard players get`：宏内联坐标会丢小数（本库定式）
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #an_tx editor
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #an_ty editor
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #an_tz editor
# 外观与发光同步（改样式/改状态后已存在的旧实体也能立刻更新，无需等一次 kill 重建）：淡蓝色混凝土、边长 0.25 格、红光（自动）
data modify entity @s item.id set value "minecraft:light_blue_concrete"
data modify entity @s transformation.scale set value [0.25f,0.25f,0.25f]
data modify entity @s Glowing set value 1b
data modify entity @s glow_color_override set value 16733525
