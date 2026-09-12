# 旋转核心（无 begin/commit）：按 #flip_axis 绕经过所选音符包围盒中心的轴旋转 position
# 前置：#flip_axis（0=X/1=Y/2=Z）、#rot_cos/#rot_sin（×10000）、selection、prop.cursor
scoreboard players set #rmin0 editor 2147483647
scoreboard players set #rmax0 editor -2147483648
scoreboard players set #rmin1 editor 2147483647
scoreboard players set #rmax1 editor -2147483648
scoreboard players set #rmin2 editor 2147483647
scoreboard players set #rmax2 editor -2147483648
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/panel/note_panel_rotate_scan_drive
# 中心 = (min+max)/2（×100 定点）
scoreboard players operation #rc0 editor = #rmin0 editor
scoreboard players operation #rc0 editor += #rmax0 editor
scoreboard players operation #rc0 editor /= 2 const
scoreboard players operation #rc1 editor = #rmin1 editor
scoreboard players operation #rc1 editor += #rmax1 editor
scoreboard players operation #rc1 editor /= 2 const
scoreboard players operation #rc2 editor = #rmin2 editor
scoreboard players operation #rc2 editor += #rmax2 editor
scoreboard players operation #rc2 editor /= 2 const
# 应用旋转（重置游标从头，扫描已把游标推到末尾）
scoreboard players set #flip_i editor 0
data modify storage rhythm_axe:prop flip_cursor set value 0
function rhythm_axe:editor/menu/note/panel/note_panel_rotate_apply_drive
data remove storage rhythm_axe:prop flip_cursor
