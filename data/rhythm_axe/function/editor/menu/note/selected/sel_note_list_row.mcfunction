#arg:cursor,sel_index
# 已选定音符列表单行（宏叶子，不递归）：读 selection[sel_index] 的 id → find_by_id → 渲染（复用 note_list_line）
# 按钮值：编辑 1400+行序、复制 1440+、粘贴 1480+、删除 1520+
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(sel_index)]
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
# 按钮值：编辑 1400+行序、复制 1440+、粘贴 1480+、删除 1520+（scoreboard 计算，避免 set value 宏表达式报错）
execute if data storage rhythm_axe:prop found_index run execute store result score #sel_i editor run data get storage rhythm_axe:prop sel_index
execute if data storage rhythm_axe:prop found_index run scoreboard players operation #temp editor = #sel_i editor
execute if data storage rhythm_axe:prop found_index run scoreboard players add #temp editor 1400
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp editor
execute if data storage rhythm_axe:prop found_index run scoreboard players operation #temp editor = #sel_i editor
execute if data storage rhythm_axe:prop found_index run scoreboard players add #temp editor 1440
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #temp editor
execute if data storage rhythm_axe:prop found_index run scoreboard players operation #temp editor = #sel_i editor
execute if data storage rhythm_axe:prop found_index run scoreboard players add #temp editor 1480
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #temp editor
execute if data storage rhythm_axe:prop found_index run scoreboard players operation #temp editor = #sel_i editor
execute if data storage rhythm_axe:prop found_index run scoreboard players add #temp editor 1520
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp editor
# 复选框：已选定列表里这些音符都已选中（#sel_on=1），点击值 = 1643+行序（面板18去选/重开）
execute if data storage rhythm_axe:prop found_index run scoreboard players set #sel_on editor 1
execute if data storage rhythm_axe:prop found_index run scoreboard players operation #temp editor = #sel_i editor
execute if data storage rhythm_axe:prop found_index run scoreboard players add #temp editor 1643
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop sel_val int 1 run scoreboard players get #temp editor
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/list/note_checkbox_write with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/list/note_list_line with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop found_index run data remove storage rhythm_axe:prop checkbox
execute if data storage rhythm_axe:prop found_index run data remove storage rhythm_axe:prop sel_val
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
