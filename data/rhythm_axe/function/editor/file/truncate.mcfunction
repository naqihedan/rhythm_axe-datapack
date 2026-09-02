# 删除末尾快照直到 history 长度 == cursor + 1（递归，深度 = 丢弃快照数）
data remove storage rhythm_axe:maps.editor history[-1]
data remove storage rhythm_axe:maps.editor history_labels[-1]
execute store result score #history_size editor run data get storage rhythm_axe:maps.editor history
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
scoreboard players operation #temp editor = #temp_cursor editor
scoreboard players add #temp editor 1
execute if score #history_size editor > #temp editor run function rhythm_axe:editor/file/truncate
