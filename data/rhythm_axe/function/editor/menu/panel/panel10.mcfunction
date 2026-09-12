# 面板 10：音符活跃列表（规范v2：1 返回；100000..103999 动态行；11301..11305 固定控件；11601/11602 翻页）。
#   动态行：值 = 100000 + 页内序×100 + 列码（复选框 0 / 编辑 3 / 复制 5 / 粘贴 6 / 删除 7；页内序 0..39）
#   固定：11301 批量编辑 / 11302 批量复制 / 11303 批量粘贴 / 11304 全选 / 11305 取消选中 / 11601 上一页 / 11602 下一页
#   翻转组沿用固定值 11501(翻转时间) / 11502,11503,11504,11505(X/Y/Z/S 开关) / 11506(执行翻转)（面板 10/18 共用）
# note_list_open 设 current_panel=10。本面板刷新用 note_list_*。
# 入口白名单守卫
execute unless score #click_value editor matches 1 unless score #click_value editor matches 100000..103999 unless score #click_value editor matches 11301..11305 unless score #click_value editor matches 11601..11602 unless score #click_value editor matches 11501 unless score #click_value editor matches 11502 unless score #click_value editor matches 11503..11506 unless score #click_value editor matches 11507..11509 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 100000..103999 unless score #click_value editor matches 11301..11305 unless score #click_value editor matches 11601..11602 unless score #click_value editor matches 11501 unless score #click_value editor matches 11502 unless score #click_value editor matches 11503..11506 unless score #click_value editor matches 11507..11509 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
# —— 动态行（值 = 100000 + 页内序×100 + 列码）：先抠列码（#temp = (click-100000) % 100）再分发 ——
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 100000..103999 run scoreboard players remove #temp editor 100000
execute if score #click_value editor matches 100000..103999 run scoreboard players set #temp_cursor editor 100
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor %= #temp_cursor editor
# 复选框 0
execute if score #click_value editor matches 100000..103999 if score #temp editor matches 0 run function rhythm_axe:editor/menu/note/list/note_list_toggle
# 编辑 3（进面板 11）
execute if score #click_value editor matches 100000..103999 if score #temp editor matches 3 run function rhythm_axe:editor/menu/note/panel/note_panel_open_prep
# 复制 5
execute if score #click_value editor matches 100000..103999 if score #temp editor matches 5 run function rhythm_axe:editor/menu/note/list/note_list_copy_prep
# 粘贴 6
execute if score #click_value editor matches 100000..103999 if score #temp editor matches 6 run function rhythm_axe:editor/menu/note/list/note_list_paste_prep
# 删除 7
execute if score #click_value editor matches 100000..103999 if score #temp editor matches 7 run function rhythm_axe:editor/menu/note/list/note_list_delete_prep
# 清理临时列码
execute if score #click_value editor matches 100000..103999 run scoreboard players reset #temp editor
# 取消选中（不退出列表）：清空 selection + 熄灭高亮，然后刷新列表
execute if score #click_value editor matches 11305 run function rhythm_axe:editor/menu/note/selected/sel_clear_all
execute if score #click_value editor matches 11305 run scoreboard players set #sel_count editor 0
execute if score #click_value editor matches 11305 run execute as @e[type=item_display,tag=editor_note] run data modify entity @s Glowing set value 0b
execute if score #click_value editor matches 11305 run execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
execute if score #click_value editor matches 11305 run function rhythm_axe:editor/menu/note/list/note_list_open
# 批量复制/粘贴（1641/1642）
execute if score #click_value editor matches 11302 run function rhythm_axe:editor/menu/note/list/note_list_batch_copy
execute if score #click_value editor matches 11303 run function rhythm_axe:editor/menu/note/list/note_list_batch_paste
# 批量编辑（1562，进面板 11）
execute if score #click_value editor matches 11301 run function rhythm_axe:editor/menu/note/batch/batch_open
# 全部选中（1683）
execute if score #click_value editor matches 11304 run function rhythm_axe:editor/menu/note/list/sel_select_all
# 翻页（本面板 → note_list_prev/next_page）
execute if score #click_value editor matches 11601 run function rhythm_axe:editor/menu/note/list/note_list_prev_page
execute if score #click_value editor matches 11602 run function rhythm_axe:editor/menu/note/list/note_list_next_page

# —— 时间轴翻转（11501）与镜像翻转组（11502/11503/11504/11505 开关 + 11506 执行），本面板刷新 note_list_open ——
execute if score #click_value editor matches 11501 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time
execute if score #click_value editor matches 11501 run return 0
# X 开关（11502）
execute if score #click_value editor matches 11502 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.x
execute if score #click_value editor matches 11502 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.x set value 1b
execute if score #click_value editor matches 11502 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.x set value 0b
execute if score #click_value editor matches 11502 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 11502 run return 0
# Y 开关（11503）
execute if score #click_value editor matches 11503 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.y
execute if score #click_value editor matches 11503 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.y set value 1b
execute if score #click_value editor matches 11503 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.y set value 0b
execute if score #click_value editor matches 11503 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 11503 run return 0
# Z 开关（11504）
execute if score #click_value editor matches 11504 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.z
execute if score #click_value editor matches 11504 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.z set value 1b
execute if score #click_value editor matches 11504 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.z set value 0b
execute if score #click_value editor matches 11504 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 11504 run return 0
# S 开关（11505）
execute if score #click_value editor matches 11505 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.s
execute if score #click_value editor matches 11505 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.s set value 1b
execute if score #click_value editor matches 11505 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.s set value 0b
execute if score #click_value editor matches 11505 run function rhythm_axe:editor/menu/note/list/note_list_open
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
