# 返回编辑器（903）：恢复编辑状态并按 current_panel 打开上次所在面板
# 面板状态（editing.temp / panel_temp / he_events）存于 storage，reload 不清除，直接显示保留
# ★ 重进存档后 editor_timeline_gui 可能被清 0（mod 时间轴开关随之关闭）→ 恢复编辑时强制置 1，确保时间轴重新显示
scoreboard players set editor_timeline_gui options 1
data modify storage rhythm_axe:maps.editor active set value 1b

execute store result score #panel_id editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #panel_id editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #panel_id editor matches 2 run function rhythm_axe:editor/menu/map/panel/map_panel
execute if score #panel_id editor matches 3 run function rhythm_axe:editor/menu/timing/list/timing_list_open
execute if score #panel_id editor matches 4 run function rhythm_axe:editor/menu/timing/panel/timing_panel
execute if score #panel_id editor matches 5 run function rhythm_axe:editor/menu/event/list/event_list_open
execute if score #panel_id editor matches 6 run function rhythm_axe:editor/menu/event/panel/event_panel
execute if score #panel_id editor matches 7 run function rhythm_axe:editor/menu/find/find_open
# 面板 8（退出确认）：返回编辑器时回主菜单（否则点【返回编辑器】会循环弹退出确认）
execute if score #panel_id editor matches 8 run function rhythm_axe:editor/menu/main
execute if score #panel_id editor matches 9 run function rhythm_axe:editor/menu/save_as/save_as_confirm_open
execute if score #panel_id editor matches 10 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #panel_id editor matches 11 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #panel_id editor matches 12 run function rhythm_axe:editor/menu/note/global/global_sound_panel
execute if score #panel_id editor matches 13 run function rhythm_axe:editor/menu/note/global/global_particle_panel
execute if score #panel_id editor matches 14 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel
# 面板 15（切换谱面确认，仅 editor 命令时临时弹出）：恢复时回主菜单
execute if score #panel_id editor matches 15 run function rhythm_axe:editor/menu/main
# 面板 16（删除确认，临时）：恢复时回主菜单
execute if score #panel_id editor matches 16 run function rhythm_axe:editor/menu/main
# 面板 17（回收站）：恢复回收站面板
execute if score #panel_id editor matches 17 run function rhythm_axe:editor/menu/trash/trash_panel_open
# 面板 18（已选定音符列表）：恢复已选定音符列表面板
execute if score #panel_id editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
# 兜底：current_panel 缺失或异常 → 主菜单
execute unless data storage rhythm_axe:maps.editor current_panel run function rhythm_axe:editor/menu/main
