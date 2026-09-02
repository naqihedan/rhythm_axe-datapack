# 继承同类"往前最近"音符属性（普通函数入口，非宏）
# 前置：prop.type（目标类型）、prop.time（当前音符 time）；place 已设 #inh_found=0
# 方向：同类中 time <= 当前音符 time 且 time 最大者 = 往前最近（含同拍，同拍取最后创建的；不继承更晚的）
# 输出：找到时 prop.inherit_idx（目标音符数组索引），并复制属性到 prop
# 遍历用"普通驱动器 + 宏叶子"模式（26.x 宏递归幽灵 bug 修复方案）
execute store result score #inh_type editor run data get storage rhythm_axe:prop type
execute store result score #inh_time editor run data get storage rhythm_axe:prop time
scoreboard players set #inh_best_time editor -2147483648
scoreboard players set #inh_idx editor 0
scoreboard players set #inh_total editor 0
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #inh_idx editor
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/tool/note/inherit_drive
# 找到 → 复制属性（宏叶子）
execute if score #inh_found editor matches 1 run function rhythm_axe:editor/tool/note/inherit_copy with storage rhythm_axe:prop
