# 面板 2：谱面设置（101..134；含 spawn 坐标/角度加减、人数/血量、进度条颜色 等）。map_panel_open 设 current_panel=2。
# 入口白名单守卫
execute unless score #click_value editor matches 101..134 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 101..134 run return fail

# —— 打开各文本输入对话框 / 开关 ——
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
execute if score #click_value editor matches 124 run function rhythm_axe:editor/menu/dialog/dialog_open_end_time
execute if score #click_value editor matches 130 run function rhythm_axe:editor/menu/map/ops/map_tp_to_spawn

# —— 坐标/角度加减（先写 prop 参数再调用通用宏）——
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

# —— 人数/血量加减 ——
execute if score #click_value editor matches 113 run data modify storage rhythm_axe:prop field_name set value "player_count"
execute if score #click_value editor matches 114 run data modify storage rhythm_axe:prop field_name set value "player_count"
execute if score #click_value editor matches 115 run data modify storage rhythm_axe:prop field_name set value "health"
execute if score #click_value editor matches 116 run data modify storage rhythm_axe:prop field_name set value "health"
execute if score #click_value editor matches 113 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 114 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 115 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 116 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 113..116 run function rhythm_axe:editor/menu/map/ops/map_adjust with storage rhythm_axe:prop

# —— 谱面进度条颜色（125 减 / 126 加，0-6 循环）——
execute if score #click_value editor matches 125 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 126 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 125..126 run function rhythm_axe:editor/menu/map/ops/map_progress_color with storage rhythm_axe:prop
