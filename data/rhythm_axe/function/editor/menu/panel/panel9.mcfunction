# 面板 9：另存为确认（40 保存后另存 / 41 直接另存 / 42 返回）。入口值 13（save_as_confirm_open 设 current_panel=9）。
# 入口白名单守卫
execute unless score #click_value editor matches 40..42 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 40..42 run return fail

execute if score #click_value editor matches 40 run function rhythm_axe:editor/menu/save_as/save_as_save
execute if score #click_value editor matches 41 run function rhythm_axe:editor/menu/save_as/save_as_go
execute if score #click_value editor matches 42 run function rhythm_axe:editor/menu/main
