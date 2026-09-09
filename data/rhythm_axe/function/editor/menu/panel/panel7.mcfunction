# 面板 7：查找（30 时间点 / 31 事件点 / 32 音符）。入口值 10（由主菜单跳入，find_open 设 current_panel=7）。
# 入口白名单守卫：值不属于本面板 → 公共兜底提示并返回。
execute unless score #click_value editor matches 1 unless score #click_value editor matches 30..32 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 30..32 run return fail

# 1 返回主菜单
execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
# 查找三类
execute if score #click_value editor matches 30 run function rhythm_axe:editor/menu/find/find_open_timing
execute if score #click_value editor matches 31 run function rhythm_axe:editor/menu/find/find_open_event
execute if score #click_value editor matches 32 run function rhythm_axe:editor/menu/find/find_open_note
