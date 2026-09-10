# 面板 15：切换谱面确认。规范v2：行100: 10001 保存并切换 / 10002 丢弃并切换 / 10003 直接切换。返回继续编辑 903 顶层处理。
execute unless score #click_value editor matches 10000..10099 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..10099 run return fail
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/switch/switch_save_go
execute if score #click_value editor matches 10002 run function rhythm_axe:editor/menu/switch/switch_go
execute if score #click_value editor matches 10003 run function rhythm_axe:editor/menu/switch/switch_go
