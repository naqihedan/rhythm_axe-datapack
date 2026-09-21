# 补扫驱动器（**普通函数**，可安全递归）：单步交给宏叶子，推进由本函数负责
# （沿用本库惯例：遍历递归一律放普通驱动器，宏叶子只处理单个元素、不递归不 return）
# 前置：#due_i（下一待检下标）、#due_stop=0、#due_max、prop.cursor
execute if score #due_i editor matches 1000000.. run return 0
execute if score #due_stop editor matches 1 run return 0
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #due_i editor
function rhythm_axe:editor/visual/scan_due_leaf with storage rhythm_axe:prop
execute if score #due_stop editor matches 1 run return 0
scoreboard players add #due_i editor 1
function rhythm_axe:editor/visual/scan_due_drive
