# 超出历史上限：丢弃最旧快照 history[0]，cursor-1
data remove storage rhythm_axe:maps.editor history[0]
data remove storage rhythm_axe:maps.editor history_labels[0]
execute store result storage rhythm_axe:maps.editor history_cursor int 1 run scoreboard players remove #history_cursor editor 1
