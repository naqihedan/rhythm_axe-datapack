# 已选定音符列表遍历驱动器（普通函数）——处理当前 selection 元素，再递增继续
# ★ 26.x 宏递归"幽灵重跑"：递归都在普通函数做，宏叶子 sel_note_list_row 只处理单个元素
# 前置：prop.cursor、prop.sel_index
execute store result score #sel_i editor run data get storage rhythm_axe:prop sel_index
scoreboard players set #sel_total editor 0
execute if data storage rhythm_axe:maps.editor selection run execute store result score #sel_total editor run data get storage rhythm_axe:maps.editor selection
# 越界或超上限（按钮段每组 40 行）→ 结束
execute if score #sel_i editor >= #sel_total editor run return 0
execute if score #sel_i editor matches 40.. run return 0
# 处理当前元素（宏叶子：读 id + find_by_id + 渲染）
function rhythm_axe:editor/menu/note/selected/sel_note_list_row with storage rhythm_axe:prop
# 递增索引
scoreboard players add #sel_i editor 1
execute store result storage rhythm_axe:prop sel_index int 1 run scoreboard players get #sel_i editor
# 继续遍历（普通函数递归可靠）
execute if score #sel_i editor < #sel_total editor run function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
