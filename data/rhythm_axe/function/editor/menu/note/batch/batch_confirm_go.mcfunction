# 批量修改音符确认（editing.rel.delta → batch_ids 每个音符） —— 真正干活的实现
# 由 batch_confirm.mcfunction 分发进来：处理音符数 ≤ 50 → 本刻直调；> 50 → 由 batch_confirm_next.mcfunction 跨刻调用。
# 批量修改确认：把 editing.rel.delta 增量应用到 batch_ids 每个音符（一次历史快照，可撤销）
scoreboard players operation #from editor = #batch_from editor
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "批量修改音符"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #bidx editor 0
scoreboard players set #btotal editor 0
execute store result score #btotal editor run data get storage rhythm_axe:maps.editor editing.batch_ids
# ★ 顺序游标初始化：find_by_id 从 0 开始找第一个
data modify storage rhythm_axe:prop batch_cursor set value 0
function rhythm_axe:editor/menu/note/batch/batch_apply_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop batch_cursor
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
# 反馈：走 show_feedback（顶部显示 + 撤销按钮），带编辑数量
data modify storage rhythm_axe:maps.editor feedback set value "已编辑"
execute store result score #fb_count editor run data get storage rhythm_axe:maps.editor editing.batch_ids
data modify storage rhythm_axe:prop fb_count set value 1b
data remove storage rhythm_axe:maps.editor editing
# ★ 2026-09-12：回面板改为「下一刻渲染」——本文件前面已有 refresh（整表重建视觉）+ 逐音符遍历，
#   再同刻渲染列表会超命令链被截断（尾部丢的是视觉/选区重建）。语义不变，面板晚 1 tick 出现。
schedule function rhythm_axe:editor/menu/note/panel/note_panel_return_next 1t
