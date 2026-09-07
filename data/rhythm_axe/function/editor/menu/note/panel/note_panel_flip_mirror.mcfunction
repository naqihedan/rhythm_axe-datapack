# 执行镜像翻转（按钮 917，底部第二行【翻转】按钮）：按 #mirror_x/y/z 开关对选中音符 position 绕包围盒中心镜像；#mirror_s 开时按 X/Y/Z 对 start_pos 绕判定位置镜像
# 四个开关仅在点击翻转前切换状态（910/914/915/916），本函数读取开关状态执行。
# 前置：selection；#from=current_panel；prop.cursor 指向工作副本
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "镜像翻转音符"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# 读开关状态（storage mirrors.editor mirror.* 缺省视为关=0）
execute store result score #mirror_x editor run data get storage rhythm_axe:maps.editor mirror.x
execute store result score #mirror_y editor run data get storage rhythm_axe:maps.editor mirror.y
execute store result score #mirror_z editor run data get storage rhythm_axe:maps.editor mirror.z
execute store result score #mirror_s editor run data get storage rhythm_axe:maps.editor mirror.s
# X/Y/Z 判定位置镜像（绕包围盒中心，new=min+max-old；各自独立算 min/max）
execute if score #mirror_x editor matches 1 run scoreboard players set #flip_axis editor 0
execute if score #mirror_x editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos
execute if score #mirror_y editor matches 1 run scoreboard players set #flip_axis editor 1
execute if score #mirror_y editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos
execute if score #mirror_z editor matches 1 run scoreboard players set #flip_axis editor 2
execute if score #mirror_z editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos
# S 同时翻转起始位置（按 X/Y/Z 开关，对应轴 start_pos 取反）
execute if score #mirror_s editor matches 1 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_start
# 收尾
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已执行镜像翻转"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
# 执行翻转后，把前四个开关重置为默认值（X/Y/Z 关、S 开）
data modify storage rhythm_axe:maps.editor mirror.x set value 0b
data modify storage rhythm_axe:maps.editor mirror.y set value 0b
data modify storage rhythm_axe:maps.editor mirror.z set value 0b
data modify storage rhythm_axe:maps.editor mirror.s set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel_return
