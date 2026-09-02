#arg:note_type
# 音符工具放置（@s = 玩家）：位置 = 游标方块中心，time = 播放头，属性继承同类最近音符
# ① 位置 = 游标方块中心（与 cursor_tick 同款定位：eyes + ^^^4 + align + ~0.5）
#    临时 marker 读当前执行位置（方块中心）后即删，不依赖旧 tool_cursor_x/y/z 存储
execute anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run summon marker ~ ~ ~ {Tags:["editor_tool_place_pos"]}
# ★ 26.x store result storage 会截断小数（0.5→0），必须 data modify set from 保留完整 double
#   否则 marker 虽在方块中心（x.5），读进 prop 却变成整数（x.0）
data modify storage rhythm_axe:prop position_x set from entity @e[tag=editor_tool_place_pos,limit=1] Pos[0]
data modify storage rhythm_axe:prop position_y set from entity @e[tag=editor_tool_place_pos,limit=1] Pos[1]
data modify storage rhythm_axe:prop position_z set from entity @e[tag=editor_tool_place_pos,limit=1] Pos[2]
kill @e[tag=editor_tool_place_pos]
# ② time = 播放头
execute store result storage rhythm_axe:prop time int 1 run scoreboard players get #playhead editor
# ③ type = 当前工具类型
$data modify storage rhythm_axe:prop type set value $(note_type)
# ★ 混凝土：判定位置 Y 抬升 0.1（方块中心 y + 0.1；×100 读 → +10 → 写回 double 0.01）
#   必须在此处（type 赋值后）判断 {type:3}，否则 type 未设置判断失效
execute if data storage rhythm_axe:prop {type:3} run execute store result score #place_off editor run data get storage rhythm_axe:prop position_y 100
execute if data storage rhythm_axe:prop {type:3} run scoreboard players add #place_off editor 10
execute if data storage rhythm_axe:prop {type:3} run execute store result storage rhythm_axe:prop position_y double 0.01 run scoreboard players get #place_off editor
# ④ 继承同类"往前最近"音符属性（同类中 time <= 当前且 time 最大，含同拍；除 time/id/hit_events/position/custom_tag 外全部）
#    找不到（如第一个音符）→ start_pos 走 create 默认 [0,0,24]，其余属性走默认值
scoreboard players set #inh_found editor 0
function rhythm_axe:editor/tool/note/inherit
# ⑤ 创建（含历史快照、视觉刷新、反馈）
function rhythm_axe:editor/note/create/create
# ★ 工具创建接 feedback 机制：打开面板时显示"已创建音符"+【撤销】按钮
data modify storage rhythm_axe:maps.editor feedback set value "已创建音符"
# ⑥ 打开新音符的属性控制面板（返回：从已选定列表来回已选定列表，否则回活跃音符列表）
# 新音符 id = next_note_id - 1（create 已自增）
execute store result score #tmp_nid editor run data get storage rhythm_axe:maps.editor next_note_id
scoreboard players remove #tmp_nid editor 1
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop note_id int 1 run scoreboard players get #tmp_nid editor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/panel/note_panel_open_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
