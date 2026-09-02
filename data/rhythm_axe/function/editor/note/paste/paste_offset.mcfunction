# 计算时间偏移：先找剪贴板中最小 time（#min_time 从最大整数递减更新）
scoreboard players set #min_time editor 2147483647
data modify storage rhythm_axe:prop paste_index set value 0
function rhythm_axe:editor/note/paste/paste_min with storage rhythm_axe:prop
