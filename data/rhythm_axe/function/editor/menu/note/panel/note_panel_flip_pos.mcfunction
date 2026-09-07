# 判定位置轴镜像核心（由 note_panel_flip_mirror 调用，无 begin/commit）：按 #flip_axis 对选中音符 position[axis] 绕包围盒中心镜像
#   new = min + max - old（= 2×center - old，center = (min+max)/2）；仅改 position，无需重排（数组按 time 升序不变）
# 前置：#flip_axis（0=X / 1=Y / 2=Z，由 flip_mirror 设置）、selection、prop.cursor（已指向工作副本）
# ★ 必须把 #flip_axis 写入 prop.flip_axis：宏叶子 scan_one/apply_one 用 $(flip_axis) 索引 position[axis]
execute store result storage rhythm_axe:prop flip_axis int 1 run scoreboard players get #flip_axis editor
scoreboard players set #flip_min editor 2147483647
# ★ #flip_max 初始必须为最小整数（不能 0）：否则判定位置该轴全为负时 max 停在 0，中心算错
scoreboard players set #flip_max editor -2147483648
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos_scan_drive
# 扫描已把 flip_cursor 推进到末尾，应用阶段要从头开始
scoreboard players set #flip_i editor 0
data modify storage rhythm_axe:prop flip_cursor set value 0
function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos_apply_drive
data remove storage rhythm_axe:prop flip_cursor
data remove storage rhythm_axe:prop flip_axis

