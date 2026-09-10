# 面板 14：音符击打事件二级菜单（规范v2：10757 添加指令 / 10758 取消 / 10759 确认 / 行按钮 100000..999999）。note_hit_events_open 设 current_panel=14。
# 入口白名单守卫
execute unless score #click_value editor matches 10757..10759 unless score #click_value editor matches 100000..999999 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10757..10759 unless score #click_value editor matches 100000..999999 run return fail

execute if score #click_value editor matches 10757 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_add
execute if score #click_value editor matches 10758 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_cancel
execute if score #click_value editor matches 10759 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_confirm
# 指令行按钮（运行时生成编码）
execute if score #click_value editor matches 100000..999999 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_click
