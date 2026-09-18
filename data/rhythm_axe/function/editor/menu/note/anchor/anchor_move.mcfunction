# 把锚点实体移到 #an_tx/#an_ty/#an_tz（×100 定点）；@s = 锚点展示实体
# ★ 必须用 `store result entity @s Pos[n] double 0.01 run scoreboard players get`：宏内联坐标会丢小数（本库定式）
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #an_tx editor
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #an_ty editor
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #an_tz editor
# 外观与发光同步（改样式/改状态后已存在的旧实体也能立刻更新，无需等一次 kill 重建）：连锁命令方块、红光（自动）
# ★ 故意**不动** `transformation.left_rotation`（用户手动摆的锚点朝向）和 `transformation.scale`（用户手动设的缩放倍数）
#   —— 这两个都是「应用锚点变换」（11511）的输入，必须保留（数据包只在 summon 时写初值，之后从不改写；
#      想恢复默认就点【⌖】11510 或裁剪/重建 → anchor_rebuild_at_center 会 kill + 重 summon）
data modify entity @s item.id set value "minecraft:chain_command_block"
data modify entity @s Glowing set value 1b
data modify entity @s glow_color_override set value 16733525
