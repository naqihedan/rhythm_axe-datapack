# 面板 6：事件点设置（500..539、560..589、590..592）。event_panel_open / event_panel_new_open 设 current_panel=6。
# 入口白名单守卫
execute unless score #click_value editor matches 500..539 unless score #click_value editor matches 560..589 unless score #click_value editor matches 590..592 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 500..539 unless score #click_value editor matches 560..589 unless score #click_value editor matches 590..592 run return fail

execute if score #click_value editor matches 500 run function rhythm_axe:editor/menu/event/panel/event_panel_time_dec
execute if score #click_value editor matches 501 run function rhythm_axe:editor/menu/event/panel/event_panel_time_inc
execute if score #click_value editor matches 502 run function rhythm_axe:editor/menu/event/panel/event_panel_add_cmd
execute if score #click_value editor matches 503 run function rhythm_axe:editor/menu/event/panel/event_panel_cancel
execute if score #click_value editor matches 504 run function rhythm_axe:editor/menu/event/panel/event_panel_confirm
execute if score #click_value editor matches 505 run function rhythm_axe:editor/menu/event/panel/event_panel_delete_arm
execute if score #click_value editor matches 506 run function rhythm_axe:editor/menu/event/panel/event_panel_new_confirm
execute if score #click_value editor matches 507 run function rhythm_axe:editor/menu/event/panel/event_panel_delete
execute if score #click_value editor matches 508 run function rhythm_axe:editor/menu/event/panel/event_panel_delete_disarm
execute if score #click_value editor matches 509 run function rhythm_axe:editor/menu/event/panel/event_panel_prev
execute if score #click_value editor matches 510 run function rhythm_axe:editor/menu/event/panel/event_panel_next
execute if score #click_value editor matches 590 run function rhythm_axe:editor/menu/event/panel/event_panel_time_now
execute if score #click_value editor matches 591 run function rhythm_axe:editor/menu/event/panel/event_panel_copy
execute if score #click_value editor matches 592 run function rhythm_axe:editor/menu/event/panel/event_panel_paste
# 指令行编辑/删除（按存活序）
execute if score #click_value editor matches 511..539 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_edit_prep
execute if score #click_value editor matches 560..589 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_delete_prep
