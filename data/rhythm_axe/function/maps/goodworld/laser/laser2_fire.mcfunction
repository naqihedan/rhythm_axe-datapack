# 发一波激光2：x = [-7, 1] 随机（千分位精度，借计分板 → float → 宏注入坐标）
# ⚠️ 键名必须是 x（与 laser2_summon 的 $(x) 一致），不能叫 l2_x —— 否则宏缺参数、召唤静默失败
execute store result score #l2_x laser2_time run random value -7000..1000
execute store result storage rhythm_axe:prop x float 0.001 run scoreboard players get #l2_x laser2_time
function rhythm_axe:maps/goodworld/laser/laser2_summon with storage rhythm_axe:prop
data remove storage rhythm_axe:prop x
