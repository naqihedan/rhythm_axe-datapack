# 继承遍历驱动器（普通函数，非宏）：处理当前索引 → 递增 → 未越界继续
# ★ 26.x：递归只在普通函数做，宏叶子 inherit_leaf 不递归、不 return
function rhythm_axe:editor/tool/note/inherit_leaf with storage rhythm_axe:prop
execute store result score #inh_idx editor run data get storage rhythm_axe:prop index
scoreboard players add #inh_idx editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #inh_idx editor
# ★ 2026-09-14：结束条件改为「叶子探测到元素缺失」（#inh_done=2），不再读数组长度
# ★ 2026-09-14：#inh_ex=0（叶子探测到元素缺失）= 遍历结束
execute if score #inh_ex editor matches 0 run return 0
function rhythm_axe:editor/tool/note/inherit_drive
