# 面板 10：音符活跃列表（1 返回；600..759 各行 编辑/复制/粘贴/删除；1600..1639 复选框；1640 清空选中；
#            1641/1642 批量复制粘贴；1562 批量编辑；1683 全选；1684/1685 翻页；909/910/914-917 时间轴翻转组）。
# note_list_open 设 current_panel=10。本面板刷新用 note_list_*。
# 入口白名单守卫
execute unless score #click_value editor matches 1 unless score #click_value editor matches 600..759 unless score #click_value editor matches 1562 unless score #click_value editor matches 1600..1639 unless score #click_value editor matches 1640..1642 unless score #click_value editor matches 1683 unless score #click_value editor matches 1684..1685 unless score #click_value editor matches 909 unless score #click_value editor matches 910 unless score #click_value editor matches 914..917 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 600..759 unless score #click_value editor matches 1562 unless score #click_value editor matches 1600..1639 unless score #click_value editor matches 1640..1642 unless score #click_value editor matches 1683 unless score #click_value editor matches 1684..1685 unless score #click_value editor matches 909 unless score #click_value editor matches 910 unless score #click_value editor matches 914..917 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
# 各行操作（按存活序：编辑 600+ / 复制 640+ / 粘贴 680+ / 删除 720+；编辑进面板 11）
execute if score #click_value editor matches 600..639 run function rhythm_axe:editor/menu/note/panel/note_panel_open_prep
execute if score #click_value editor matches 640..679 run function rhythm_axe:editor/menu/note/list/note_list_copy_prep
execute if score #click_value editor matches 680..719 run function rhythm_axe:editor/menu/note/list/note_list_paste_prep
execute if score #click_value editor matches 720..759 run function rhythm_axe:editor/menu/note/list/note_list_delete_prep
# 复选框（1600..1639）
execute if score #click_value editor matches 1600..1639 run function rhythm_axe:editor/menu/note/list/note_list_toggle
# 取消选中（不退出列表）：清空 selection + 熄灭高亮，然后刷新列表
execute if score #click_value editor matches 1640 run function rhythm_axe:editor/menu/note/selected/sel_clear_all
execute if score #click_value editor matches 1640 run scoreboard players set #sel_count editor 0
execute if score #click_value editor matches 1640 run execute as @e[type=item_display,tag=editor_note] run data modify entity @s Glowing set value 0b
execute if score #click_value editor matches 1640 run execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
execute if score #click_value editor matches 1640 run function rhythm_axe:editor/menu/note/list/note_list_open
# 批量复制/粘贴（1641/1642）
execute if score #click_value editor matches 1641 run function rhythm_axe:editor/menu/note/list/note_list_batch_copy
execute if score #click_value editor matches 1642 run function rhythm_axe:editor/menu/note/list/note_list_batch_paste
# 批量编辑（1562，进面板 11）
execute if score #click_value editor matches 1562 run function rhythm_axe:editor/menu/note/batch/batch_open
# 全部选中（1683）
execute if score #click_value editor matches 1683 run function rhythm_axe:editor/menu/note/list/sel_select_all
# 翻页（本面板 → note_list_prev/next_page）
execute if score #click_value editor matches 1684 run function rhythm_axe:editor/menu/note/list/note_list_prev_page
execute if score #click_value editor matches 1685 run function rhythm_axe:editor/menu/note/list/note_list_next_page

# —— 时间轴翻转（909）与镜像翻转组（910/914/915/916 开关 + 917 执行），本面板刷新 note_list_open ——
execute if score #click_value editor matches 909 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time
execute if score #click_value editor matches 909 run return 0
# X 开关（910）
execute if score #click_value editor matches 910 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.x
execute if score #click_value editor matches 910 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.x set value 1b
execute if score #click_value editor matches 910 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.x set value 0b
execute if score #click_value editor matches 910 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 910 run return 0
# Y 开关（914）
execute if score #click_value editor matches 914 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.y
execute if score #click_value editor matches 914 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.y set value 1b
execute if score #click_value editor matches 914 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.y set value 0b
execute if score #click_value editor matches 914 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 914 run return 0
# Z 开关（915）
execute if score #click_value editor matches 915 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.z
execute if score #click_value editor matches 915 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.z set value 1b
execute if score #click_value editor matches 915 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.z set value 0b
execute if score #click_value editor matches 915 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 915 run return 0
# S 开关（916）
execute if score #click_value editor matches 916 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.s
execute if score #click_value editor matches 916 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.s set value 1b
execute if score #click_value editor matches 916 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.s set value 0b
execute if score #click_value editor matches 916 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 916 run return 0
# 执行翻转（917）
execute if score #click_value editor matches 917 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_mirror
execute if score #click_value editor matches 917 run return 0
