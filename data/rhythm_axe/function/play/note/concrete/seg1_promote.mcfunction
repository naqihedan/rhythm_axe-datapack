# 混凝土段①阶段2：armed → pending（@s = 混凝土展示实体；tag=note_concrete_seg1_armed + active=1 时调用）
# ★ 出生同 tick active_note 已把 active 翻 1，本函数把 active 归 0 → 下一 tick 翻 1 → seg1_merge 才 merge 终点
#   （保证插值参数与终点分 tick 下发，不丢插值起点——方案3）
scoreboard players set @s note_active 0
tag @s remove note_concrete_seg1_armed
tag @s add note_concrete_seg1_pending