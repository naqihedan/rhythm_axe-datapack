# 面板 9：另存为确认。规范v2：行100: 10001 保存后另存 / 10002 直接另存 / 10003 返回主菜单。
execute unless score #click_value editor matches 10000..10099 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..10099 run return fail
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/save_as/save_as_save
execute if score #click_value editor matches 10002 run function rhythm_axe:editor/menu/save_as/save_as_go
execute if score #click_value editor matches 10003 run function rhythm_axe:editor/menu/main
