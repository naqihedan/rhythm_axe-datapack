# 查找暂存 editing.temp.commands 中**最后一条空指令**的下标 → prop.empty_index（没有则不写该键）
# 空指令判定：字符串长度 == 0（`data get` 对标量返回长度；复合等非标量 store 失败写 0，也当空处理）
# ★ 与 util/find_by_time 同款结构：驱动器是普通函数（递归可靠），探测用宏叶子（1 条命令/次）
data remove storage rhythm_axe:prop empty_index
scoreboard players set #fe_i editor 0
scoreboard players set #fe_done editor 0
execute store result storage rhythm_axe:prop fe_i int 1 run scoreboard players get #fe_i editor
function rhythm_axe:editor/menu/event/panel/event_panel_find_empty_drive
data remove storage rhythm_axe:prop fe_i