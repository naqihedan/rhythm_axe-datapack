#arg:cursor,sel_i
# 已选定音符列表单行（宏叶子，不递归）：读 selection[$(sel_i)] 的 id → find_by_id 找 notes 下标 → 渲染该行
# ★ 2026-09-05 重构：按 selection 驱动（每个选中 id 独立 find），不再要求 selection 在 notes 中递增。
#   找到则渲染（note_list_line），找不到（已删/无效）则跳过（#show_row 保持 0，不渲染）。
# 前置：prop.cursor（=history_cursor）、#sel_total、#sel_i、#sel_page_start
# 页内序（选中项的序号，用于按钮值/分页过滤）
execute store result score #pos editor run scoreboard players get #sel_i editor
scoreboard players operation #temp editor = #pos editor
scoreboard players operation #temp editor -= #sel_page_start editor
# 页外（选中序 < 页起点 或 >= 页起点+40）→ #show_row=0 不渲染
scoreboard players set #show_row editor 0
execute if score #temp editor matches 0..39 run scoreboard players set #show_row editor 1
# 读选中 id → prop.note_id（供 find_by_id）
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(sel_i)]
# find_by_id：从 index=0 找该 id 在 notes 中的下标（普通驱动器+宏叶子，O(n)）
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
# 找到 → 渲染该行（基于 found_index）
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
# 按钮值：编辑 1400+页内序、复制 1440+、粘贴 1480+、删除 1520+（页内相对）
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players operation #temp_cursor editor = #temp editor
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players add #temp_cursor editor 1400
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp_cursor editor
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players add #temp_cursor editor 40
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #temp_cursor editor
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players add #temp_cursor editor 40
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #temp_cursor editor
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players add #temp_cursor editor 40
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp_cursor editor
# 复选框：已选定列表里这些都选中（#sel_on=1），点击值 = 1643+页内序（面板18去选/重开）
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players set #sel_on editor 1
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players operation #temp_cursor editor = #temp editor
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run scoreboard players add #temp_cursor editor 1643
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop sel_val int 1 run scoreboard players get #temp_cursor editor
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run function rhythm_axe:editor/menu/note/list/note_checkbox_write with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run function rhythm_axe:editor/menu/note/list/note_list_line with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run data remove storage rhythm_axe:prop checkbox
execute if data storage rhythm_axe:prop found_index if score #show_row editor matches 1 run data remove storage rhythm_axe:prop sel_val
# 清理 find 临时键（渲染后必须清 note_id/found_index，防残留影响下次 find_by_id）
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
