# 混凝土段③阶段2：设插值时长（@s = 混凝土展示实体；tag=note_concrete_seg3_armed + active=1 时调用）
# 起点已瞬切稳定（阶段1 duration=0，客户端已显示段②终点），本 tick 只设插值时长
# 插值时长（按模型）：长 hold（m>lt）= lt、短 hold（m<=lt）= m
# ★ 不设 start=0（2026-08-10）：transformation 没变时设 start=0 会让客户端重置插值 → 切换卡顿。
#   merge 终点时 transformation 变化即从当前渲染位置（已瞬切的段②终点）插值
# ★ 设参数后 active=0 → active_note 下 tick 翻 1 → 下下 tick 才 merge 终点（参数与终点分两 tick）
execute if score @s note_c_m > @s note_c_lt run execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_c_lt
execute if score @s note_c_m <= @s note_c_lt run execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_c_m
# 再延迟一 tick（active=0 → 下 tick 翻 1 → 才 merge 终点）
scoreboard players set @s note_active 0
tag @s remove note_concrete_seg3_armed
tag @s add note_concrete_seg3_pending