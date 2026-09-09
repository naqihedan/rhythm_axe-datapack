# 面板 5：事件点列表（1 返回 / 4 刷新；401..439 各行 编辑/复制/粘贴/删除；480 新建；481/482 翻页）。event_list_open 设 current_panel=5。
# 入口白名单守卫
execute unless score #click_value editor matches 1 unless score #click_value editor matches 4 unless score #click_value editor matches 401..449 unless score #click_value editor matches 480..482 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 4 unless score #click_value editor matches 401..449 unless score #click_value editor matches 480..482 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 4 run function rhythm_axe:editor/menu/event/list/event_list_open
# 各行操作（编辑/复制/粘贴/删除，进事件点设置面板 6 或就地）
execute if score #click_value editor matches 401..409 run function rhythm_axe:editor/menu/event/panel/event_panel_open_prep
execute if score #click_value editor matches 411..419 run function rhythm_axe:editor/menu/event/list/event_list_copy_prep
execute if score #click_value editor matches 421..429 run function rhythm_axe:editor/menu/event/list/event_list_paste_prep
execute if score #click_value editor matches 431..439 run function rhythm_axe:editor/menu/event/list/event_list_delete_prep
# 新建事件点
execute if score #click_value editor matches 480 run function rhythm_axe:editor/menu/event/panel/event_panel_new_open
# 翻页
execute if score #click_value editor matches 481 run function rhythm_axe:editor/menu/event/list/event_list_prev_page
execute if score #click_value editor matches 482 run function rhythm_axe:editor/menu/event/list/event_list_next_page
