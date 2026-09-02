# 撤销：cursor-1（不小于 0）
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
execute if score #temp_cursor editor matches 0 run tellraw @s [{"text":"[编辑器] 已经是最早的状态了，无法撤销","color":"yellow"}]
execute if score #temp_cursor editor matches 0 run return fail
data modify storage rhythm_axe:maps.editor feedback set value "已撤销"
# 撤销反馈带【重做】按钮（show_feedback 依光标位置判断：撤销后 cursor<末尾 → 可重做）
# 被撤销操作标签 = labels[cursor-1]（labels[i]=产生快照 i+1 的操作名）
execute store result storage rhythm_axe:prop cursor int 1 run scoreboard players get #temp_cursor editor
scoreboard players remove #temp_cursor editor 1
execute store result storage rhythm_axe:prop cursor int 1 run scoreboard players get #temp_cursor editor
# 无条件调标签函数：内部先读 history_labels[cursor]，读不到用 last_label 兜底
function rhythm_axe:editor/file/undo_label with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
execute store result storage rhythm_axe:maps.editor history_cursor int 1 run scoreboard players remove #history_cursor editor 1
function rhythm_axe:editor/refresh
