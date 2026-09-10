# 面板 5：事件点列表。规范v2：固定值 = 行号×100 + 列码（行号 100 起）；行按钮 值 = (1000+页内行序)×100 + 列码(编辑3/复制5/粘贴6/删除7)；页码由 events_page 维护(不进值)。
# 固定：1 返回 / 10380 新建 / 10381 上页 / 10382 下页。event_list_open 设 current_panel=5。
# （原值 4“刷新”无按钮发出，是死分派，已移除）
scoreboard players operation #tcol editor = #click_value editor
scoreboard players operation #tcol editor %= 100 const
# 入口白名单守卫（1 / 10380..10382 或 列码∈{3,5,6,7}）
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10380..10382 unless score #tcol editor matches 3 unless score #tcol editor matches 5 unless score #tcol editor matches 6 unless score #tcol editor matches 7 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10380..10382 unless score #tcol editor matches 3 unless score #tcol editor matches 5 unless score #tcol editor matches 6 unless score #tcol editor matches 7 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 10380 run function rhythm_axe:editor/menu/event/panel/event_panel_new_open
execute if score #click_value editor matches 10381 run function rhythm_axe:editor/menu/event/list/event_list_prev_page
execute if score #click_value editor matches 10382 run function rhythm_axe:editor/menu/event/list/event_list_next_page
# 行按钮按列码分发
execute if score #tcol editor matches 3 run function rhythm_axe:editor/menu/event/panel/event_panel_open_prep
execute if score #tcol editor matches 5 run function rhythm_axe:editor/menu/event/list/event_list_copy_prep
execute if score #tcol editor matches 6 run function rhythm_axe:editor/menu/event/list/event_list_paste_prep
execute if score #tcol editor matches 7 run function rhythm_axe:editor/menu/event/list/event_list_delete_prep
