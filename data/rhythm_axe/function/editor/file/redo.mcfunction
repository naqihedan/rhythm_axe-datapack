# 重做：cursor+1（不大于 history 长度-1）
execute store result score #history_size editor run data get storage rhythm_axe:maps.editor history
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
scoreboard players add #temp_cursor editor 1
execute if score #temp_cursor editor >= #history_size editor run tellraw @s [{"text":"[编辑器] 已经是最新的状态了，无法重做","color":"yellow"}]
execute if score #temp_cursor editor >= #history_size editor run return fail
data modify storage rhythm_axe:maps.editor feedback set value "已重做"
# 被恢复操作标签 = labels[cursor]（新 cursor-1）
scoreboard players remove #temp_cursor editor 1
execute store result storage rhythm_axe:prop cursor int 1 run scoreboard players get #temp_cursor editor
# 无条件调标签函数：内部先读 history_labels[cursor]，读不到用 last_label 兜底
function rhythm_axe:editor/file/redo_label with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
execute store result storage rhythm_axe:maps.editor history_cursor int 1 run scoreboard players add #history_cursor editor 1
function rhythm_axe:editor/refresh
