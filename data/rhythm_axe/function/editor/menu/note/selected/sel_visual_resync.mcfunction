# 世界视觉与选区（selection）对账：把黄光/交互实体标记对齐到权威数据 selection。
# ★ 2026-11-04 事故驱动（用户实测）：只删 `notes[i].selected` 而不熄灯的路径有多条
#   （选区内筛选、取消选中、删除音符、填充收尾…），一旦漏一处就会「列表只剩 7 个、
#   世界里被移除的音符还在发黄光」。与其在每条路径上各补一遍，不如在选区重建后做一次全量对账。
# 做法：① 三条整表命令熄灭全部音符展示实体 / 清交互实体选中标签（O(实体数)）
#       ② 按 selection 逐个补光（sel_glow_drive，O(|selection|) 次宏叶子，自带黄光 + 重打标签）
# ⚠️ sel_glow_drive 内部有 `execute ... run return 0` —— 本项目实测 `/return` 会终止**整条调用栈**。
#   故本函数必须是调用方的**最后一行**，调用方之后不能再有任何必要命令。
execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute as @e[tag=editor_note,type=item_display] run data remove entity @s glow_color_override
execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
data modify storage rhythm_axe:prop glow_idx set value 0
function rhythm_axe:editor/menu/note/selected/sel_glow_drive