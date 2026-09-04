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
function rhythm_axe:editor/menu/note/panel/note_panel_return
