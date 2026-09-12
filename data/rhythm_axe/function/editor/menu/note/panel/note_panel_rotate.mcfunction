# 旋转（按钮 918=15° / 919=45° / 920=90°）：按 [X][Y][Z] 开关（作旋转轴）绕经过所选音符包围盒中心的轴旋转 position
#   S 开关开启时，对每个开启轴同时把 start_pos 绕判定位置旋转
#   右手定则（逆时针）；#rot_cos/#rot_sin 由 consume 按角度写入（×10000）
# 前置：selection；prop.rotate_cos / prop.rotate_sin；#from=current_panel
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "旋转音符"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result score #mirror_x editor run data get storage rhythm_axe:maps.editor mirror.x
execute store result score #mirror_y editor run data get storage rhythm_axe:maps.editor mirror.y
execute store result score #mirror_z editor run data get storage rhythm_axe:maps.editor mirror.z
execute store result score #mirror_s editor run data get storage rhythm_axe:maps.editor mirror.s
execute store result score #rot_cos editor run data get storage rhythm_axe:prop rotate_cos
execute store result score #rot_sin editor run data get storage rhythm_axe:prop rotate_sin
# 按开启轴依次旋转（每轴独立算包围盒中心）
execute if score #mirror_x editor matches 1 run scoreboard players set #flip_axis editor 0
execute if score #mirror_x editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_axis
execute if score #mirror_x editor matches 1 if score #mirror_s editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_start
execute if score #mirror_y editor matches 1 run scoreboard players set #flip_axis editor 1
execute if score #mirror_y editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_axis
execute if score #mirror_y editor matches 1 if score #mirror_s editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_start
execute if score #mirror_z editor matches 1 run scoreboard players set #flip_axis editor 2
execute if score #mirror_z editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_axis
execute if score #mirror_z editor matches 1 if score #mirror_s editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_start
# 收尾
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已旋转音符"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop rotate_cos
data remove storage rhythm_axe:prop rotate_sin
function rhythm_axe:editor/menu/note/panel/note_panel_return
