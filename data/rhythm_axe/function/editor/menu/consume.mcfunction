# 消费 editor_click 点击值并分发（@s = 玩家；tick 检测 @a[scores={editor_click=1..}]）
execute store result score #click_value editor run scoreboard players get @s editor_click
scoreboard players reset @s editor_click
scoreboard players enable @s editor_click

# ★ 统一操作反馈音：所有 trigger 按钮点击（含 903/时间控件/撤销重做/各面板按钮）
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1

# 返回编辑器（903）：重进存档后无条件恢复编辑并打开上次所在面板（绕过 active 检查与面板隔离）
execute if score #click_value editor matches 903 run data modify storage rhythm_axe:maps.editor active set value 1b
execute if score #click_value editor matches 903 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 903 run return fail

# 仅在编辑中响应
execute unless data storage rhythm_axe:maps.editor {active:1b} run return fail

# 时间控件（20-29）：任意面板可用（提前分发并返回，绕过面板隔离；面板按钮值 20-29 与各子面板不冲突）
execute if score #click_value editor matches 20 run data modify storage rhythm_axe:prop kind set value "bar"
execute if score #click_value editor matches 20 run data modify storage rhythm_axe:prop direction set value "back"
execute if score #click_value editor matches 20 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 21 run data modify storage rhythm_axe:prop kind set value "beat"
execute if score #click_value editor matches 21 run data modify storage rhythm_axe:prop direction set value "back"
execute if score #click_value editor matches 21 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 22 run data modify storage rhythm_axe:prop direction set value "back"
execute if score #click_value editor matches 22 run data modify storage rhythm_axe:prop ticks set value 1
execute if score #click_value editor matches 22 run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
execute if score #click_value editor matches 23 run function rhythm_axe:editor/menu/playback_toggle
execute if score #click_value editor matches 24 run data modify storage rhythm_axe:prop direction set value "fwd"
execute if score #click_value editor matches 24 run data modify storage rhythm_axe:prop ticks set value 1
execute if score #click_value editor matches 24 run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
execute if score #click_value editor matches 25 run data modify storage rhythm_axe:prop kind set value "beat"
execute if score #click_value editor matches 25 run data modify storage rhythm_axe:prop direction set value "fwd"
execute if score #click_value editor matches 25 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 26 run data modify storage rhythm_axe:prop kind set value "bar"
execute if score #click_value editor matches 26 run data modify storage rhythm_axe:prop direction set value "fwd"
execute if score #click_value editor matches 26 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 27 run function rhythm_axe:editor/menu/cycle_speed
execute if score #click_value editor matches 28 run function rhythm_axe:editor/menu/jump/jump_start
execute if score #click_value editor matches 29 run function rhythm_axe:editor/menu/jump/jump_end
execute if score #click_value editor matches 20..29 run data remove storage rhythm_axe:prop kind
execute if score #click_value editor matches 20..29 run return 0

# 撤销/重做（8/9）：任意面板可用，撤销/重做后回操作面板（undo_panel 记录的最新操作所在面板）
execute if score #click_value editor matches 8 run function rhythm_axe:editor/file/undo
execute if score #click_value editor matches 8 run data modify storage rhythm_axe:maps.editor current_panel set from storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 8 run data remove storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 8 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 8 run return 0
execute if score #click_value editor matches 9 run function rhythm_axe:editor/file/redo
execute if score #click_value editor matches 9 run data modify storage rhythm_axe:maps.editor current_panel set from storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 9 run data remove storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 9 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 9 run return 0

# 面板隔离：只执行当前打开面板的按钮（防止串面板误操作）
execute store result score #panel_id editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #panel_id editor matches 1 unless score #click_value editor matches 1..15 unless score #click_value editor matches 20..29 unless score #click_value editor matches 131..132 unless score #click_value editor matches 137 unless score #click_value editor matches 138 unless score #click_value editor matches 139..142 unless score #click_value editor matches 150..151 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 1 unless score #click_value editor matches 1..15 unless score #click_value editor matches 20..29 unless score #click_value editor matches 131..132 unless score #click_value editor matches 137 unless score #click_value editor matches 138 unless score #click_value editor matches 139..142 unless score #click_value editor matches 150..151 run return fail
execute if score #panel_id editor matches 2 unless score #click_value editor matches 101..134 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 2 unless score #click_value editor matches 101..134 run return fail
execute if score #panel_id editor matches 3 unless score #click_value editor matches 1 unless score #click_value editor matches 3 unless score #click_value editor matches 201..299 unless score #click_value editor matches 280 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 3 unless score #click_value editor matches 1 unless score #click_value editor matches 3 unless score #click_value editor matches 201..299 unless score #click_value editor matches 280 run return fail
execute if score #panel_id editor matches 4 unless score #click_value editor matches 301..323 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 4 unless score #click_value editor matches 301..323 run return fail
execute if score #panel_id editor matches 5 unless score #click_value editor matches 1 unless score #click_value editor matches 4 unless score #click_value editor matches 401..449 unless score #click_value editor matches 480..482 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 5 unless score #click_value editor matches 1 unless score #click_value editor matches 4 unless score #click_value editor matches 401..449 unless score #click_value editor matches 480..482 run return fail
execute if score #panel_id editor matches 6 unless score #click_value editor matches 500..539 unless score #click_value editor matches 560..589 unless score #click_value editor matches 590..592 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 6 unless score #click_value editor matches 500..539 unless score #click_value editor matches 560..589 unless score #click_value editor matches 590..592 run return fail
execute if score #panel_id editor matches 7 unless score #click_value editor matches 1 unless score #click_value editor matches 30..32 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 7 unless score #click_value editor matches 1 unless score #click_value editor matches 30..32 run return fail
execute if score #panel_id editor matches 8 unless score #click_value editor matches 901..903 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 8 unless score #click_value editor matches 901..903 run return fail
execute if score #panel_id editor matches 9 unless score #click_value editor matches 40..42 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 9 unless score #click_value editor matches 40..42 run return fail
execute if score #panel_id editor matches 10 unless score #click_value editor matches 1 unless score #click_value editor matches 600..759 unless score #click_value editor matches 1600..1639 unless score #click_value editor matches 1562 unless score #click_value editor matches 1640 unless score #click_value editor matches 1641..1642 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 10 unless score #click_value editor matches 1 unless score #click_value editor matches 600..759 unless score #click_value editor matches 1600..1639 unless score #click_value editor matches 1562 unless score #click_value editor matches 1640 unless score #click_value editor matches 1641..1642 run return fail
execute if score #panel_id editor matches 11 unless score #click_value editor matches 760..805 unless score #click_value editor matches 856 unless score #click_value editor matches 860..887 unless score #click_value editor matches 787..790 unless score #click_value editor matches 890 unless score #click_value editor matches 891..893 unless score #click_value editor matches 894..895 unless score #click_value editor matches 896..899 unless score #click_value editor matches 904..908 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 11 unless score #click_value editor matches 760..805 unless score #click_value editor matches 856 unless score #click_value editor matches 860..887 unless score #click_value editor matches 787..790 unless score #click_value editor matches 890 unless score #click_value editor matches 891..893 unless score #click_value editor matches 894..895 unless score #click_value editor matches 896..899 unless score #click_value editor matches 904..908 run return fail
execute if score #panel_id editor matches 12 unless score #click_value editor matches 806..827 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 12 unless score #click_value editor matches 806..827 run return fail
execute if score #panel_id editor matches 13 unless score #click_value editor matches 830..851 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 13 unless score #click_value editor matches 830..851 run return fail
execute if score #panel_id editor matches 14 unless score #click_value editor matches 857..859 unless score #click_value editor matches 10000..99999 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 14 unless score #click_value editor matches 857..859 unless score #click_value editor matches 10000..99999 run return fail
execute if score #panel_id editor matches 15 unless score #click_value editor matches 911..913 unless score #click_value editor matches 903 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 15 unless score #click_value editor matches 911..913 unless score #click_value editor matches 903 run return fail
# 面板 16（删除谱面确认）：135 确认删除 / 136 取消
execute if score #panel_id editor matches 16 unless score #click_value editor matches 135..136 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 16 unless score #click_value editor matches 135..136 run return fail
# 面板 17（回收站）：1 返回 + 1370-1373 确认/取消 + 1380..1389 还原 + 1390..1399 彻底删除
execute if score #panel_id editor matches 17 unless score #click_value editor matches 1 unless score #click_value editor matches 1370..1373 unless score #click_value editor matches 1380..1389 unless score #click_value editor matches 1390..1399 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 17 unless score #click_value editor matches 1 unless score #click_value editor matches 1370..1373 unless score #click_value editor matches 1380..1389 unless score #click_value editor matches 1390..1399 run return fail
# 面板 18（已选定音符列表）：1560 返回 + 1561 清空选中 + 1562 批量编辑 + 1563 批量复制 + 1564 批量粘贴 + 1400-1559（编辑/复制/粘贴/删除）+ 1643-1682（复选框去选）
execute if score #panel_id editor matches 18 unless score #click_value editor matches 1560..1564 unless score #click_value editor matches 1400..1559 unless score #click_value editor matches 1643..1682 run tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
execute if score #panel_id editor matches 18 unless score #click_value editor matches 1560..1564 unless score #click_value editor matches 1400..1559 unless score #click_value editor matches 1643..1682 run return fail

# 按点击值分发
execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 2 run function rhythm_axe:editor/menu/map/panel/map_panel_open
execute if score #click_value editor matches 3 run function rhythm_axe:editor/menu/timing/list/timing_list_open
execute if score #click_value editor matches 4 run function rhythm_axe:editor/menu/event/list/event_list_open
execute if score #click_value editor matches 5 run function rhythm_axe:editor/tool/give_note_tool
execute if score #click_value editor matches 6 run function rhythm_axe:editor/tool/give_timeline_tool
execute if score #click_value editor matches 7 run function rhythm_axe:editor/menu/metronome_toggle
execute if score #click_value editor matches 14 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 15 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
# 时间控件 28/29（返回开头/结尾）已提前到面板隔离前分发
# 时间控件 28/29 占位：原 jump_start/jump_end 分发已上移
execute if score #click_value editor matches 130 run function rhythm_axe:editor/menu/map/ops/map_tp_to_spawn

# 主菜单音符流速（131 降低 / 132 提高，读改全局 note_speed，下界 1；调整后刷新世界音符）
execute if score #click_value editor matches 131 run scoreboard players remove note_speed options 1
execute if score #click_value editor matches 132 run scoreboard players add note_speed options 1
execute if score #click_value editor matches 131..132 if score note_speed options matches ..0 run scoreboard players set note_speed options 1
execute if score #click_value editor matches 131..132 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 131..132 run function rhythm_axe:editor/menu/main
# 主菜单音符流速直接设值（139/140/141/142 = 2/4/8/16；调整后刷新世界音符）
execute if score #click_value editor matches 139 run scoreboard players set note_speed options 2
execute if score #click_value editor matches 140 run scoreboard players set note_speed options 4
execute if score #click_value editor matches 141 run scoreboard players set note_speed options 8
execute if score #click_value editor matches 142 run scoreboard players set note_speed options 16
execute if score #click_value editor matches 139..142 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 139..142 run function rhythm_axe:editor/menu/main

# 谱面设置面板（修改只动暂存 panel_temp；保存设置才写回）
execute if score #click_value editor matches 101 run function rhythm_axe:editor/menu/dialog/dialog_open_title
execute if score #click_value editor matches 102 run function rhythm_axe:editor/menu/dialog/dialog_open_author
execute if score #click_value editor matches 103 run function rhythm_axe:editor/menu/dialog/dialog_open_music
execute if score #click_value editor matches 104 run function rhythm_axe:editor/menu/dialog/dialog_open_preview
execute if score #click_value editor matches 105 run function rhythm_axe:editor/menu/map/ops/map_set_teleport {"value":"0b"}
execute if score #click_value editor matches 129 run function rhythm_axe:editor/menu/map/ops/map_set_teleport {"value":"1b"}
execute if score #click_value editor matches 106 run function rhythm_axe:editor/menu/dialog/dialog_open_mapid
execute if score #click_value editor matches 117 run function rhythm_axe:editor/menu/map/ops/map_use_player_pos
execute if score #click_value editor matches 127 run function rhythm_axe:editor/menu/map/ops/map_use_player_rotation
execute if score #click_value editor matches 118 run function rhythm_axe:editor/menu/map/panel/map_panel_save
execute if score #click_value editor matches 119 run function rhythm_axe:editor/menu/map/panel/map_panel_cancel
execute if score #click_value editor matches 134 run function rhythm_axe:editor/menu/map/panel/map_delete_confirm
execute if score #click_value editor matches 137 run function rhythm_axe:editor/menu/map/panel/map_delete_confirm
# 135 确认删除：重新读 mapid 进 prop 再调（确认面板已清 prop）
execute if score #click_value editor matches 135 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
execute if score #click_value editor matches 135 run function rhythm_axe:editor/menu/map/panel/map_delete_go with storage rhythm_axe:prop
execute if score #click_value editor matches 135 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 136 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 124 run function rhythm_axe:editor/menu/dialog/dialog_open_end_time
# 回收站（面板 17）：138 打开；1380..1389 还原（index=click-1380）；1390..1399 彻底删除（index=click-1390）
execute if score #click_value editor matches 138 run function rhythm_axe:editor/menu/trash/trash_panel_open
execute if score #click_value editor matches 1380..1389 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1380..1389 run scoreboard players remove #temp editor 1380
execute if score #click_value editor matches 1380..1389 run execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1380..1389 run function rhythm_axe:editor/menu/trash/trash_restore_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1380..1389 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 1390..1399 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1390..1399 run scoreboard players remove #temp editor 1390
execute if score #click_value editor matches 1390..1399 run execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1390..1399 run function rhythm_axe:editor/menu/trash/trash_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1390..1399 run data remove storage rhythm_axe:prop index
# 已选定音符列表（面板 18）：1560 返回（清空选择）+ 编辑 1400+ / 复制 1440+ / 粘贴 1480+ / 删除 1520+
# 【返回】1560：仅返回主菜单（不清空 selection，保留选中与高亮）
execute if score #click_value editor matches 1560 run function rhythm_axe:editor/menu/main
# 【清空选中并返回】1561：清空 selection 与高亮、清空选中标签，然后返回主菜单
execute if score #click_value editor matches 1561 run data modify storage rhythm_axe:maps.editor selection set value []
execute if score #click_value editor matches 1561 run scoreboard players set #sel_count editor 0
execute if score #click_value editor matches 1561 run execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute if score #click_value editor matches 1561 run execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
execute if score #click_value editor matches 1561 run function rhythm_axe:editor/menu/main
# 【批量编辑】1562：对当前 selection 批量编辑（进批量面板）
execute if score #click_value editor matches 1562 run function rhythm_axe:editor/menu/note/batch/batch_open
# 【批量复制】1563 / 【批量粘贴】1564（已选定列表）：复制 selection 字段 / 粘贴到播放头
execute if score #click_value editor matches 1563 run function rhythm_axe:editor/menu/note/selected/sel_batch_copy
execute if score #click_value editor matches 1564 run function rhythm_axe:editor/menu/note/selected/sel_batch_paste
execute if score #click_value editor matches 1400..1439 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1400..1439 run scoreboard players remove #temp editor 1400
execute if score #click_value editor matches 1400..1439 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1400..1439 run function rhythm_axe:editor/menu/note/selected/sel_note_panel_open_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1400..1439 run data remove storage rhythm_axe:prop sel_idx
execute if score #click_value editor matches 1440..1479 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1440..1479 run scoreboard players remove #temp editor 1440
execute if score #click_value editor matches 1440..1479 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1440..1479 run function rhythm_axe:editor/menu/note/selected/sel_note_copy_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1440..1479 run data remove storage rhythm_axe:prop sel_idx
execute if score #click_value editor matches 1480..1519 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1480..1519 run scoreboard players remove #temp editor 1480
execute if score #click_value editor matches 1480..1519 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1480..1519 run function rhythm_axe:editor/menu/note/selected/sel_note_paste_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1480..1519 run data remove storage rhythm_axe:prop sel_idx
execute if score #click_value editor matches 1520..1559 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1520..1559 run scoreboard players remove #temp editor 1520
execute if score #click_value editor matches 1520..1559 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1520..1559 run function rhythm_axe:editor/menu/note/selected/sel_note_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1520..1559 run data remove storage rhythm_axe:prop sel_idx
# 【复选框】1643+行序：取消选中该音符并重开已选定列表
execute if score #click_value editor matches 1643..1682 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1643..1682 run scoreboard players remove #temp editor 1643
execute if score #click_value editor matches 1643..1682 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1643..1682 run function rhythm_axe:editor/menu/note/selected/sel_note_toggle with storage rhythm_axe:prop
execute if score #click_value editor matches 1643..1682 run data remove storage rhythm_axe:prop sel_idx
# 覆盖还原确认：1370 覆盖并还原 / 1371 取消回回收站
execute if score #click_value editor matches 1370 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor trash_pending.mapid
execute if score #click_value editor matches 1370 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor trash_pending.index
execute if score #click_value editor matches 1370 run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
execute if score #click_value editor matches 1370 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 1370 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 1371 run function rhythm_axe:editor/menu/trash/trash_panel_open
# 彻底删除确认：1372 确认 / 1373 取消回回收站
execute if score #click_value editor matches 1372 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor trash_pending.mapid
execute if score #click_value editor matches 1372 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor trash_pending.index
execute if score #click_value editor matches 1372 run function rhythm_axe:editor/menu/trash/trash_delete_go with storage rhythm_axe:prop
execute if score #click_value editor matches 1372 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 1372 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 1373 run function rhythm_axe:editor/menu/trash/trash_panel_open

# 坐标/角度加减（先写 prop 参数再调用通用宏）
execute if score #click_value editor matches 107 run data modify storage rhythm_axe:prop field_name set value "spawn_x"
execute if score #click_value editor matches 108 run data modify storage rhythm_axe:prop field_name set value "spawn_x"
execute if score #click_value editor matches 109 run data modify storage rhythm_axe:prop field_name set value "spawn_y"
execute if score #click_value editor matches 110 run data modify storage rhythm_axe:prop field_name set value "spawn_y"
execute if score #click_value editor matches 111 run data modify storage rhythm_axe:prop field_name set value "spawn_z"
execute if score #click_value editor matches 112 run data modify storage rhythm_axe:prop field_name set value "spawn_z"
execute if score #click_value editor matches 120 run data modify storage rhythm_axe:prop field_name set value "spawn_yaw"
execute if score #click_value editor matches 121 run data modify storage rhythm_axe:prop field_name set value "spawn_yaw"
execute if score #click_value editor matches 122 run data modify storage rhythm_axe:prop field_name set value "spawn_pitch"
execute if score #click_value editor matches 123 run data modify storage rhythm_axe:prop field_name set value "spawn_pitch"
execute if score #click_value editor matches 107 run data modify storage rhythm_axe:prop delta set value -10
execute if score #click_value editor matches 108 run data modify storage rhythm_axe:prop delta set value 10
execute if score #click_value editor matches 109 run data modify storage rhythm_axe:prop delta set value -10
execute if score #click_value editor matches 110 run data modify storage rhythm_axe:prop delta set value 10
execute if score #click_value editor matches 111 run data modify storage rhythm_axe:prop delta set value -10
execute if score #click_value editor matches 112 run data modify storage rhythm_axe:prop delta set value 10
execute if score #click_value editor matches 120 run data modify storage rhythm_axe:prop delta set value -100
execute if score #click_value editor matches 121 run data modify storage rhythm_axe:prop delta set value 100
execute if score #click_value editor matches 122 run data modify storage rhythm_axe:prop delta set value -100
execute if score #click_value editor matches 123 run data modify storage rhythm_axe:prop delta set value 100
execute if score #click_value editor matches 107..112 run data modify storage rhythm_axe:prop min set value -1000000
execute if score #click_value editor matches 107..112 run data modify storage rhythm_axe:prop max set value 1000000
execute if score #click_value editor matches 120..121 run data modify storage rhythm_axe:prop min set value -18000
execute if score #click_value editor matches 120..121 run data modify storage rhythm_axe:prop max set value 18000
execute if score #click_value editor matches 122..123 run data modify storage rhythm_axe:prop min set value -9000
execute if score #click_value editor matches 122..123 run data modify storage rhythm_axe:prop max set value 9000
execute if score #click_value editor matches 107..112 run function rhythm_axe:editor/menu/map/ops/map_spawn_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 120..123 run function rhythm_axe:editor/menu/map/ops/map_spawn_adjust with storage rhythm_axe:prop

# 人数/血量加减
execute if score #click_value editor matches 113 run data modify storage rhythm_axe:prop field_name set value "player_count"
execute if score #click_value editor matches 114 run data modify storage rhythm_axe:prop field_name set value "player_count"
execute if score #click_value editor matches 115 run data modify storage rhythm_axe:prop field_name set value "health"
execute if score #click_value editor matches 116 run data modify storage rhythm_axe:prop field_name set value "health"
execute if score #click_value editor matches 113 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 114 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 115 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 116 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 113..116 run function rhythm_axe:editor/menu/map/ops/map_adjust with storage rhythm_axe:prop
# 谱面进度条颜色（面板2）：125 减 / 126 加（0-6 循环）
execute if score #click_value editor matches 125 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 126 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 125..126 run function rhythm_axe:editor/menu/map/ops/map_progress_color with storage rhythm_axe:prop

# 时间点列表与设置面板
execute if score #click_value editor matches 201..209 run function rhythm_axe:editor/menu/timing/panel/timing_panel_open_prep
execute if score #click_value editor matches 211..219 run function rhythm_axe:editor/menu/timing/list/timing_list_copy_prep
execute if score #click_value editor matches 221..229 run function rhythm_axe:editor/menu/timing/list/timing_list_paste_prep
execute if score #click_value editor matches 231..239 run function rhythm_axe:editor/menu/timing/list/timing_list_delete_prep
execute if score #click_value editor matches 280 run function rhythm_axe:editor/menu/timing/panel/timing_panel_new_open
execute if score #click_value editor matches 301 run data modify storage rhythm_axe:prop field_name set value "time"
execute if score #click_value editor matches 302 run data modify storage rhythm_axe:prop field_name set value "time"
execute if score #click_value editor matches 301 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 302 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 301..302 run data modify storage rhythm_axe:prop min set value 0
execute if score #click_value editor matches 301..302 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 303 run function rhythm_axe:editor/menu/timing/panel/timing_panel_use_now
execute if score #click_value editor matches 304 run function rhythm_axe:editor/menu/dialog/dialog_open_bpm
execute if score #click_value editor matches 305 run data modify storage rhythm_axe:prop field_name set value "bpb"
execute if score #click_value editor matches 306 run data modify storage rhythm_axe:prop field_name set value "bpb"
execute if score #click_value editor matches 307 run data modify storage rhythm_axe:prop field_name set value "tpb"
execute if score #click_value editor matches 308 run data modify storage rhythm_axe:prop field_name set value "tpb"
execute if score #click_value editor matches 311 run data modify storage rhythm_axe:prop field_name set value "judgement_scale"
execute if score #click_value editor matches 312 run data modify storage rhythm_axe:prop field_name set value "judgement_scale"
execute if score #click_value editor matches 305 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 306 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 307 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 308 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 311 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 312 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 305..306 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 307..308 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 311..312 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 305..308 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 311..312 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 313 run function rhythm_axe:editor/menu/timing/panel/timing_panel_prev
execute if score #click_value editor matches 314 run function rhythm_axe:editor/menu/timing/panel/timing_panel_next
execute if score #click_value editor matches 316 run function rhythm_axe:editor/menu/timing/panel/timing_panel_confirm
execute if score #click_value editor matches 317 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_arm
execute if score #click_value editor matches 318 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete
execute if score #click_value editor matches 319 run function rhythm_axe:editor/menu/timing/panel/timing_panel_new_confirm
execute if score #click_value editor matches 320 run function rhythm_axe:editor/menu/timing/panel/timing_panel_cancel
execute if score #click_value editor matches 321 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_disarm
execute if score #click_value editor matches 322 run function rhythm_axe:editor/menu/timing/panel/timing_panel_copy
execute if score #click_value editor matches 323 run function rhythm_axe:editor/menu/timing/panel/timing_panel_paste

# 主菜单撤销/重做（150/151）：仅主菜单可用（面板 1 隔离）；撤销/重做后返回主菜单
# 操作反馈的撤销/重做（8/9）在文件顶部保持原行为：撤销/重做后回 undo_panel 操作面板（此处不动 undo_panel，供反馈按钮继续跳转）
execute if score #click_value editor matches 150 run function rhythm_axe:editor/file/undo
execute if score #click_value editor matches 150 run data modify storage rhythm_axe:maps.editor current_panel set value 1
execute if score #click_value editor matches 150 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 151 run function rhythm_axe:editor/file/redo
execute if score #click_value editor matches 151 run data modify storage rhythm_axe:maps.editor current_panel set value 1
execute if score #click_value editor matches 151 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 10 run function rhythm_axe:editor/menu/find/find_open
execute if score #click_value editor matches 11 run function rhythm_axe:editor/menu/save_now
execute if score #click_value editor matches 12 run function rhythm_axe:editor/exit
execute if score #click_value editor matches 13 run function rhythm_axe:editor/menu/save_as/save_as

# 时间控件（20-29）已提前到面板隔离前分发（任意面板可用），此处不再分发

# 查找（30 时间点 / 31 事件点 / 32 音符）
execute if score #click_value editor matches 30 run function rhythm_axe:editor/menu/find/find_open_timing
execute if score #click_value editor matches 31 run function rhythm_axe:editor/menu/find/find_open_event
execute if score #click_value editor matches 32 run function rhythm_axe:editor/menu/find/find_open_note

# 另存为确认（40 保存后另存 / 41 直接另存 / 42 返回）
execute if score #click_value editor matches 40 run function rhythm_axe:editor/menu/save_as/save_as_save
execute if score #click_value editor matches 41 run function rhythm_axe:editor/menu/save_as/save_as_go
execute if score #click_value editor matches 42 run function rhythm_axe:editor/menu/main

# 事件列表与设置面板
execute if score #click_value editor matches 401..409 run function rhythm_axe:editor/menu/event/panel/event_panel_open_prep
execute if score #click_value editor matches 411..419 run function rhythm_axe:editor/menu/event/list/event_list_copy_prep
execute if score #click_value editor matches 421..429 run function rhythm_axe:editor/menu/event/list/event_list_paste_prep
execute if score #click_value editor matches 431..439 run function rhythm_axe:editor/menu/event/list/event_list_delete_prep
execute if score #click_value editor matches 480 run function rhythm_axe:editor/menu/event/panel/event_panel_new_open
execute if score #click_value editor matches 481 run function rhythm_axe:editor/menu/event/list/event_list_prev_page
execute if score #click_value editor matches 482 run function rhythm_axe:editor/menu/event/list/event_list_next_page
execute if score #click_value editor matches 500 run function rhythm_axe:editor/menu/event/panel/event_panel_time_dec
execute if score #click_value editor matches 501 run function rhythm_axe:editor/menu/event/panel/event_panel_time_inc
execute if score #click_value editor matches 502 run function rhythm_axe:editor/menu/event/panel/event_panel_add_cmd
execute if score #click_value editor matches 503 run function rhythm_axe:editor/menu/event/panel/event_panel_cancel
execute if score #click_value editor matches 504 run function rhythm_axe:editor/menu/event/panel/event_panel_confirm
execute if score #click_value editor matches 505 run function rhythm_axe:editor/menu/event/panel/event_panel_delete_arm
execute if score #click_value editor matches 506 run function rhythm_axe:editor/menu/event/panel/event_panel_new_confirm
execute if score #click_value editor matches 507 run function rhythm_axe:editor/menu/event/panel/event_panel_delete
execute if score #click_value editor matches 508 run function rhythm_axe:editor/menu/event/panel/event_panel_delete_disarm
execute if score #click_value editor matches 509 run function rhythm_axe:editor/menu/event/panel/event_panel_prev
execute if score #click_value editor matches 510 run function rhythm_axe:editor/menu/event/panel/event_panel_next
execute if score #click_value editor matches 590 run function rhythm_axe:editor/menu/event/panel/event_panel_time_now
execute if score #click_value editor matches 591 run function rhythm_axe:editor/menu/event/panel/event_panel_copy
execute if score #click_value editor matches 592 run function rhythm_axe:editor/menu/event/panel/event_panel_paste
execute if score #click_value editor matches 511..539 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_edit_prep
execute if score #click_value editor matches 560..589 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_delete_prep

# 退出确认面板
execute if score #click_value editor matches 901 run function rhythm_axe:editor/menu/exit/exit_save
execute if score #click_value editor matches 902 run function rhythm_axe:editor/exit_do
execute if score #click_value editor matches 903 run function rhythm_axe:editor/menu/main

# 切换谱面确认面板（面板 15）：911 保存并切换 / 912 丢弃并切换 / 913 直接切换（903 继续编辑=consume 开头 resume）
execute if score #click_value editor matches 911 run function rhythm_axe:editor/menu/switch/switch_save_go
execute if score #click_value editor matches 912 run function rhythm_axe:editor/menu/switch/switch_go
execute if score #click_value editor matches 913 run function rhythm_axe:editor/menu/switch/switch_go

# 音符列表与设置面板（列表按钮值按存活序：编辑 600+、复制 640+、粘贴 680+、删除 720+；面板 760-767）
execute if score #click_value editor matches 600..639 run function rhythm_axe:editor/menu/note/panel/note_panel_open_prep
execute if score #click_value editor matches 640..679 run function rhythm_axe:editor/menu/note/list/note_list_copy_prep
execute if score #click_value editor matches 680..719 run function rhythm_axe:editor/menu/note/list/note_list_paste_prep
execute if score #click_value editor matches 720..759 run function rhythm_axe:editor/menu/note/list/note_list_delete_prep
execute if score #click_value editor matches 1600..1639 run function rhythm_axe:editor/menu/note/list/note_list_toggle
# 取消选中（不退出列表）：清空 selection + 熄灭高亮，然后刷新列表
execute if score #click_value editor matches 1640 run data modify storage rhythm_axe:maps.editor selection set value []
execute if score #click_value editor matches 1640 run scoreboard players set #sel_count editor 0
execute if score #click_value editor matches 1640 run execute as @e[type=item_display,tag=editor_note] run data modify entity @s Glowing set value 0b
execute if score #click_value editor matches 1640 run execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
execute if score #click_value editor matches 1640 run function rhythm_axe:editor/menu/note/list/note_list_open
# 【批量复制】1641 / 【批量粘贴】1642（活跃列表）：复制 selection 字段 / 粘贴到播放头
execute if score #click_value editor matches 1641 run function rhythm_axe:editor/menu/note/list/note_list_batch_copy
execute if score #click_value editor matches 1642 run function rhythm_axe:editor/menu/note/list/note_list_batch_paste
execute if score #click_value editor matches 760..762 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 783..784 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 785..786 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 768..781 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 799..800 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 802..803 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
# 相对/绝对开关（787 时间 / 788 大小 / 789 位置 / 790 起始位置）
execute if score #click_value editor matches 787 run scoreboard players set #rel_field editor 1
execute if score #click_value editor matches 788 run scoreboard players set #rel_field editor 2
execute if score #click_value editor matches 789 run scoreboard players set #rel_field editor 3
execute if score #click_value editor matches 790 run scoreboard players set #rel_field editor 4
execute if score #click_value editor matches 787..790 run function rhythm_axe:editor/menu/note/panel/note_panel_rel_toggle
execute if score #click_value editor matches 805 run function rhythm_axe:editor/menu/note/dialog/dialog_open_note_tag
# 相对字段【x】重置：增量归 0（单音符相对模式也可用；仅相对模式行显示）。单/批量都刷新面板并拦截
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute if score #click_value editor matches 792 run data modify storage rhythm_axe:maps.editor editing.rel.delta.time set value 0
execute if score #click_value editor matches 793 run data modify storage rhythm_axe:maps.editor editing.rel.delta.size set value 0
execute if score #click_value editor matches 796 run data modify storage rhythm_axe:maps.editor editing.rel.delta.position set value [0,0,0]
execute if score #click_value editor matches 797 run data modify storage rhythm_axe:maps.editor editing.rel.delta.start_pos set value [0,0,0]
# 单音符绝对模式【x】重置：还原为打开时的值（editing.temp from editing.orig）
execute if score #click_value editor matches 792 if score #rel_on editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.time run data modify storage rhythm_axe:maps.editor editing.temp.time set from storage rhythm_axe:maps.editor editing.orig.time
execute if score #click_value editor matches 793 if score #rel_on editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.size run data modify storage rhythm_axe:maps.editor editing.temp.size set from storage rhythm_axe:maps.editor editing.orig.size
execute if score #click_value editor matches 796 if score #rel_pos editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.position run data modify storage rhythm_axe:maps.editor editing.temp.position set from storage rhythm_axe:maps.editor editing.orig.position
execute if score #click_value editor matches 797 if score #rel_sp editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.start_pos run data modify storage rhythm_axe:maps.editor editing.temp.start_pos set from storage rhythm_axe:maps.editor editing.orig.start_pos
execute if score #click_value editor matches 792..793 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 792..793 run return 0
execute if score #click_value editor matches 796..797 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 796..797 run return 0
# 批量确认/取消（editing.batch 时拦截 763/764；用 #batch_do 标志，因 batch_confirm 会移除 editing.batch，不能靠它再 return）
scoreboard players set #batch_do editor 0
execute if score #click_value editor matches 763 if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_do editor 1
execute if score #click_value editor matches 764 if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_do editor 1
execute if score #batch_do editor matches 1 if score #click_value editor matches 763 run function rhythm_axe:editor/menu/note/batch/batch_confirm
execute if score #batch_do editor matches 1 if score #click_value editor matches 764 run function rhythm_axe:editor/menu/note/batch/batch_cancel
execute if score #batch_do editor matches 1 run return fail
execute if score #click_value editor matches 794 run function rhythm_axe:editor/menu/note/panel/note_toggle_following_point
execute if score #click_value editor matches 795 run function rhythm_axe:editor/menu/note/panel/note_toggle_ignore_speed
# 【x】基础寿命重置：批量=清除 batch_set.base_life + temp 恢复默认 24；单音符=temp 恢复 orig.note_base_life
execute if score #click_value editor matches 890 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.base_life
execute if score #click_value editor matches 890 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set value 24
execute if score #click_value editor matches 890 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set from storage rhythm_axe:maps.editor editing.orig.note_base_life
execute if score #click_value editor matches 890 run data remove storage rhythm_axe:maps.editor editing.changed.base_life
execute if score #click_value editor matches 890 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】持续重置：批量=清除 batch_set.duration + temp 恢复默认 8；单音符=temp 恢复 orig.duration
execute if score #click_value editor matches 891 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.duration
execute if score #click_value editor matches 891 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.duration set value 8
execute if score #click_value editor matches 891 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.duration set from storage rhythm_axe:maps.editor editing.orig.duration
execute if score #click_value editor matches 891 run data remove storage rhythm_axe:maps.editor editing.changed.duration
execute if score #click_value editor matches 891 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】密度重置：批量=清除 batch_set.density + temp 恢复默认 8；单音符=temp 恢复 orig.density
execute if score #click_value editor matches 892 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.density
execute if score #click_value editor matches 892 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.density set value 8
execute if score #click_value editor matches 892 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.density set from storage rhythm_axe:maps.editor editing.orig.density
execute if score #click_value editor matches 892 run data remove storage rhythm_axe:maps.editor editing.changed.density
execute if score #click_value editor matches 892 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】类型重置：批量=清除 batch_set.type + temp 恢复默认 0（音符盒）；单音符=temp 恢复 orig.type
execute if score #click_value editor matches 893 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.type
execute if score #click_value editor matches 893 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.type set value 0
execute if score #click_value editor matches 893 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.type set from storage rhythm_axe:maps.editor editing.orig.type
execute if score #click_value editor matches 893 run data remove storage rhythm_axe:maps.editor editing.changed.type
execute if score #click_value editor matches 893 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】动画重置（899，缓动+强度一行一次重置）
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.anim_easing
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.anim_power
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set value 1
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set value 1
execute if score #click_value editor matches 899 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set from storage rhythm_axe:maps.editor editing.orig.anim_easing
execute if score #click_value editor matches 899 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set from storage rhythm_axe:maps.editor editing.orig.anim_power
execute if score #click_value editor matches 899 run data remove storage rhythm_axe:maps.editor editing.changed.anim_easing
execute if score #click_value editor matches 899 run data remove storage rhythm_axe:maps.editor editing.changed.anim_power
execute if score #click_value editor matches 899 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】击打音效重置（904）
execute if score #click_value editor matches 904 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hitsound
execute if score #click_value editor matches 904 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hitsound set value 0
execute if score #click_value editor matches 904 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hitsound set from storage rhythm_axe:maps.editor editing.orig.hitsound
execute if score #click_value editor matches 904 run data remove storage rhythm_axe:maps.editor editing.changed.hitsound
execute if score #click_value editor matches 904 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】击打视效重置（905）
execute if score #click_value editor matches 905 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hit_particles
execute if score #click_value editor matches 905 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_particles set value 0
execute if score #click_value editor matches 905 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_particles set from storage rhythm_axe:maps.editor editing.orig.hit_particles
execute if score #click_value editor matches 905 run data remove storage rhythm_axe:maps.editor editing.changed.hit_particles
execute if score #click_value editor matches 905 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】击打事件重置（906）
execute if score #click_value editor matches 906 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hit_events
execute if score #click_value editor matches 906 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set value []
execute if score #click_value editor matches 906 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set from storage rhythm_axe:maps.editor editing.orig.hit_events
execute if score #click_value editor matches 906 run data remove storage rhythm_axe:maps.editor editing.changed.hit_events
execute if score #click_value editor matches 906 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】标签重置（907）
execute if score #click_value editor matches 907 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.custom_tag
execute if score #click_value editor matches 907 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set value ""
execute if score #click_value editor matches 907 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set from storage rhythm_axe:maps.editor editing.orig.custom_tag
execute if score #click_value editor matches 907 run data remove storage rhythm_axe:maps.editor editing.changed.custom_tag
execute if score #click_value editor matches 907 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】颜色重置（908）
execute if score #click_value editor matches 908 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.color
execute if score #click_value editor matches 908 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.color set value 1b
execute if score #click_value editor matches 908 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.color set from storage rhythm_axe:maps.editor editing.orig.color
execute if score #click_value editor matches 908 run data remove storage rhythm_axe:maps.editor editing.changed.color
execute if score #click_value editor matches 908 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】引导线重置：清除 batch_set/changed.following_point，temp 恢复默认 0b（单音符恢复 orig.following_point）
execute if score #click_value editor matches 894 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.following_point
execute if score #click_value editor matches 894 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 0b
execute if score #click_value editor matches 894 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.following_point set from storage rhythm_axe:maps.editor editing.orig.following_point
execute if score #click_value editor matches 894 run data remove storage rhythm_axe:maps.editor editing.changed.following_point
execute if score #click_value editor matches 894 run function rhythm_axe:editor/menu/note/panel/note_panel
# 【x】无视流速重置：清除 batch_set/changed.ignore_note_speed，temp 恢复默认 0b（单音符恢复 orig.ignore_note_speed）
execute if score #click_value editor matches 895 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed
execute if score #click_value editor matches 895 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 0b
execute if score #click_value editor matches 895 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set from storage rhythm_axe:maps.editor editing.orig.ignore_note_speed
execute if score #click_value editor matches 895 run data remove storage rhythm_axe:maps.editor editing.changed.ignore_note_speed
execute if score #click_value editor matches 895 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 763 run function rhythm_axe:editor/menu/note/panel/note_panel_confirm
execute if score #click_value editor matches 764 run function rhythm_axe:editor/menu/note/panel/note_panel_cancel
execute if score #click_value editor matches 765 run function rhythm_axe:editor/menu/note/panel/note_panel_delete_arm
execute if score #click_value editor matches 766 run function rhythm_axe:editor/menu/note/panel/note_panel_delete
execute if score #click_value editor matches 767 run function rhythm_axe:editor/menu/note/panel/note_panel_delete_disarm

# 判定位置/起始位置单轴加减（prop 传 field_name/delta/min/max，宏调整；[--]/[++]粗调 ±100=1 格）
execute if score #click_value editor matches 860 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 861 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 862 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 863 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 864 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 865 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 868 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 869 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 870 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 871 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 872 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 873 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
# 粗调（[--]/[++]：±1 格 = ±100，由 field_name 同上）
execute if score #click_value editor matches 876 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 877 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 878 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 879 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 880 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 881 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 882 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 883 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 884 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 885 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 886 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 887 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 860..873 run scoreboard players set #pos_delta const 10
execute if score #click_value editor matches 860 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 862 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 864 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 868 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 870 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 872 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 876..887 run scoreboard players set #pos_delta const 100
execute if score #click_value editor matches 876 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 878 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 880 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 882 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 884 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 886 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 860..887 run execute store result storage rhythm_axe:prop delta int 1 run scoreboard players get #pos_delta const
# 相对增量目标组/轴（position/start_pos + 轴 0/1/2）
execute if score #click_value editor matches 860..865 run data modify storage rhythm_axe:prop rel_group set value "position"
execute if score #click_value editor matches 876..881 run data modify storage rhythm_axe:prop rel_group set value "position"
execute if score #click_value editor matches 868..873 run data modify storage rhythm_axe:prop rel_group set value "start_pos"
execute if score #click_value editor matches 882..887 run data modify storage rhythm_axe:prop rel_group set value "start_pos"
execute if score #click_value editor matches 860..861 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 876..877 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 868..869 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 882..883 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 862..863 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 878..879 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 870..871 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 884..885 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 864..865 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 880..881 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 872..873 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 886..887 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 860..887 run function rhythm_axe:editor/menu/note/pos/note_pos_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 866 run function rhythm_axe:editor/menu/note/pos/note_pos_use_player
execute if score #click_value editor matches 867 run function rhythm_axe:editor/menu/note/pos/note_pos_snap_center
execute if score #click_value editor matches 856 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_open

# 击打特效二级菜单（面板 14：857 添加 / 858 取消 / 859 确认 / 860+ 指令按钮）
execute if score #click_value editor matches 857 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_add
execute if score #click_value editor matches 858 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_cancel
execute if score #click_value editor matches 859 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_confirm
execute if score #click_value editor matches 10000..99999 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_click

# 全局音效/视效编辑（面板 12/13；进入时备份，刷新不覆盖备份）
execute if score #click_value editor matches 801 run data modify storage rhythm_axe:prop sound_backup set from storage rhythm_axe:feedback sounds
execute if score #click_value editor matches 801 run function rhythm_axe:editor/menu/note/global/global_sound_panel
execute if score #click_value editor matches 804 run data modify storage rhythm_axe:prop particle_backup set from storage rhythm_axe:feedback particles
execute if score #click_value editor matches 804 run function rhythm_axe:editor/menu/note/global/global_particle_panel
execute if score #click_value editor matches 806 run data modify storage rhythm_axe:prop sound_group set value 0
execute if score #click_value editor matches 807 run data modify storage rhythm_axe:prop sound_group set value 1
execute if score #click_value editor matches 808 run data modify storage rhythm_axe:prop sound_group set value 2
execute if score #click_value editor matches 809 run data modify storage rhythm_axe:prop sound_group set value 3
execute if score #click_value editor matches 810 run data modify storage rhythm_axe:prop sound_group set value 4
execute if score #click_value editor matches 811 run data modify storage rhythm_axe:prop sound_group set value 5
execute if score #click_value editor matches 812 run data modify storage rhythm_axe:prop sound_group set value 6
execute if score #click_value editor matches 806..812 run function rhythm_axe:editor/menu/note/global/global_sound_detail
execute if score #click_value editor matches 813 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 814 run function rhythm_axe:editor/menu/note/global/global_sound_reset
execute if score #click_value editor matches 815 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 816 run data modify storage rhythm_axe:prop sound_case set value "spawn"
execute if score #click_value editor matches 817 run data modify storage rhythm_axe:prop sound_case set value "tick"
execute if score #click_value editor matches 818 run data modify storage rhythm_axe:prop sound_case set value "bad"
execute if score #click_value editor matches 819 run data modify storage rhythm_axe:prop sound_case set value "good_early"
execute if score #click_value editor matches 820 run data modify storage rhythm_axe:prop sound_case set value "perfect_early"
execute if score #click_value editor matches 821 run data modify storage rhythm_axe:prop sound_case set value "perfect"
execute if score #click_value editor matches 822 run data modify storage rhythm_axe:prop sound_case set value "perfect_late"
execute if score #click_value editor matches 823 run data modify storage rhythm_axe:prop sound_case set value "good_late"
execute if score #click_value editor matches 824 run data modify storage rhythm_axe:prop sound_case set value "miss"
execute if score #click_value editor matches 825 run data modify storage rhythm_axe:prop sound_case set value "damage"
execute if score #click_value editor matches 816..825 run function rhythm_axe:editor/menu/note/dialog/dialog_open_global_sound_field
execute if score #click_value editor matches 830 run data modify storage rhythm_axe:prop particle_group set value 0
execute if score #click_value editor matches 831 run data modify storage rhythm_axe:prop particle_group set value 1
execute if score #click_value editor matches 832 run data modify storage rhythm_axe:prop particle_group set value 2
execute if score #click_value editor matches 833 run data modify storage rhythm_axe:prop particle_group set value 3
execute if score #click_value editor matches 834 run data modify storage rhythm_axe:prop particle_group set value 4
execute if score #click_value editor matches 835 run data modify storage rhythm_axe:prop particle_group set value 5
execute if score #click_value editor matches 836 run data modify storage rhythm_axe:prop particle_group set value 6
execute if score #click_value editor matches 830..836 run function rhythm_axe:editor/menu/note/global/global_particle_detail
execute if score #click_value editor matches 837 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 838 run function rhythm_axe:editor/menu/note/global/global_particle_panel
execute if score #click_value editor matches 840 run data modify storage rhythm_axe:prop particle_case set value "spawn"
execute if score #click_value editor matches 841 run data modify storage rhythm_axe:prop particle_case set value "tick"
execute if score #click_value editor matches 842 run data modify storage rhythm_axe:prop particle_case set value "bad"
execute if score #click_value editor matches 843 run data modify storage rhythm_axe:prop particle_case set value "good_early"
execute if score #click_value editor matches 844 run data modify storage rhythm_axe:prop particle_case set value "perfect_early"
execute if score #click_value editor matches 845 run data modify storage rhythm_axe:prop particle_case set value "perfect"
execute if score #click_value editor matches 846 run data modify storage rhythm_axe:prop particle_case set value "perfect_late"
execute if score #click_value editor matches 847 run data modify storage rhythm_axe:prop particle_case set value "good_late"
execute if score #click_value editor matches 848 run data modify storage rhythm_axe:prop particle_case set value "miss"
execute if score #click_value editor matches 849 run data modify storage rhythm_axe:prop particle_case set value "damage"
execute if score #click_value editor matches 840..849 run function rhythm_axe:editor/menu/note/dialog/dialog_open_global_particle_field
execute if score #click_value editor matches 850 run function rhythm_axe:editor/menu/note/global/global_particle_detail
execute if score #click_value editor matches 851 run function rhythm_axe:editor/menu/note/global/global_particle_panel
