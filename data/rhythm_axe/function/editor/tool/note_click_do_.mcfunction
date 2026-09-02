# 对匹配到的被点击音符实体执行操作（@s = 音符交互实体）
# 不 remove interaction，保证该音符可再次点击（选中 → 打开面板的第二次点击）
scoreboard players operation #nc_id editor = @s note_id
# 快照该音符是否已选中（在可能被选中前记录，避免选中后再判断误判）
scoreboard players set #nc_was_selected editor 0
execute if entity @s[tag=editor_note_selected] run scoreboard players set #nc_was_selected editor 1
# 已选中 + Shift+左键 + 暂停 → 读取交互实体偏移加到判定位置，再打开/刷新音符属性控制面板
execute if score #click_offset_mode editor matches 1 if score #nc_was_selected editor matches 1 run function rhythm_axe:editor/tool/note_offset_read
execute if score #click_offset_mode editor matches 1 if score #nc_was_selected editor matches 1 run execute as @a[tag=editor_active] run function rhythm_axe:editor/tool/note_offset_go
execute if score #click_offset_mode editor matches 1 if score #nc_was_selected editor matches 1 run return 0
# 已选中 → 打开其编辑面板；未选中 → 选中它并打开「已选定音符列表」（面板 18）
execute if score #nc_was_selected editor matches 1 run execute as @a[tag=editor_active] run function rhythm_axe:editor/tool/note_click_open
execute unless score #nc_was_selected editor matches 1 run execute as @a[tag=editor_active] run function rhythm_axe:editor/tool/note_click_select
execute unless score #nc_was_selected editor matches 1 run execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
