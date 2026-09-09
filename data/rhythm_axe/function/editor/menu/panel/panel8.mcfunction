# 面板 8：退出确认（901 保存并退出 / 902 直接退出）。入口值 12（exit_confirm 设 current_panel=8）。
# 903=返回编辑由 consume 顶层统一处理（恢复 active + resume），此处不重复。
# 入口白名单守卫
execute unless score #click_value editor matches 901..903 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 901..903 run return fail

execute if score #click_value editor matches 901 run function rhythm_axe:editor/menu/exit/exit_save
execute if score #click_value editor matches 902 run function rhythm_axe:editor/exit_do
