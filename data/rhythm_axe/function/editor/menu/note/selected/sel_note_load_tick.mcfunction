# 已选定音符列表：异步分刻渲染 —— 每刻处理一个 selection 元素（宏 sel_note_list_row 单行），避免单次 O(选中×全谱) 命令超限
# 前置：maps.editor sel_loading=1、prop.cursor/sel_index、#sel_total/#sel_page_start 已由 sel_note_list_open 设置
# 到达当前页末尾或全部选中 → 收尾页脚 sel_note_list_footer
execute store result score #sel_i editor run data get storage rhythm_axe:prop sel_index
scoreboard players operation #sel_end editor = #sel_page_start editor
scoreboard players add #sel_end editor 40
execute if score #sel_i editor >= #sel_total editor run function rhythm_axe:editor/menu/note/selected/sel_note_list_footer
execute if score #sel_i editor >= #sel_total editor run return 0
execute if score #sel_i editor >= #sel_end editor run function rhythm_axe:editor/menu/note/selected/sel_note_list_footer
execute if score #sel_i editor >= #sel_end editor run return 0
# 当前元素若在本页（页内相对 0..39）才渲染，否则只推进（跳过非本页行，仍走 find_by_id）
scoreboard players operation #temp editor = #sel_i editor
scoreboard players operation #temp editor -= #sel_page_start editor
execute if score #temp editor matches 0..39 run function rhythm_axe:editor/menu/note/selected/sel_note_list_row with storage rhythm_axe:prop
# 递增索引
execute store result score #sel_i editor run data get storage rhythm_axe:prop sel_index
scoreboard players add #sel_i editor 1
execute store result storage rhythm_axe:prop sel_index int 1 run scoreboard players get #sel_i editor
