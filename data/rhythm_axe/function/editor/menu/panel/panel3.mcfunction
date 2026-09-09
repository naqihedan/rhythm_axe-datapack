# 面板 3：时间点列表（1 返回 / 3 刷新；201..239 各行 编辑/复制/粘贴/删除；280 新建）。timing_list_open 设 current_panel=3。
# 入口白名单守卫
execute unless score #click_value editor matches 1 unless score #click_value editor matches 3 unless score #click_value editor matches 201..299 unless score #click_value editor matches 280 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 3 unless score #click_value editor matches 201..299 unless score #click_value editor matches 280 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 3 run function rhythm_axe:editor/menu/timing/list/timing_list_open
# 各行操作（编辑/复制/粘贴/删除，进时间点设置面板 4 或就地）
execute if score #click_value editor matches 201..209 run function rhythm_axe:editor/menu/timing/panel/timing_panel_open_prep
execute if score #click_value editor matches 211..219 run function rhythm_axe:editor/menu/timing/list/timing_list_copy_prep
execute if score #click_value editor matches 221..229 run function rhythm_axe:editor/menu/timing/list/timing_list_paste_prep
execute if score #click_value editor matches 231..239 run function rhythm_axe:editor/menu/timing/list/timing_list_delete_prep
# 新建时间点
execute if score #click_value editor matches 280 run function rhythm_axe:editor/menu/timing/panel/timing_panel_new_open
