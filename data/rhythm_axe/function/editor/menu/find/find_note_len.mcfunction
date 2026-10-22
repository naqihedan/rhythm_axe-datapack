#arg:cursor
# 读工作副本 notes 长度（供 find_note_start 定位窗口上界）；读取失败按 0 处理
# （与 time_select_len 同款：`data get ... notes` 会把整表序列化，只在需要全表窗口时调用一次）
scoreboard players set #fn_len editor 0
$execute store result score #fn_len editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
