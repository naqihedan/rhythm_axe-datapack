# 读锚点实体状态 → #an_has（1=实体存在）/ #an_x/#an_y/#an_z（Pos ×100 定点）
# ★ 先置 0：实体不存在时 `store result ... run data get entity` 失败会**保留旧值**（本库常见坑）
scoreboard players set #an_has editor 0
scoreboard players set #an_x editor 0
scoreboard players set #an_y editor 0
scoreboard players set #an_z editor 0
execute if entity @e[tag=editor_anchor,type=item_display] run scoreboard players set #an_has editor 1
execute store result score #an_x editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] Pos[0] 100
execute store result score #an_y editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] Pos[1] 100
execute store result score #an_z editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] Pos[2] 100
