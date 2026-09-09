# 面板 13：全局击打视效（830..851）。global_particle_panel / global_particle_detail 设 current_panel=13。入口值 804 由面板 11 进（备份 particle_backup）。
# 入口白名单守卫
execute unless score #click_value editor matches 830..851 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 830..851 run return fail

# 进入视效组选择面板（830..836 = 组 0..6）
execute if score #click_value editor matches 830 run data modify storage rhythm_axe:prop particle_group set value 0
execute if score #click_value editor matches 831 run data modify storage rhythm_axe:prop particle_group set value 1
execute if score #click_value editor matches 832 run data modify storage rhythm_axe:prop particle_group set value 2
execute if score #click_value editor matches 833 run data modify storage rhythm_axe:prop particle_group set value 3
execute if score #click_value editor matches 834 run data modify storage rhythm_axe:prop particle_group set value 4
execute if score #click_value editor matches 835 run data modify storage rhythm_axe:prop particle_group set value 5
execute if score #click_value editor matches 836 run data modify storage rhythm_axe:prop particle_group set value 6
execute if score #click_value editor matches 830..836 run function rhythm_axe:editor/menu/note/global/global_particle_detail
# 837 返回音符面板；838 返回视效组选择面板
execute if score #click_value editor matches 837 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 838 run function rhythm_axe:editor/menu/note/global/global_particle_panel
# 详情各 case 字段对话框（840..849）
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
# 详情确认/取消：850 保存当前组返回；851 返回视效组选择面板
execute if score #click_value editor matches 850 run function rhythm_axe:editor/menu/note/global/global_particle_detail
execute if score #click_value editor matches 851 run function rhythm_axe:editor/menu/note/global/global_particle_panel
