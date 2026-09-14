#arg: cursor, idx
# 扫描"叶子"（宏）：读取当前音符 id，若大于 #next_max 则更新
# #scan_note_total = notes 长度（供驱动器判断越界）；#scan_cur_id = 当前音符 id
# ★ 2026-09-14 性能：整表长度只在**遍历起点（下标 0）**读一次。
#   原来每轮循环都 `data get ... notes`（取长度却把整个列表序列化成反馈文本，上千音符 ≈ 260KB/轮）。
#   （长度在一次遍历中不会变，读一次即可）
$scoreboard players set #len_i editor $(idx)
execute if score #len_i editor matches 0 run scoreboard players set #scan_note_total editor 0
$execute if score #len_i editor matches 0 run execute store result score #scan_note_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].id run execute store result score #scan_cur_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].id
execute if score #scan_cur_id editor > #next_max editor run scoreboard players operation #next_max editor = #scan_cur_id editor
