# 扫描工作副本 notes 所有音符 id 的最大值 → next_note_id = 最大 id + 1
# ★ 目的：打开已有谱面时，next_note_id 不能停留在 init_state 初始化的 0，
#   否则新放音符的 id 会与已有音符冲突（如打开有 id 1-5 的谱面后，新音符从 id 0 分配 → 撞 id 1/2）。
scoreboard players set #next_max editor -1
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop idx set value 0
function rhythm_axe:editor/util/scan_next_id_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop idx
# next_note_id = 最大 id + 1（无音符时 #next_max=-1 → 0）
scoreboard players add #next_max editor 1
execute store result storage rhythm_axe:maps.editor next_note_id int 1 run scoreboard players get #next_max editor
scoreboard players reset #next_max editor
scoreboard players reset #scan_note_total editor
scoreboard players reset #scan_idx editor
scoreboard players reset #scan_cur_id editor
