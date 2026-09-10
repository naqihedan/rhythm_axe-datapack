# 面板 13：全局音符击打视效（组选择 + case 详情两级子界面）。规范v2：值 = 行号×100 + 按钮号(01)，固定行号 100 起。
# 布局与面板12(音效)对称：组选择行100..106 = 10001..10601 选组0..6 → global_particle_detail；行107 10701 返回音符面板
# case 详情行108..117 = 10801..11701 对应 case(spawn,tick,bad,good_early,perfect_early,perfect,perfect_late,good_late,miss,damage) 的【编辑】→ dialog_open_global_particle_field
#             行118 11801 确定(保存回音符面板)；行119 11901 取消(返回组选择)
# global_particle_panel / global_particle_detail 设 current_panel=13。
# 入口白名单守卫
execute unless score #click_value editor matches 10000..11999 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..11999 run return fail

# —— 组选择屏：选组 0..6（10001..10601）进入详情 ——
execute if score #click_value editor matches 10001 run data modify storage rhythm_axe:prop particle_group set value 0
execute if score #click_value editor matches 10101 run data modify storage rhythm_axe:prop particle_group set value 1
execute if score #click_value editor matches 10201 run data modify storage rhythm_axe:prop particle_group set value 2
execute if score #click_value editor matches 10301 run data modify storage rhythm_axe:prop particle_group set value 3
execute if score #click_value editor matches 10401 run data modify storage rhythm_axe:prop particle_group set value 4
execute if score #click_value editor matches 10501 run data modify storage rhythm_axe:prop particle_group set value 5
execute if score #click_value editor matches 10601 run data modify storage rhythm_axe:prop particle_group set value 6
execute if score #click_value editor matches 10001..10601 run function rhythm_axe:editor/menu/note/global/global_particle_detail
# 801 返回音符面板
execute if score #click_value editor matches 10701 run function rhythm_axe:editor/menu/note/panel/note_panel

# —— case 详情屏：各 case【编辑】打开对应字段对话框 ——
execute if score #click_value editor matches 10801 run data modify storage rhythm_axe:prop particle_case set value "spawn"
execute if score #click_value editor matches 10901 run data modify storage rhythm_axe:prop particle_case set value "tick"
execute if score #click_value editor matches 11001 run data modify storage rhythm_axe:prop particle_case set value "bad"
execute if score #click_value editor matches 11101 run data modify storage rhythm_axe:prop particle_case set value "good_early"
execute if score #click_value editor matches 11201 run data modify storage rhythm_axe:prop particle_case set value "perfect_early"
execute if score #click_value editor matches 11301 run data modify storage rhythm_axe:prop particle_case set value "perfect"
execute if score #click_value editor matches 11401 run data modify storage rhythm_axe:prop particle_case set value "perfect_late"
execute if score #click_value editor matches 11501 run data modify storage rhythm_axe:prop particle_case set value "good_late"
execute if score #click_value editor matches 11601 run data modify storage rhythm_axe:prop particle_case set value "miss"
execute if score #click_value editor matches 11701 run data modify storage rhythm_axe:prop particle_case set value "damage"
execute if score #click_value editor matches 10801..11701 run function rhythm_axe:editor/menu/note/dialog/dialog_open_global_particle_field
# 1901 确定（保存当前组并返回音符面板）/ 2001 取消（返回组选择屏）
execute if score #click_value editor matches 11801 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 11901 run function rhythm_axe:editor/menu/note/global/global_particle_panel
