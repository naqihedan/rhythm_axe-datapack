# 面板 8：退出确认。规范v2：行100: 10001 保存并退出 / 10002 不保存退出。返回编辑器 903 由 consume 顶层处理。
execute unless score #click_value editor matches 10000..10099 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..10099 run return fail
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/exit/exit_save
execute if score #click_value editor matches 10002 run function rhythm_axe:editor/exit_do
