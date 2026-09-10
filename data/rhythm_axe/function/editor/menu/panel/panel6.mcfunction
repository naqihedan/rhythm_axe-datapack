# 面板 6：事件点设置。规范v2：值 = 行号×100 + 列码。
# 固定控件行（104xx）：10400 时间- / 10401 时间+ / 10402 添加指令 / 10403 取消 / 10404 确认 /
#   10405 删除(arm) / 10406 确认新增 / 10407 确认删除 / 10408 取消删除 / 10409 上一事件 / 10410 下一事件 /
#   10490 使用当前时间 / 10491 复制 / 10492 粘贴
# 指令行动态值（6 位）：(1000+指令序号)×100 + 列码（编辑3 / 删除7），序号 0 基无上限。
# event_panel_open / event_panel_new_open 设 current_panel=6。
# 入口白名单守卫：固定 104xx 或 动态 10xxxx（6 位）
execute unless score #click_value editor matches 10400..10499 unless score #click_value editor matches 100000..999999 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10400..10499 unless score #click_value editor matches 100000..999999 run return fail

execute if score #click_value editor matches 10400 run function rhythm_axe:editor/menu/event/panel/event_panel_time_dec
execute if score #click_value editor matches 10401 run function rhythm_axe:editor/menu/event/panel/event_panel_time_inc
execute if score #click_value editor matches 10402 run function rhythm_axe:editor/menu/event/panel/event_panel_add_cmd
execute if score #click_value editor matches 10403 run function rhythm_axe:editor/menu/event/panel/event_panel_cancel
execute if score #click_value editor matches 10404 run function rhythm_axe:editor/menu/event/panel/event_panel_confirm
execute if score #click_value editor matches 10405 run function rhythm_axe:editor/menu/event/panel/event_panel_delete_arm
execute if score #click_value editor matches 10406 run function rhythm_axe:editor/menu/event/panel/event_panel_new_confirm
execute if score #click_value editor matches 10407 run function rhythm_axe:editor/menu/event/panel/event_panel_delete
execute if score #click_value editor matches 10408 run function rhythm_axe:editor/menu/event/panel/event_panel_delete_disarm
execute if score #click_value editor matches 10409 run function rhythm_axe:editor/menu/event/panel/event_panel_prev
execute if score #click_value editor matches 10410 run function rhythm_axe:editor/menu/event/panel/event_panel_next
execute if score #click_value editor matches 10490 run function rhythm_axe:editor/menu/event/panel/event_panel_time_now
execute if score #click_value editor matches 10491 run function rhythm_axe:editor/menu/event/panel/event_panel_copy
execute if score #click_value editor matches 10492 run function rhythm_axe:editor/menu/event/panel/event_panel_paste
# 指令行（6 位动态值）：%100 取列码 → 3 编辑 / 7 删除
scoreboard players operation #tcol editor = #click_value editor
scoreboard players operation #tcol editor %= 100 const
execute if score #click_value editor matches 100000..999999 if score #tcol editor matches 3 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_edit_prep
execute if score #click_value editor matches 100000..999999 if score #tcol editor matches 7 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_delete_prep
