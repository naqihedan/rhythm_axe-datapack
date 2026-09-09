# 面板 12：全局击打音效（806..827）。global_sound_panel / global_sound_detail 设 current_panel=12。入口值 801 由面板 11 进（备份 sound_backup）。
# 入口白名单守卫
execute unless score #click_value editor matches 806..827 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 806..827 run return fail

# 进入音效组选择面板（806..812 = 组 0..6）
execute if score #click_value editor matches 806 run data modify storage rhythm_axe:prop sound_group set value 0
execute if score #click_value editor matches 807 run data modify storage rhythm_axe:prop sound_group set value 1
execute if score #click_value editor matches 808 run data modify storage rhythm_axe:prop sound_group set value 2
execute if score #click_value editor matches 809 run data modify storage rhythm_axe:prop sound_group set value 3
execute if score #click_value editor matches 810 run data modify storage rhythm_axe:prop sound_group set value 4
execute if score #click_value editor matches 811 run data modify storage rhythm_axe:prop sound_group set value 5
execute if score #click_value editor matches 812 run data modify storage rhythm_axe:prop sound_group set value 6
execute if score #click_value editor matches 806..812 run function rhythm_axe:editor/menu/note/global/global_sound_detail
# 813/815 返回音符面板；814 重置全局音效
execute if score #click_value editor matches 813 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 814 run function rhythm_axe:editor/menu/note/global/global_sound_reset
execute if score #click_value editor matches 815 run function rhythm_axe:editor/menu/note/panel/note_panel
# 详情各 case 字段对话框（816..825）
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
# 详情确认/取消：826 保存当前组并返回音符面板；827 返回音效组选择面板
execute if score #click_value editor matches 826 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 827 run function rhythm_axe:editor/menu/note/global/global_sound_panel
