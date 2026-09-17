# 旋转核心（无 begin/commit）：按 #flip_axis 绕**经过锚点的轴**旋转 position
# ★ 2026-09-17：中心从「每轴各自重算的包围盒中心」改为「锚点位置」（#rc0/#rc1/#rc2，由调用方 anchor_get 读入）——
#   锚点不存在时 anchor_get 兜底算出包围盒中心，行为与旧实现等价；且多轴连续旋转现在统一绕**同一个点**
#   （旧实现每轴重扫一次，第一轴转完中心就漂了）。本函数不再自己扫描，只做「应用」。
# 前置：#flip_axis（0=X/1=Y/2=Z）、#rot_cos/#rot_sin（×10000）、#rc0/1/2、selection、prop.cursor
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
scoreboard players set #flip_i editor 0
data modify storage rhythm_axe:prop flip_cursor set value 0
function rhythm_axe:editor/menu/note/panel/note_panel_rotate_apply_drive
data remove storage rhythm_axe:prop flip_cursor
