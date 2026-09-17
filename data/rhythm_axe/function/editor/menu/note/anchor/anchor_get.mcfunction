# 镜像/旋转用的中心（×100 定点）→ #rc0/#rc1/#rc2
# 规则（用户定稿）：锚点实体存在就**直接读它的 Pos**（真值）；不存在则兜底 = 选中集合的判定位置包围盒中心
#   （= 旧行为，所以「没动过锚点」时镜像/旋转结果与改动前完全一致）
# 前置：selection 非空、prop.cursor 已指向工作副本（兜底路径要用）；由 *_go 在真正干活前调用一次
function rhythm_axe:editor/menu/note/anchor/anchor_read
scoreboard players set #rc0 editor 0
scoreboard players set #rc1 editor 0
scoreboard players set #rc2 editor 0
execute if score #an_has editor matches 1 run scoreboard players operation #rc0 editor = #an_x editor
execute if score #an_has editor matches 1 run scoreboard players operation #rc1 editor = #an_y editor
execute if score #an_has editor matches 1 run scoreboard players operation #rc2 editor = #an_z editor
execute if score #an_has editor matches 0 run function rhythm_axe:editor/menu/note/anchor/anchor_center
