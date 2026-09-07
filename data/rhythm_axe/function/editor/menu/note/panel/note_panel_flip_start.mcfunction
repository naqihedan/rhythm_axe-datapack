# 同时翻转起始位置核心（由 note_panel_flip_mirror 调用，无 begin/commit）：按 #mirror_x/y/z 对选中音符 start_pos 绕其判定位置镜像
#   仅当对应轴开关开启时对该轴 start_pos 取反（start_pos.axis = -start_pos.axis）；前置：#mirror_x/y/z、selection、prop.cursor
# ★ flip_cursor 顺序游标（selection 按 notes 顺序递增时 O(n)；乱序由 start_leaf 兜底从 0 全扫）
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/panel/note_panel_flip_start_drive
data remove storage rhythm_axe:prop flip_cursor

