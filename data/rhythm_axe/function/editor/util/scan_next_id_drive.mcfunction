# 扫描驱动器（普通函数，非宏）：处理当前 idx，递增，未越界则继续
# 前置：prop.cursor、prop.idx；#next_max / #scan_note_total 由叶子维护
function rhythm_axe:editor/util/scan_next_id_leaf with storage rhythm_axe:prop
execute store result score #scan_idx editor run data get storage rhythm_axe:prop idx
scoreboard players add #scan_idx editor 1
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #scan_idx editor
execute if score #scan_idx editor < #scan_note_total editor run function rhythm_axe:editor/util/scan_next_id_drive
