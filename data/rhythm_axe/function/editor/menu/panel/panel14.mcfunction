# 面板 14：音符击打事件二级菜单（857 添加指令 / 858 取消 / 859 确认 / 10000..99999 指令行按钮）。note_hit_events_open 设 current_panel=14。
# 入口白名单守卫
execute unless score #click_value editor matches 857..859 unless score #click_value editor matches 10000..99999 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 857..859 unless score #click_value editor matches 10000..99999 run return fail

execute if score #click_value editor matches 857 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_add
execute if score #click_value editor matches 858 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_cancel
execute if score #click_value editor matches 859 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_confirm
# 指令行按钮（运行时生成编码）
execute if score #click_value editor matches 10000..99999 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_click
