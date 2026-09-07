# 时间轴翻转（批量面板【时间轴翻转】按钮 909）：对选中音符把判定时间在 [min,max] 区间做镜像反转
#   new_time = min + max - old_time；只改 time，其余字段不变；翻转后按新 time 升序重排（一次历史快照可撤销）
# 前置：current_panel（=10 活跃列表 / 18 已选定列表）；处理对象 = selection（当前选中音符 id 列表）
# 流程：① file/begin ② 算选中音符 time 的 min/max ③ 逐个音符 find→改 time→remove→按新 time 重插 ④ commit+refresh+反馈
# ★ 2026-09-07 按钮移到活跃/已选定列表底部行，翻转对象改为 selection（不再用 editing.batch_ids）
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "时间轴翻转"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# ① 计算 min/max（#flip_min 大数起，#flip_max 0 起；time 恒 >=0）
scoreboard players set #flip_min editor 2147483647
scoreboard players set #flip_max editor 0
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/panel/note_panel_flip_scan_drive
# ② 逐个翻转 + 重排
scoreboard players set #flip_i editor 0
function rhythm_axe:editor/menu/note/panel/note_panel_flip_apply_drive
# ③ 收尾（commit 快照 + 刷新 + 反馈）
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已翻转时间轴"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop flip_cursor
function rhythm_axe:editor/menu/note/panel/note_panel_return
