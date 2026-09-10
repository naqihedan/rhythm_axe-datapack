# 面板 2：谱面设置。规范v2：值 = 行号×100 + 行内按钮号（行号 100 起）。
# 文本字段行：标题10001/作者10101/音乐10201/预览10301/mapid10401/结束时间10501；传送行106: 10601 off 10602 on 10603 tp
# spawn 行107: 10701..10706 = X-/X+/Y-/Y+/Z-/Z+；角度行109: 10901..10904 = yaw-/yaw+/pitch-/pitch+
# 行110 人数 11001/11002；行111 血量 11101/11102；行112 进度条色 11201/11202
# 行113 用玩家 11301 位置 / 11302 角度；行114 保存11401 / 取消11402
# map_panel_open 设 current_panel=2。
# 入口白名单守卫（值域 10000..11499 覆盖本面板全部按钮）
execute unless score #click_value editor matches 10000..11499 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..11499 run return fail

# —— 文本输入（每字段一行，编辑按钮=行号+01）——
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/dialog/dialog_open_title
execute if score #click_value editor matches 10101 run function rhythm_axe:editor/menu/dialog/dialog_open_author
execute if score #click_value editor matches 10201 run function rhythm_axe:editor/menu/dialog/dialog_open_music
execute if score #click_value editor matches 10301 run function rhythm_axe:editor/menu/dialog/dialog_open_preview
execute if score #click_value editor matches 10401 run function rhythm_axe:editor/menu/dialog/dialog_open_mapid
execute if score #click_value editor matches 10501 run function rhythm_axe:editor/menu/dialog/dialog_open_end_time
# —— 传送行（701 不传送 / 702 设为传送 / 703 传送动作）——
execute if score #click_value editor matches 10601 run function rhythm_axe:editor/menu/map/ops/map_set_teleport {"value":"0b"}
execute if score #click_value editor matches 10602 run function rhythm_axe:editor/menu/map/ops/map_set_teleport {"value":"1b"}
execute if score #click_value editor matches 10603 run function rhythm_axe:editor/menu/map/ops/map_tp_to_spawn

# —— 初始位置 spawn X/Y/Z（行8：801..806）——
execute if score #click_value editor matches 10701 run data modify storage rhythm_axe:prop field_name set value "spawn_x"
execute if score #click_value editor matches 10702 run data modify storage rhythm_axe:prop field_name set value "spawn_x"
execute if score #click_value editor matches 10703 run data modify storage rhythm_axe:prop field_name set value "spawn_y"
execute if score #click_value editor matches 10704 run data modify storage rhythm_axe:prop field_name set value "spawn_y"
execute if score #click_value editor matches 10705 run data modify storage rhythm_axe:prop field_name set value "spawn_z"
execute if score #click_value editor matches 10706 run data modify storage rhythm_axe:prop field_name set value "spawn_z"
execute if score #click_value editor matches 10701 run data modify storage rhythm_axe:prop delta set value -10
execute if score #click_value editor matches 10702 run data modify storage rhythm_axe:prop delta set value 10
execute if score #click_value editor matches 10703 run data modify storage rhythm_axe:prop delta set value -10
execute if score #click_value editor matches 10704 run data modify storage rhythm_axe:prop delta set value 10
execute if score #click_value editor matches 10705 run data modify storage rhythm_axe:prop delta set value -10
execute if score #click_value editor matches 10706 run data modify storage rhythm_axe:prop delta set value 10
execute if score #click_value editor matches 10701..10706 run data modify storage rhythm_axe:prop min set value -1000000
execute if score #click_value editor matches 10701..10706 run data modify storage rhythm_axe:prop max set value 1000000
execute if score #click_value editor matches 10701..10706 run function rhythm_axe:editor/menu/map/ops/map_spawn_adjust with storage rhythm_axe:prop

# —— 初始角度（行10：1001..1004 yaw/pitch）——
execute if score #click_value editor matches 10901 run data modify storage rhythm_axe:prop field_name set value "spawn_yaw"
execute if score #click_value editor matches 10902 run data modify storage rhythm_axe:prop field_name set value "spawn_yaw"
execute if score #click_value editor matches 10903 run data modify storage rhythm_axe:prop field_name set value "spawn_pitch"
execute if score #click_value editor matches 10904 run data modify storage rhythm_axe:prop field_name set value "spawn_pitch"
execute if score #click_value editor matches 10901 run data modify storage rhythm_axe:prop delta set value -100
execute if score #click_value editor matches 10902 run data modify storage rhythm_axe:prop delta set value 100
execute if score #click_value editor matches 10903 run data modify storage rhythm_axe:prop delta set value -100
execute if score #click_value editor matches 10904 run data modify storage rhythm_axe:prop delta set value 100
execute if score #click_value editor matches 10901..10902 run data modify storage rhythm_axe:prop min set value -18000
execute if score #click_value editor matches 10901..10902 run data modify storage rhythm_axe:prop max set value 18000
execute if score #click_value editor matches 10903..10904 run data modify storage rhythm_axe:prop min set value -9000
execute if score #click_value editor matches 10903..10904 run data modify storage rhythm_axe:prop max set value 9000
execute if score #click_value editor matches 10901..10904 run function rhythm_axe:editor/menu/map/ops/map_spawn_adjust with storage rhythm_axe:prop

# —— 人数（行11：1101/1102）——
execute if score #click_value editor matches 11001 run data modify storage rhythm_axe:prop field_name set value "player_count"
execute if score #click_value editor matches 11002 run data modify storage rhythm_axe:prop field_name set value "player_count"
execute if score #click_value editor matches 11001 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 11002 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 11001..11002 run function rhythm_axe:editor/menu/map/ops/map_adjust with storage rhythm_axe:prop
# —— 血量（行12：1201/1202）——
execute if score #click_value editor matches 11101 run data modify storage rhythm_axe:prop field_name set value "health"
execute if score #click_value editor matches 11102 run data modify storage rhythm_axe:prop field_name set value "health"
execute if score #click_value editor matches 11101 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 11102 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 11101..11102 run function rhythm_axe:editor/menu/map/ops/map_adjust with storage rhythm_axe:prop

# —— 进度条颜色（行13：1301/1302，0-6 循环）——
execute if score #click_value editor matches 11201 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 11202 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 11201..11202 run function rhythm_axe:editor/menu/map/ops/map_progress_color with storage rhythm_axe:prop

# —— 用玩家（行14）：1401 位置 / 1402 角度 ——
execute if score #click_value editor matches 11301 run function rhythm_axe:editor/menu/map/ops/map_use_player_pos
execute if score #click_value editor matches 11302 run function rhythm_axe:editor/menu/map/ops/map_use_player_rotation

# —— 保存/取消（行15）：1501 保存 / 1502 取消 ——
execute if score #click_value editor matches 11401 run function rhythm_axe:editor/menu/map/panel/map_panel_save
execute if score #click_value editor matches 11402 run function rhythm_axe:editor/menu/map/panel/map_panel_cancel
