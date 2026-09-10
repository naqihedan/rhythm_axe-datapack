# 面板 7：查找。规范v2：值=行号×100+按钮号，固定行号 100 起。行100: 10001 时间点 / 10002 事件点 / 10003 音符。value 1 返回主菜单。
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10000..10099 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10000..10099 run return fail
execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/find/find_open_timing
execute if score #click_value editor matches 10002 run function rhythm_axe:editor/menu/find/find_open_event
execute if score #click_value editor matches 10003 run function rhythm_axe:editor/menu/find/find_open_note
