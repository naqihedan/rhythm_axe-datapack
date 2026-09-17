# 镜像翻转（按 X/Y/Z/S 开关绕锚点镜像） —— 真正干活的实现
# 由 note_panel_flip_mirror.mcfunction 分发进来：处理音符数 ≤ 50 → 本刻直调；> 50 → 由 note_panel_flip_mirror_next.mcfunction 跨刻调用。
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "镜像翻转音符"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# ★ 2026-09-17 锚点：镜像中心 = 锚点实体位置（锚点不存在时 anchor_get 兜底算出包围盒中心 = 改动前的行为）
function rhythm_axe:editor/menu/note/anchor/anchor_get
# 读开关状态（storage mirrors.editor mirror.* 缺省视为关=0）
execute store result score #mirror_x editor run data get storage rhythm_axe:maps.editor mirror.x
execute store result score #mirror_y editor run data get storage rhythm_axe:maps.editor mirror.y
execute store result score #mirror_z editor run data get storage rhythm_axe:maps.editor mirror.z
execute store result score #mirror_s editor run data get storage rhythm_axe:maps.editor mirror.s
# X/Y/Z 判定位置镜像（绕锚点 #rc0/1/2，new = 2×anchor − old；各轴共用同一个锚点）
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
# ★ 2026-09-12：回面板改为「下一刻渲染」——本文件前面已有 refresh（整表重建视觉）+ 逐音符遍历，
#   再同刻渲染列表会超命令链被截断（尾部丢的是视觉/选区重建）。语义不变，面板晚 1 tick 出现。
schedule function rhythm_axe:editor/menu/note/panel/note_panel_return_next 1t
