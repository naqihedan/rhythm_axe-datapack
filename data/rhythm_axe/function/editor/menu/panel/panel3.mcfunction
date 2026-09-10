# 面板 3：时间点列表。规范v2：固定值 = 行号×100 + 列码（行号 100 起）；行动态值 = (1000+行序)×100 + 列动作码(编辑3/复制5/粘贴6/删除7)，行序 0 基无上限。
# 固定：1 返回主菜单 / 10180 新建（原“3 刷新”为无按钮死分派，已移除）。timing_list_open 设 current_panel=3。
# 行按钮：先 %100 取列码 → 按列分发到 *_prep；行序反解在各 *_prep（click/100−1000）。
scoreboard players operation #tcol editor = #click_value editor
scoreboard players operation #tcol editor %= 100 const
# 入口白名单守卫（1 / 10180 / 或 列码∈{3,5,6,7}）
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10180 unless score #tcol editor matches 3 unless score #tcol editor matches 5 unless score #tcol editor matches 6 unless score #tcol editor matches 7 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10180 unless score #tcol editor matches 3 unless score #tcol editor matches 5 unless score #tcol editor matches 6 unless score #tcol editor matches 7 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 10180 run function rhythm_axe:editor/menu/timing/panel/timing_panel_new_open
# 行按钮按列码分发
execute if score #tcol editor matches 3 run function rhythm_axe:editor/menu/timing/panel/timing_panel_open_prep
execute if score #tcol editor matches 5 run function rhythm_axe:editor/menu/timing/list/timing_list_copy_prep
execute if score #tcol editor matches 6 run function rhythm_axe:editor/menu/timing/list/timing_list_paste_prep
execute if score #tcol editor matches 7 run function rhythm_axe:editor/menu/timing/list/timing_list_delete_prep
