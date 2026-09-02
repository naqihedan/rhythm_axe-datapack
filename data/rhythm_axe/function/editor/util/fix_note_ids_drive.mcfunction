# 重排 id 驱动器（普通函数，非宏）：处理当前 idx，递增，未越界则继续
# 前置：prop.cursor、prop.idx；#fix_total 由叶子维护
function rhythm_axe:editor/util/fix_note_ids_leaf with storage rhythm_axe:prop
execute store result score #fix_idx editor run data get storage rhythm_axe:prop idx
scoreboard players add #fix_idx editor 1
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #fix_idx editor
execute if score #fix_idx editor < #fix_total editor run function rhythm_axe:editor/util/fix_note_ids_drive
