#arg:note_type
# 音符工具放置（@s = 玩家）：位置 = 游标 + 网格吸附，time = 播放头，属性继承同类最近音符
# ① 位置 = 游标原始点（★ 2026-10-29 去掉了 align xyz / positioned ~0.5 ~0.5 ~0.5：
#    那两个会把点强制吸到方块中心，0.25/0.5 档需要的子格信息就丢了）
#    临时 marker 读当前执行位置后即删，不依赖旧 tool_cursor_x/y/z 存储
execute anchored eyes positioned ^ ^ ^4 run summon marker ~ ~ ~ {Tags:["editor_tool_place_pos"]}
# ★ 26.x store result storage 会截断小数（0.5→0），必须 data modify set from 保留完整 double
#   否则 marker 虽在正确位置，读进 prop 却变成整数
data modify storage rhythm_axe:prop position_x set from entity @e[tag=editor_tool_place_pos,limit=1] Pos[0]
data modify storage rhythm_axe:prop position_y set from entity @e[tag=editor_tool_place_pos,limit=1] Pos[1]
data modify storage rhythm_axe:prop position_z set from entity @e[tag=editor_tool_place_pos,limit=1] Pos[2]
kill @e[tag=editor_tool_place_pos]
# ①.2 网格吸附（面板 23「网格尺寸」note_grid）：每轴吸附到 0.5 + k×size 的格点
#   档3（1 格）时格点 = 0.5/1.5/2.5…，与旧「align + ~0.5」结果完全一致 ⇒ 默认档零行为变化
#   ★ 读用 ×1000（data get 是 floor，负数的 1/1000 偏差会被「半格取整」吸收）
function rhythm_axe:editor/tool/note/grid_setup
execute store result score #gs_v editor run data get storage rhythm_axe:prop position_x 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
execute store result storage rhythm_axe:prop position_x double 0.001 run scoreboard players get #gs_v editor
execute store result score #gs_v editor run data get storage rhythm_axe:prop position_y 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
execute store result storage rhythm_axe:prop position_y double 0.001 run scoreboard players get #gs_v editor
execute store result score #gs_v editor run data get storage rhythm_axe:prop position_z 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
execute store result storage rhythm_axe:prop position_z double 0.001 run scoreboard players get #gs_v editor
# ①.5 应用坐标锁定（工具选项栏面板 23）：被锁定的轴改成设定值
#   ★ 顺序 = 先吸附、后锁定：锁定是人显式给的值，优先级高于自动吸附
#   ★ 故意放在「混凝土 Y+0.1」之前 —— 这样锁 Y 时**仍然 +0.1**（用户 2026-10-06 定）
#   值存 ×100（0.05 精度，2026-10-29 起），×0.01 写回 double ⇒ 精确
execute if score note_lock_x tool_opt matches 1 run execute store result storage rhythm_axe:prop position_x double 0.01 run scoreboard players get note_lock_x_val tool_opt
execute if score note_lock_y tool_opt matches 1 run execute store result storage rhythm_axe:prop position_y double 0.01 run scoreboard players get note_lock_y_val tool_opt
execute if score note_lock_z tool_opt matches 1 run execute store result storage rhythm_axe:prop position_z double 0.01 run scoreboard players get note_lock_z_val tool_opt
# ② time = 播放头
execute store result storage rhythm_axe:prop time int 1 run scoreboard players get #playhead editor
# ③ type = 当前工具类型
$data modify storage rhythm_axe:prop type set value $(note_type)
# ★ 混凝土：判定位置 Y 抬升 0.1（方块中心 y + 0.1；×100 读 → +10 → 写回 double 0.01）
#   必须在此处（type 赋值后）判断 {type:3}，否则 type 未设置判断失效
execute if data storage rhythm_axe:prop {type:3} run execute store result score #place_off editor run data get storage rhythm_axe:prop position_y 100
execute if data storage rhythm_axe:prop {type:3} run scoreboard players add #place_off editor 10
execute if data storage rhythm_axe:prop {type:3} run execute store result storage rhythm_axe:prop position_y double 0.01 run scoreboard players get #place_off editor
# ④ 继承同类"往前最近"音符属性（同类中 time <= 当前且 time 最大，含同拍；除 time/id/hit_events/position 外全部）
#    找不到（如第一个音符）→ start_pos 走 create 默认 [0,0,24]，其余属性走默认值
scoreboard players set #inh_found editor 0
function rhythm_axe:editor/tool/note/inherit
# ⑤ 创建（含历史快照、视觉刷新、反馈）
function rhythm_axe:editor/note/create/create
# ★ 工具创建接 feedback 机制：打开面板时显示"已创建音符"（若坐标被锁定则注明锁了哪几轴）+【撤销】按钮
function rhythm_axe:editor/tool/note/place_feedback
# ⑥ 打开新音符的属性控制面板（返回：从已选定列表来回已选定列表，否则回活跃音符列表）
# ★ 2026-09-14 性能：新音符的数组下标由 create 直接给出（insert_find 的插入点 / 追加时的旧长度），
#   不再用 find_by_id 按 id 全表扫描（973 音符时单次 100ms 级）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute if data storage rhythm_axe:prop new_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop new_index
execute unless data storage rhythm_axe:prop new_index run tellraw @s [{"text":"[编辑器] 内部错误：缺少 new_index，无法定位刚创建的音符","color":"red"}]
execute if data storage rhythm_axe:prop new_index run function rhythm_axe:editor/menu/note/panel/note_panel_open_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop new_index