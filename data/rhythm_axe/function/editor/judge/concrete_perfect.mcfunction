# 混凝土段结果：大P（@s = 混凝土展示实体）
# 段计数推进：editor_n_c_last +1（下刻判定下一段）；段进度用「已判完段数」表达，抗 seek 跳转
data remove storage rhythm_axe:prop ct_case
scoreboard players set #ed_disp editor 3
function rhythm_axe:editor/visual/concrete_feedback
scoreboard players add @s editor_n_c_last 1
