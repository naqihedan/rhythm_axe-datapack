# 面板 18：已选定音符列表（规范v2：11401 返回 / 11402 清空返回 / 11403 批量编辑 / 11404 批量复制 / 11405 批量粘贴；
#            100000..103999 动态行；11601/11602 翻页；11501/11502/11503-11506 翻转组）。
#   动态行：值 = 100000 + 页内序×100 + 列码（复选框 0 / 编辑 3 / 复制 5 / 粘贴 6 / 删除 7；页内序 0..39）
# sel_note_list_open 设 current_panel=18。返回用 1560/1561，本面板不含值 1。
# 入口白名单守卫
execute unless score #click_value editor matches 11401..11405 unless score #click_value editor matches 100000..103999 unless score #click_value editor matches 11601..11602 unless score #click_value editor matches 11501 unless score #click_value editor matches 11502 unless score #click_value editor matches 11503..11506 unless score #click_value editor matches 11507..11509 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 11401..11405 unless score #click_value editor matches 100000..103999 unless score #click_value editor matches 11601..11602 unless score #click_value editor matches 11501 unless score #click_value editor matches 11502 unless score #click_value editor matches 11503..11506 unless score #click_value editor matches 11507..11509 run return fail

# 【返回】1560：仅返回主菜单（不清空 selection）
execute if score #click_value editor matches 11401 run function rhythm_axe:editor/menu/main
# 【清空选中并返回】1561
execute if score #click_value editor matches 11402 run function rhythm_axe:editor/menu/note/selected/sel_clear_all
execute if score #click_value editor matches 11402 run scoreboard players set #sel_count editor 0
execute if score #click_value editor matches 11402 run execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute if score #click_value editor matches 11402 run execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
execute if score #click_value editor matches 11402 run function rhythm_axe:editor/menu/main
# 【批量编辑】1562 / 【批量复制】1563 / 【批量粘贴】1564
execute if score #click_value editor matches 11403 run function rhythm_axe:editor/menu/note/batch/batch_open
execute if score #click_value editor matches 11404 run function rhythm_axe:editor/menu/note/selected/sel_batch_copy
execute if score #click_value editor matches 11405 run function rhythm_axe:editor/menu/note/selected/sel_batch_paste

# —— 动态行（值 = 100000 + 页内序×100 + 列码）：抠出列码(#temp_cursor) 与 页内序(#temp) ——
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 100000..103999 run scoreboard players remove #temp_cursor editor 100000
execute if score #click_value editor matches 100000..103999 run scoreboard players set #temp editor 100
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp_cursor editor %= #temp editor
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 100000..103999 run scoreboard players remove #temp editor 100000
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor /= 100 const
# sel_idx = sel_page×40 + 页内序（所有列共用）
execute if score #click_value editor matches 100000..103999 run execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor sel_page
execute if score #click_value editor matches 100000..103999 run scoreboard players set #temp_ig editor 40
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp_playhead editor *= #temp_ig editor
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor += #temp_playhead editor
# 复选框 0：取消选中该音符并重开已选定列表
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 0 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_note_toggle with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 0 run data remove storage rhythm_axe:prop sel_idx
# 编辑 3（进面板 11）
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 3 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 3 run function rhythm_axe:editor/menu/note/selected/sel_note_panel_open_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 3 run data remove storage rhythm_axe:prop sel_idx
# 复制 5
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 5 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 5 run function rhythm_axe:editor/menu/note/selected/sel_note_copy_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 5 run data remove storage rhythm_axe:prop sel_idx
# 粘贴 6
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 6 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 6 run function rhythm_axe:editor/menu/note/selected/sel_note_paste_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 6 run data remove storage rhythm_axe:prop sel_idx
# 删除 7
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 7 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 7 run function rhythm_axe:editor/menu/note/selected/sel_note_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 7 run data remove storage rhythm_axe:prop sel_idx
# 清理临时
execute if score #click_value editor matches 100000..103999 run scoreboard players reset #temp editor
execute if score #click_value editor matches 100000..103999 run scoreboard players reset #temp_cursor editor
# 翻页（本面板 → sel_note_prev/next_page）
execute if score #click_value editor matches 11601 run function rhythm_axe:editor/menu/note/selected/sel_note_prev_page
execute if score #click_value editor matches 11602 run function rhythm_axe:editor/menu/note/selected/sel_note_next_page

# —— 时间轴翻转（11501）与镜像翻转组（11502/11503/11504/11505 开关 + 11506 执行），本面板刷新 sel_note_list_open ——
execute if score #click_value editor matches 11501 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time
execute if score #click_value editor matches 11501 run return 0
# X 开关（11502）
execute if score #click_value editor matches 11502 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.x
execute if score #click_value editor matches 11502 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.x set value 1b
execute if score #click_value editor matches 11502 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.x set value 0b
execute if score #click_value editor matches 11502 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11502 run return 0
# Y 开关（11503）
execute if score #click_value editor matches 11503 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.y
execute if score #click_value editor matches 11503 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.y set value 1b
execute if score #click_value editor matches 11503 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.y set value 0b
execute if score #click_value editor matches 11503 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11503 run return 0
# Z 开关（11504）
execute if score #click_value editor matches 11504 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.z
execute if score #click_value editor matches 11504 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.z set value 1b
execute if score #click_value editor matches 11504 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.z set value 0b
execute if score #click_value editor matches 11504 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11504 run return 0
# S 开关（11505）
execute if score #click_value editor matches 11505 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.s
execute if score #click_value editor matches 11505 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.s set value 1b
execute if score #click_value editor matches 11505 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.s set value 0b
execute if score #click_value editor matches 11505 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11505 run return 0
# 执行翻转（11506）
execute if score #click_value editor matches 11506 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_mirror
execute if score #click_value editor matches 11506 run return 0
# 旋转（11507=15° / 11508=45° / 11509=90°）：写角度 cos/sin（×10000）后按 [X][Y][Z] 开关绕包围盒中心轴旋转
execute if score #click_value editor matches 11507 run data modify storage rhythm_axe:prop rotate_cos set value 9659
execute if score #click_value editor matches 11507 run data modify storage rhythm_axe:prop rotate_sin set value 2588
execute if score #click_value editor matches 11508 run data modify storage rhythm_axe:prop rotate_cos set value 7071
execute if score #click_value editor matches 11508 run data modify storage rhythm_axe:prop rotate_sin set value 7071
execute if score #click_value editor matches 11509 run data modify storage rhythm_axe:prop rotate_cos set value 0
execute if score #click_value editor matches 11509 run data modify storage rhythm_axe:prop rotate_sin set value 10000
execute if score #click_value editor matches 11507..11509 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate
execute if score #click_value editor matches 11507..11509 run return 0
