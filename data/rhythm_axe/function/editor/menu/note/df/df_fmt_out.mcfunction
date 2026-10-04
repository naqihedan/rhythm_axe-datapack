#arg: slot, color, sign, i, pad, f
# 拼一个坐标数值组件写进 rhythm_axe:df 的 rows.$(slot)（颜色盖在整段数字上）
$data modify storage rhythm_axe:df rows.$(slot) set value "{\"text\":\"$(sign)$(i).$(pad)$(f)\",\"color\":\"$(color)\"}"
