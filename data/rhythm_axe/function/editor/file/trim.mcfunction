# 超出历史上限：丢弃最旧快照 history[0]，cursor-1；saved_cursor 同步 -1
# ★ saved_cursor 是 history 绝对下标，history 从头部删除会让所有下标 -1。
#   若不调整，保存后继续编辑触发裁剪时 |history_cursor-saved_cursor|（未保存编辑数）会逐渐失真/卡死。
data remove storage rhythm_axe:maps.editor history[0]
data remove storage rhythm_axe:maps.editor history_labels[0]
execute store result storage rhythm_axe:maps.editor history_cursor int 1 run scoreboard players remove #history_cursor editor 1
execute store result score #temp_saved editor run data get storage rhythm_axe:maps.editor saved_cursor
execute if score #temp_saved editor matches 1.. run scoreboard players remove #temp_saved editor 1
execute store result storage rhythm_axe:maps.editor saved_cursor int 1 run scoreboard players get #temp_saved editor
scoreboard players reset #temp_saved editor
