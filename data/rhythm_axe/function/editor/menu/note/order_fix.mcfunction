# 【整理音符顺序】按钮处理（面板 2 行 108 列码 1 = trigger 10801）
# 把工作副本的 notes 按 time 升序重排（稳定：等刻保持原相对顺序），一次历史快照、可撤销
#
# ★ 为什么需要（2026-09-14 排查结论）：批量修改的「判定时间」是**原地改 time**（batch_apply_one），
#   只改选中子集、不重排数组 → 选中组一挪动就跨过未选中的邻居 → 局部逆序（回退量 = 增量）。
#   实测：一次「9 个染色玻璃 −6 刻」的批量编辑产生了 6 处逆序。
#   逆序会连累：insert_find（插入点错、逆序自我累积）、time_select 二分查找（范围选择边界错）、
#   sel_rebuild / 活跃列表（列表顺序倒挂）、出生游标 #vis_next / tick_birth_*（可能提前停、漏生音符）。
#   批量确认（batch_confirm_go）现在已自动调用 order_repair；本按钮供手动排查/修复历史遗留逆序。
#
# ★ refresh 会重建整表视觉与选区 → 面板渲染必须推迟到下一刻（同刻会挤爆命令链，见 load.mcfunction 的说明）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "整理音符顺序"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/util/order_repair
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data remove storage rhythm_axe:prop cursor
execute if score #ord_swaps editor matches 1.. run data modify storage rhythm_axe:maps.editor feedback set value "已整理音符顺序"
execute if score #ord_swaps editor matches 0 run data modify storage rhythm_axe:maps.editor feedback set value "音符顺序本来就正常"
tellraw @s [{"text":"[编辑器] 音符顺序检查：交换 ","color":"green"},{"score":{"name":"#ord_swaps","objective":"editor"},"color":"aqua"},{"text":" 处","color":"green"}]
schedule function rhythm_axe:editor/menu/map/panel/map_panel_next 1t
