# 已选定音符列表（面板 18）：显示被选区选中的音符（selection[]，按 notes 下标升序），每行复用 note_list_line（按钮值 100000 段）
# 打开即确认选择内容；【返回】(11401) 保留选择、【清空选中并返回】(11402) 清空 selection 与高亮
# ★ 2026-09-04 分页：每页 40，sel_page 存页号（缺省 0）；翻页 11601/11602 与活跃列表共用触发值
# ★ 2026-09-11 性能修复（选中约 34 个就撞 maxCommandChainLength=200000，列表显示不全）：
#   旧实现对 **全部** selection 项逐个 find_by_id(index=0) 全扫 notes → O(选中数×谱长)：46×363≈1.67 万步 × 约 13 条命令 就超限。
#   新实现：① 打开先 sel_rebuild 重建 selection（按 notes 下标升序，与 notes 顺序一致）；
#             ② 渲染只遍历“当前页”（页起点..页起点+39，≤40 项），不再遍历全部选中项；
#             ③ 行内 find_by_id 改顺序游标（从上次命中下标+1 继续，未命中才兜底从 0 全扫）→ 本页合计 O(n)。
#   收尾（翻页行 + 两行底部按钮 + 清理 prop）统一在 sel_note_list_footer。
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 18
tellraw @s [{"text":"=====已选定音符列表=====","color":"gold","bold":true}]
# 重建 selection（按 notes 顺序，天然升序）→ 渲染可用顺序游标；sel_rebuild 会清 prop.cursor，故之后重新取一次
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/note/selected/sel_rebuild
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# 页号缺省 0
execute unless data storage rhythm_axe:maps.editor sel_page run data modify storage rhythm_axe:maps.editor sel_page set value 0
# 当前页
execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
# 页起点 = 页号*40
scoreboard players operation #sel_page_start editor = #sel_page editor
scoreboard players set #sel_t40 editor 40
scoreboard players operation #sel_page_start editor *= #sel_t40 editor
# 选中总数（供分页/页数计算；selection 空则 0）
scoreboard players set #sel_total editor 0
execute if data storage rhythm_axe:maps.editor selection run execute store result score #sel_total editor run data get storage rhythm_axe:maps.editor selection
# 总页数 = ceil(选中数/40)
scoreboard players operation #sel_pages editor = #sel_total editor
scoreboard players add #sel_pages editor 39
scoreboard players set #sel_t40 editor 40
scoreboard players operation #sel_pages editor /= #sel_t40 editor
execute if score #sel_pages editor matches ..0 run scoreboard players set #sel_pages editor 1
# 页越界：钳制到最后一页（必须在渲染前完成，因为渲染只处理本页）
execute if score #sel_page editor >= #sel_pages editor run function rhythm_axe:editor/menu/note/selected/sel_note_page_clamp
execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players operation #sel_page_start editor = #sel_page editor
scoreboard players set #sel_t40 editor 40
scoreboard players operation #sel_page_start editor *= #sel_t40 editor
# 本页结束位 = 页起点 + 40（驱动器只遍历到此处）
scoreboard players operation #sel_end editor = #sel_page_start editor
scoreboard players add #sel_end editor 40
# 渲染本页：sel_i = 选中序（= selection 下标），sel_cursor = notes 顺序游标
# ★ 渲染只处理本页，故 #sel_i（= selection 下标）必须从「页起点」开始
scoreboard players operation #sel_i editor = #sel_page_start editor
scoreboard players set #sel_cursor editor 0
execute store result storage rhythm_axe:prop sel_i int 1 run scoreboard players get #sel_i editor
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
# 收尾：翻页行 + 底部按钮 + 清理 prop
function rhythm_axe:editor/menu/note/selected/sel_note_list_footer
