# 判定位置轴镜像核心（由 note_panel_flip_mirror_go 调用，无 begin/commit）：按 #flip_axis 对选中音符 position[axis] 绕**锚点**镜像
#   new = 2×anchor − old（锚点 = #rc0/#rc1/#rc2，×100 定点，由调用方 anchor_get 读入）
# ★ 2026-09-17：中心从「选中包围盒中心」改为「锚点位置」——锚点不存在时 anchor_get 兜底算出的正是包围盒中心，
#   所以「没人动过锚点」时结果与旧实现完全等价；好处是中心可被用户显式挪动。本函数不再自己扫 min/max（省一趟遍历）。
# 前置：#flip_axis（0=X / 1=Y / 2=Z，由 flip_mirror 设置）、#rc0/1/2、selection、prop.cursor（已指向工作副本）
# ★ 必须把 #flip_axis 写入 prop.flip_axis：宏叶子 apply_one 用 $(flip_axis) 索引 position[axis]
execute store result storage rhythm_axe:prop flip_axis int 1 run scoreboard players get #flip_axis editor
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
scoreboard players set #flip_i editor 0
data modify storage rhythm_axe:prop flip_cursor set value 0
function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos_apply_drive
data remove storage rhythm_axe:prop flip_cursor
data remove storage rhythm_axe:prop flip_axis

