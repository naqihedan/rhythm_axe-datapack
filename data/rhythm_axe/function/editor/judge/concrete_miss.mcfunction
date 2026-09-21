# 混凝土段结果：miss（段末玩家不在判定区域）
data modify storage rhythm_axe:prop ct_case set value "miss"
scoreboard players set #ed_disp editor 6
function rhythm_axe:editor/visual/concrete_feedback
data remove storage rhythm_axe:prop ct_case
scoreboard players add @s editor_n_c_last 1
