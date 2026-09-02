# 提交操作：把被污染的工作副本（history[-1]）追加为新快照，恢复原快照，cursor+1；超上限裁剪最旧
# ★ 2026-08-28 撤销污染修复：操作直接改写了 history[-1]（= history[history_cursor]，末尾快照），
#   commit 先把它 append 为新快照（=操作后状态），再把 history[-2]（append 前原快照）恢复为
#   begin 备份的 pre_snapshot → 撤销回退到的快照干净、真正生效
# op_label（字符串操作名）→ history_labels 并行数组 + last_label 兜底键
data modify storage rhythm_axe:maps.editor history append from storage rhythm_axe:maps.editor history[-1]
data modify storage rhythm_axe:maps.editor history[-2] set from storage rhythm_axe:undo pre_snapshot
data remove storage rhythm_axe:undo pre_snapshot
execute if data storage rhythm_axe:maps.editor op_label run data modify storage rhythm_axe:maps.editor history_labels append from storage rhythm_axe:maps.editor op_label
execute if data storage rhythm_axe:maps.editor op_label run data modify storage rhythm_axe:maps.editor last_label set from storage rhythm_axe:maps.editor op_label
data remove storage rhythm_axe:maps.editor op_label
execute store result storage rhythm_axe:maps.editor history_cursor int 1 run scoreboard players add #history_cursor editor 1
execute store result score #history_size editor run data get storage rhythm_axe:maps.editor history
execute if score #history_size editor > #hist_limit editor run function rhythm_axe:editor/file/trim
# ★ 时间轴同步刷新：bump content_ver（所有数据修改经此收口），供 TimelineSync 变化检测强制重推
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
