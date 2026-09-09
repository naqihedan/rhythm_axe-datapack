# 面板 15：切换谱面确认（911 保存并切换 / 912 丢弃并切换 / 913 直接切换）。switch_confirm 设 current_panel=15。
# 903=返回编辑由 consume 顶层统一处理，此处不重复。
# 入口白名单守卫
execute unless score #click_value editor matches 911..913 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 911..913 run return fail

execute if score #click_value editor matches 911 run function rhythm_axe:editor/menu/switch/switch_save_go
execute if score #click_value editor matches 912 run function rhythm_axe:editor/menu/switch/switch_go
execute if score #click_value editor matches 913 run function rhythm_axe:editor/menu/switch/switch_go
