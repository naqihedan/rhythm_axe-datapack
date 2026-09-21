# 混凝土段结果：按指定寿命判级（保护1 首段过早离开 / 保护2 末段过短延长）
# 前置：#ed_life = 判级用寿命（×1）、#ed_scale；调用后本段计为已判
function rhythm_axe:editor/judge/level
scoreboard players operation #ed_disp editor = #ed_level editor
data remove storage rhythm_axe:prop ct_case
execute if score #ed_level editor matches 0 run data modify storage rhythm_axe:prop ct_case set value "bad"
execute if score #ed_level editor matches 1 run data modify storage rhythm_axe:prop ct_case set value "good_early"
execute if score #ed_level editor matches 2 run data modify storage rhythm_axe:prop ct_case set value "perfect_early"
execute if score #ed_level editor matches 4 run data modify storage rhythm_axe:prop ct_case set value "perfect_late"
execute if score #ed_level editor matches 5 run data modify storage rhythm_axe:prop ct_case set value "good_late"
execute if score #ed_level editor matches 6 run data modify storage rhythm_axe:prop ct_case set value "miss"
function rhythm_axe:editor/visual/concrete_feedback
data remove storage rhythm_axe:prop ct_case
scoreboard players add @s editor_n_c_last 1
