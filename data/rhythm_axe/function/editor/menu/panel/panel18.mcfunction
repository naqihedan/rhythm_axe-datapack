# 面板 18：已选定音符列表（1560 返回 / 1561 清空返回 / 1562 批量编辑 / 1563/1564 批量复制粘贴 /
#            1400..1559 各行 编辑/复制/粘贴/删除；1643..1682 复选框；1684/1685 翻页；909/910/914-917 时间轴翻转组）。
# sel_note_list_open 设 current_panel=18。返回用 1560/1561，本面板不含值 1。
# 入口白名单守卫
execute unless score #click_value editor matches 1560..1564 unless score #click_value editor matches 1400..1559 unless score #click_value editor matches 1643..1682 unless score #click_value editor matches 1684..1685 unless score #click_value editor matches 909 unless score #click_value editor matches 910 unless score #click_value editor matches 914..917 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1560..1564 unless score #click_value editor matches 1400..1559 unless score #click_value editor matches 1643..1682 unless score #click_value editor matches 1684..1685 unless score #click_value editor matches 909 unless score #click_value editor matches 910 unless score #click_value editor matches 914..917 run return fail

# 【返回】1560：仅返回主菜单（不清空 selection）
execute if score #click_value editor matches 1560 run function rhythm_axe:editor/menu/main
# 【清空选中并返回】1561
execute if score #click_value editor matches 1561 run function rhythm_axe:editor/menu/note/selected/sel_clear_all
execute if score #click_value editor matches 1561 run scoreboard players set #sel_count editor 0
execute if score #click_value editor matches 1561 run execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute if score #click_value editor matches 1561 run execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
execute if score #click_value editor matches 1561 run function rhythm_axe:editor/menu/main
# 【批量编辑】1562 / 【批量复制】1563 / 【批量粘贴】1564
execute if score #click_value editor matches 1562 run function rhythm_axe:editor/menu/note/batch/batch_open
execute if score #click_value editor matches 1563 run function rhythm_axe:editor/menu/note/selected/sel_batch_copy
execute if score #click_value editor matches 1564 run function rhythm_axe:editor/menu/note/selected/sel_batch_paste

# 各行操作（sel_idx = sel_page*40 + (click-底)）
execute if score #click_value editor matches 1400..1439 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #click_value editor matches 1400..1439 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 1400..1439 run scoreboard players remove #temp_cursor editor 1400
execute if score #click_value editor matches 1400..1439 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #click_value editor matches 1400..1439 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1400..1439 run function rhythm_axe:editor/menu/note/selected/sel_note_panel_open_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1400..1439 run data remove storage rhythm_axe:prop sel_idx
execute if score #click_value editor matches 1440..1479 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #click_value editor matches 1440..1479 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 1440..1479 run scoreboard players remove #temp_cursor editor 1440
execute if score #click_value editor matches 1440..1479 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #click_value editor matches 1440..1479 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1440..1479 run function rhythm_axe:editor/menu/note/selected/sel_note_copy_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1440..1479 run data remove storage rhythm_axe:prop sel_idx
execute if score #click_value editor matches 1480..1519 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #click_value editor matches 1480..1519 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 1480..1519 run scoreboard players remove #temp_cursor editor 1480
execute if score #click_value editor matches 1480..1519 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #click_value editor matches 1480..1519 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1480..1519 run function rhythm_axe:editor/menu/note/selected/sel_note_paste_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1480..1519 run data remove storage rhythm_axe:prop sel_idx
execute if score #click_value editor matches 1520..1559 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #click_value editor matches 1520..1559 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 1520..1559 run scoreboard players remove #temp_cursor editor 1520
execute if score #click_value editor matches 1520..1559 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #click_value editor matches 1520..1559 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1520..1559 run function rhythm_axe:editor/menu/note/selected/sel_note_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1520..1559 run data remove storage rhythm_axe:prop sel_idx
# 【复选框】1643+页内序：取消选中该音符并重开已选定列表
execute if score #click_value editor matches 1643..1682 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #click_value editor matches 1643..1682 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 1643..1682 run scoreboard players remove #temp_cursor editor 1643
execute if score #click_value editor matches 1643..1682 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #click_value editor matches 1643..1682 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1643..1682 run function rhythm_axe:editor/menu/note/selected/sel_note_toggle with storage rhythm_axe:prop
execute if score #click_value editor matches 1643..1682 run data remove storage rhythm_axe:prop sel_idx
# 翻页（本面板 → sel_note_prev/next_page）
execute if score #click_value editor matches 1684 run function rhythm_axe:editor/menu/note/selected/sel_note_prev_page
execute if score #click_value editor matches 1685 run function rhythm_axe:editor/menu/note/selected/sel_note_next_page

# —— 时间轴翻转（909）与镜像翻转组（910/914/915/916 开关 + 917 执行），本面板刷新 sel_note_list_open ——
execute if score #click_value editor matches 909 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time
execute if score #click_value editor matches 909 run return 0
# X 开关（910）
execute if score #click_value editor matches 910 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.x
execute if score #click_value editor matches 910 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.x set value 1b
execute if score #click_value editor matches 910 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.x set value 0b
execute if score #click_value editor matches 910 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 910 run return 0
# Y 开关（914）
execute if score #click_value editor matches 914 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.y
execute if score #click_value editor matches 914 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.y set value 1b
execute if score #click_value editor matches 914 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.y set value 0b
execute if score #click_value editor matches 914 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 914 run return 0
# Z 开关（915）
execute if score #click_value editor matches 915 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.z
execute if score #click_value editor matches 915 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.z set value 1b
execute if score #click_value editor matches 915 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.z set value 0b
execute if score #click_value editor matches 915 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 915 run return 0
# S 开关（916）
execute if score #click_value editor matches 916 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.s
execute if score #click_value editor matches 916 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.s set value 1b
execute if score #click_value editor matches 916 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.s set value 0b
execute if score #click_value editor matches 916 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 916 run return 0
# 执行翻转（917）
execute if score #click_value editor matches 917 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_mirror
execute if score #click_value editor matches 917 run return 0
