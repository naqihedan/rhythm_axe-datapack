# 叉号生成入口：初掷一次；撞禁区时由 cross_fire_roll 自行重掷
# ★ 禁区（XY 平面矩形，由对角点 (-0.5,0.5) 与 (-2.5,1.5) 围出）：x∈[-2.5,-0.5]、y∈[0.5,1.5]（×1000 口径）
#   要改禁区范围 → 只改 cross_fire_roll 里那两行 matches 的区间
# ⚠️ 键名必须与 cross_summon 的 $(x)$(y)$(s) 一致，否则宏缺参数、召唤静默失败
scoreboard players set #cr_try cross_time 0
function rhythm_axe:maps/goodworld/laser/cross_fire_roll
