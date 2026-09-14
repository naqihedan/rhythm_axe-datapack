# 顺序修复驱动器（普通函数，非宏）：处理当前 prop.i，再按叶子给出的 #ord_next 推进（可能是回退一格）
# ★ 26.x：递归只在普通函数做，宏叶子 order_repair_leaf 不递归、不 return
# i1 = i+1 也作宏参数传（宏替换是纯文本，不能写 $(i+1)）
function rhythm_axe:editor/util/order_repair_leaf with storage rhythm_axe:prop
execute if score #ord_done editor matches 1 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ord_next editor
scoreboard players operation #ord_i1 editor = #ord_next editor
scoreboard players add #ord_i1 editor 1
execute store result storage rhythm_axe:prop i1 int 1 run scoreboard players get #ord_i1 editor
function rhythm_axe:editor/util/order_repair_drive
