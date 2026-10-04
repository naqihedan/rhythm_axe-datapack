# 分布真正干活：快照 → 逐音符算新 time/position → 移出/插回重排 → 提交 → 刷新视觉 → 下一刻回面板
# 前置：选中 ≥2、起点 < 终点（df_apply_dist 已校验）
execute store result storage rhythm_axe:maps.editor editing.panel_from int 1 run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
# 注：editing.df.k / k2 已由 df_apply_dist 里的 df_dist_count 算好（校验也用同一份），这里不再重复数
function rhythm_axe:editor/menu/note/df/df_dist_drive
# 重排：选中音符都改了 time ⇒ 先整体移出，再按新 time 二分插回（数组恢复 time 升序）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/util/move_out_drive
function rhythm_axe:editor/util/move_in_drive
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
# 操作反馈：文案按模式（时间/位置/两者）+ 数量（颗数）
#   由下一刻的 df_return_next 在面板渲染完后发出（否则会被 clear_lines 的 10 行空行冲掉）
data modify storage rhythm_axe:maps.editor feedback set value "已时间分布"
execute if data storage rhythm_axe:prop do_space run data modify storage rhythm_axe:maps.editor feedback set value "已位置分布"
execute if data storage rhythm_axe:prop do_time if data storage rhythm_axe:prop do_space run data modify storage rhythm_axe:maps.editor feedback set value "已时间+位置分布"
execute store result score #fb_count editor run data get storage rhythm_axe:maps.editor editing.df.k2
data modify storage rhythm_axe:prop fb_count set value 1b
data remove storage rhythm_axe:maps.editor editing.df.k
data remove storage rhythm_axe:maps.editor editing.df.k2
data remove storage rhythm_axe:prop do_time
data remove storage rhythm_axe:prop do_space
data remove storage rhythm_axe:prop strict
data remove storage rhythm_axe:prop group
data remove storage rhythm_axe:prop op_label
data remove storage rhythm_axe:prop mark
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop move_idx
data remove storage rhythm_axe:prop move_out
schedule function rhythm_axe:editor/menu/note/df/df_return_next 1t
