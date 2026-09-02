# 生成音符的一对实体（宏上下文 = 当前音符 rhythm_axe:runtime.cur_note，已含 mapid 与拆好的标量坐标）
# 展示实体在判定位置，transformation.translation = 起始位置（移动动画里程碑2接入）
#arg: id, mapid, pos_x, pos_y, pos_z, start_x, start_y, start_z, size, type

# 展示实体（物品展示）
# transformation 需 left_rotation 与 right_rotation 成对（wiki 示例）
# brightness 全 15：音符不受环境光照影响，始终满亮度显示
# 展示实体：先 summon 到原点 (0,0,0)，再用 data modify 从 cur_note 精确写 Pos
# ★ 修复 spawn 错位：宏展开 $(pos_x) 会把 double 1.0 展开成整数 "1"，summon 命令对整数坐标自动对齐方块中心（1→1.5、0→0.5）；
#   transformation.translation 是 NBT 数据不经 summon 坐标解析，start_x/z 用宏无碍
$summon item_display 0.0 0.0 0.0 {item:{id:"minecraft:note_block",count:1},Tags:["note","note_display","$(mapid)_n$(id)","map_$(mapid)"],brightness:{block:15,sky:15},transformation:{translation:[$(start_x),$(start_y),$(start_z)],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
$data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] Pos[0] set from storage rhythm_axe:runtime cur_note.pos_x
$data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] Pos[1] set from storage rhythm_axe:runtime cur_note.pos_y
$data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] Pos[2] set from storage rhythm_axe:runtime cur_note.pos_z
# 按类型设置展示物品与类型 tag（混凝土/玻璃颜色映射里程碑2）
# 类型读取到计分板再匹配（execute if data storage 不支持 NBT 匹配）
# 类型 tag 同时加到展示实体与交互实体（判定在交互实体上跑，用 tag=note_{type} 筛选）
# 注意：交互实体的类型 tag 在 summon interaction 之后补加（见下方注释）
execute store result score #note_type play_state run data get storage rhythm_axe:runtime cur_note.type
$execute if score #note_type play_state matches 0 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:note_block"
$execute if score #note_type play_state matches 0 run tag @e[tag=$(mapid)_n$(id),type=item_display,limit=1] add note_noteblock
$execute if score #note_type play_state matches 1 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:birch_planks"
$execute if score #note_type play_state matches 1 run tag @e[tag=$(mapid)_n$(id),type=item_display,limit=1] add note_plank
$execute if score #note_type play_state matches 2 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:jukebox"
$execute if score #note_type play_state matches 2 run tag @e[tag=$(mapid)_n$(id),type=item_display,limit=1] add note_jukebox
$execute if score #note_type play_state matches 3 run tag @e[tag=$(mapid)_n$(id),type=item_display,limit=1] add note_concrete
# 染色玻璃：按 color（1~16）设置对应颜色的染色玻璃物品（文档颜色表；默认6=红色）
execute store result score #glass_color play_state run data get storage rhythm_axe:runtime cur_note.color
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 1 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:white_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 2 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:gray_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:light_gray_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 4 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:black_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 5 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:brown_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 6 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:red_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 7 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:orange_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 8 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:yellow_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 9 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:lime_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 10 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:green_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 11 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:cyan_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 12 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:light_blue_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 13 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:blue_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 14 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:purple_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 15 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:magenta_stained_glass"
$execute if score #note_type play_state matches 4 if score #glass_color play_state matches 16 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:pink_stained_glass"
$execute if score #note_type play_state matches 4 unless score #glass_color play_state matches 1..16 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:red_stained_glass"
$execute if score #note_type play_state matches 4 run tag @e[tag=$(mapid)_n$(id),type=item_display,limit=1] add note_stained_glass
# 混凝土：按 color（1~16）设置对应颜色的混凝土物品（★ 默认 9=黄绿，2026-08-08 用户要求；#glass_color 已在上方读取）
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 1 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:white_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 2 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:gray_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:light_gray_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 4 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:black_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 5 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:brown_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 6 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:red_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 7 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:orange_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 8 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:yellow_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 9 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:lime_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 10 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:green_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 11 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:cyan_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 12 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:light_blue_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 13 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:blue_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 14 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:purple_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 15 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:magenta_concrete"
$execute if score #note_type play_state matches 3 if score #glass_color play_state matches 16 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:pink_concrete"
$execute if score #note_type play_state matches 3 unless score #glass_color play_state matches 1..16 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] item.id set value "minecraft:lime_concrete"
# 音符命名：{音符类型}_{id}（展示实体，便于识别）
$execute if score #note_type play_state matches 0 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {CustomName:{"text":"音符盒_$(id)"}}
$execute if score #note_type play_state matches 1 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {CustomName:{"text":"木板_$(id)"}}
$execute if score #note_type play_state matches 2 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {CustomName:{"text":"唱片机_$(id)"}}
$execute if score #note_type play_state matches 3 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {CustomName:{"text":"混凝土_$(id)"}}
$execute if score #note_type play_state matches 4 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {CustomName:{"text":"染色玻璃_$(id)"}}

# 缩放 = size（x/y/z 先统一为 size；混凝土 z 轴随后覆盖为长条长度）
$execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.scale[0] float 0.01 run data get storage rhythm_axe:runtime cur_note.size 100
$execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.scale[1] float 0.01 run data get storage rhythm_axe:runtime cur_note.size 100
$execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.scale[2] float 0.01 run data get storage rhythm_axe:runtime cur_note.size 100

# ===== 朝向：展示实体正面面向落点（局部 +z 轴朝运动方向）=====
# 所有音符绕 Y（yaw）；混凝土额外绕 X（pitch）使长条沿含 Y 的运动方向（长条面垂直轨迹）
# 运动方向 = 判定位置 - 起始位置 = position - (position + start_pos) = -start_pos（×100 尺度）
#   ★ 注意：起始位置是 判定位置 + start_pos（translation 初始 = start_pos），故方向 = -start_pos
execute store result score #dir_x play_state run data get storage rhythm_axe:runtime cur_note.start_x 100
scoreboard players operation #dir_x play_state *= -1 const
execute store result score #dir_z play_state run data get storage rhythm_axe:runtime cur_note.start_z 100
scoreboard players operation #dir_z play_state *= -1 const
execute store result score #dir_y play_state run data get storage rhythm_axe:runtime cur_note.start_y 100
scoreboard players operation #dir_y play_state *= -1 const
# 非混凝土：朝向写 transformation.left_rotation（四元数），yaw = atan2(dx,dz)
# 混凝土：朝向写实体 Rotation（yaw/pitch）——旋转不在 transformation，不受插值影响、不抖
# ry = atan2(dx, dz)（标准四元数绕Y：使局部 +z 水平分量朝运动方向 (dx,dz)；
#   euler_to_quat 用标准数学四元数，而实体 yaw 正方向相反，故用 atan2(dx,dz) 而非 atan2(-dx,dz)）
scoreboard players operation #num display_calc = #dir_x play_state
scoreboard players operation #den display_calc = #dir_z play_state
function rhythm_axe:utilization/math/atan2
scoreboard players operation #ha_ry display_calc = #atan_deg100 display_calc
scoreboard players operation #ha_ry display_calc /= 20 const
# ===== 实体 Rotation 朝向（所有类型；与混凝土一致，Rotation 不入 transformation → 不受插值影响不抖）=====
# yaw = atan2(-dx, dz)（实体 yaw 正方向与数学相反）；pitch = atan2(-dy, h)（h = 水平距离×100）
# 局部 +z 经 (yaw,pitch) 旋转后指向运动方向 → 视觉偏移（translation）用局部坐标沿路径
# 先算水平距离 h
scoreboard players operation #hz2 display_calc = #dir_x play_state
scoreboard players operation #hz2 display_calc *= #dir_x play_state
scoreboard players operation #hzz display_calc = #dir_z play_state
scoreboard players operation #hzz display_calc *= #dir_z play_state
scoreboard players operation #hz2 display_calc += #hzz display_calc
scoreboard players operation #sqrt_sq display_calc = #hz2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #h_dist display_calc = #sqrt_out display_calc
# yaw
scoreboard players operation #num display_calc = #dir_x play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #dir_z play_state
function rhythm_axe:utilization/math/atan2
# 视觉朝向四舍五入到整度（消除 atan2 近似误差在长混凝土条上的可见偏移；引导线/判定不在此取整）
function rhythm_axe:utilization/math/round_deg100
scoreboard players operation #c_yaw display_calc = #atan_deg100 display_calc
$execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] Rotation[0] float 0.01 run scoreboard players get #c_yaw display_calc
# pitch
scoreboard players operation #num display_calc = #dir_y play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #h_dist display_calc
function rhythm_axe:utilization/math/atan2
function rhythm_axe:utilization/math/round_deg100
scoreboard players operation #c_pitch display_calc = #atan_deg100 display_calc
$execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] Rotation[1] float 0.01 run scoreboard players get #c_pitch display_calc
# 调试（lv.2）：朝向计算（dir/yaw/pitch/ha_ry）
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][朝向]","color":"light_purple"},{"text":" dir:","color":"gray"},{"score":{"objective":"play_state","name":"#dir_x"}},{"text":",","color":"gray"},{"score":{"objective":"play_state","name":"#dir_y"}},{"text":",","color":"gray"},{"score":{"objective":"play_state","name":"#dir_z"}},{"text":" yaw:","color":"gold"},{"score":{"objective":"display_calc","name":"#c_yaw"}},{"text":" pitch:","color":"gold"},{"score":{"objective":"display_calc","name":"#c_pitch"}},{"text":" ha_ry:","color":"gray"},{"score":{"objective":"display_calc","name":"#ha_ry"}}]
# 非混凝土：left_rotation 保持单位（朝向由实体 Rotation 控制；display_animation 会从单位四元数读欧拉角 0 → step 写单位，不覆盖朝向）
# 3D 距离 dist = |start_pos|×100（所有类型：混凝土 scale.z / note_c_dist / 普通与玻璃 translation 局部化用）
scoreboard players operation #d2 display_calc = #dir_x play_state
scoreboard players operation #d2 display_calc *= #dir_x play_state
scoreboard players operation #t2 display_calc = #dir_y play_state
scoreboard players operation #t2 display_calc *= #dir_y play_state
scoreboard players operation #d2 display_calc += #t2 display_calc
scoreboard players operation #t2 display_calc = #dir_z play_state
scoreboard players operation #t2 display_calc *= #dir_z play_state
scoreboard players operation #d2 display_calc += #t2 display_calc
scoreboard players operation #sqrt_sq display_calc = #d2 display_calc
function rhythm_axe:utilization/math/sqrt
# 保存 3D dist 到专用变量（#sqrt_out 后面会被混凝土 marker 段等覆盖；普通/玻璃后续用 #note_dist）
scoreboard players operation #note_dist display_calc = #sqrt_out display_calc
# 混凝土长条：scale.z = 长条长度 = 3D距离×duration/note_base_life / size（格数）
execute if score #note_type play_state matches 3 run scoreboard players operation #L100 display_calc = #sqrt_out display_calc
# ===== duration 统一读取（★ 缺省默认：混凝土/玻璃 8；显式写 0 的玻璃保留 0）=====
# data get 字段缺失会失败写 0 → 不能直接 store；用 if data 区分“缺失”与“显式 0”
scoreboard players set #dur display_calc 0
execute if data storage rhythm_axe:runtime cur_note.duration run execute store result score #dur display_calc run data get storage rhythm_axe:runtime cur_note.duration
execute if score #note_type play_state matches 3 unless data storage rhythm_axe:runtime cur_note.duration run scoreboard players set #dur display_calc 8
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:runtime cur_note.duration run scoreboard players set #dur display_calc 8
execute if score #note_type play_state matches 3 run scoreboard players operation #L100 display_calc *= #dur display_calc
execute if score #note_type play_state matches 3 run execute store result score #lt display_calc run data get storage rhythm_axe:runtime cur_note.note_base_life
execute if score #note_type play_state matches 3 if score #lt display_calc matches 1.. run scoreboard players operation #L100 display_calc /= #lt display_calc
# ★ size 用原始值（×1）：#L100 已是 ×100 尺度（=距离×100×dur/lt），除以 size（格）即得 scale.z×100；
#   若用 ×100 会把长条缩小 100 倍
#   （size<1 时整数截断为 0 会跳过除法，暂不支持 size<1 的混凝土）
execute if score #note_type play_state matches 3 run execute store result score #sz display_calc run data get storage rhythm_axe:runtime cur_note.size 1
execute if score #note_type play_state matches 3 if score #sz display_calc matches 1.. run scoreboard players operation #L100 display_calc /= #sz display_calc
# 混凝土长条：初始 scale.z = 0（出生未拉伸；段①由 display_animation 拉长）
$execute if score #note_type play_state matches 3 run execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.scale[2] float 0.01 run scoreboard players get 0 const
# 混凝土 translation 设局部起点（接入 display_animation 段①）：中心 = 出生位置（局部 z = -dist-size/2，x/y=0）
#   ★ 2026-08-26 尾端起点往回退 size/2：出生中心 = -d - s/2（此前 -d+s/2 是往判定方向进 size/2，方向反了）
#   ★ 朝向在实体 Rotation，translation 沿局部 +z = 路径方向
scoreboard players operation #c_start_z display_calc = #note_dist display_calc
scoreboard players operation #c_start_z display_calc *= -1 const
scoreboard players operation #c_half display_calc = #sz display_calc
scoreboard players operation #c_half display_calc *= 50 const
scoreboard players operation #c_start_z display_calc -= #c_half display_calc
$execute if score #note_type play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.translation set value [0.0,0.0,0.0]
$execute if score #note_type play_state matches 3 run execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.translation[2] float 0.01 run scoreboard players get #c_start_z display_calc
# 尾开始移动的时刻 = duration（★ 用户修正：尾应在寿命=-duration（= 出窗）时抵达判定位置，与段落判定同步；
#   不再用 min(duration,note_base_life)——那会让 dur>lt 的音符头刚到判定位置尾就开始缩，提前缩没）
#   尾移动 note_base_life 刻：t∈[dur, dur+lt] → 寿命从 lt-dur 到 -dur 正好抵达，随后出窗清除
# #dur 已在上方统一读取（缺省默认：混凝土 1 / 玻璃 3）
scoreboard players operation #cm display_calc = #dur display_calc
# 存储混凝土移动参数到展示实体（concrete_move 每 tick 用）：
#   note_c_sx/sy/sz = 起始偏移×100（= start_pos，即 -#dir）
#   note_c_lt = note_base_life；note_c_m = duration（尾开始移动的时刻）
#   note_c_dist = |start_pos|×100（出生→判定距离 = #sqrt_out）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sx = #dir_x play_state
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sx *= -1 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sy = #dir_y play_state
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sy *= -1 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sz = #dir_z play_state
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sz *= -1 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_lt run data get storage rhythm_axe:runtime cur_note.note_base_life
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_c_lt *= 16 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_c_lt /= note_speed options
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_dist run scoreboard players get #sqrt_out display_calc
# note_c_size = size×100（concrete_move 批量写 scale[0]/[1] 用）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_size run data get storage rhythm_axe:runtime cur_note.size 100
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_m = #cm display_calc
# 普通音符（0/1/2）：存 start 分量与 dist（move 算交互位置用：视觉 = Pos + 局部z×(-start/dist)）
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sx = #dir_x play_state
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sx *= -1 const
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sy = #dir_y play_state
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sy *= -1 const
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sz = #dir_z play_state
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sz *= -1 const
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_dist run scoreboard players get #note_dist display_calc
# 非混凝土（0/1/2/4）：展示实体初始 translation 改局部（沿路径 -dist；视觉 = 实体 Rotation × 局部）
#   ★ 之前初始用世界 start_pos 会被朝向旋转 → 运动方向/模型朝向错（朝向 bug 根因）
scoreboard players operation #neg_dist display_calc = #note_dist display_calc
scoreboard players operation #neg_dist display_calc *= -1 const
$execute unless score #note_type play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.translation set value [0.0,0.0,0.0]
$execute unless score #note_type play_state matches 3 run execute store result entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.translation[2] float 0.01 run scoreboard players get #neg_dist display_calc
#   note_c_sx/sy/sz = 起始偏移×100；note_c_lt = note_base_life；note_c_size = size×100；
#   note_c_easing/power = 缓动；note_glass_dur = duration（阶段2 镜像缓动用）
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sx = #dir_x play_state
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sx *= -1 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sy = #dir_y play_state
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sy *= -1 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sz = #dir_z play_state
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_c_sz *= -1 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_lt run data get storage rhythm_axe:runtime cur_note.note_base_life
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_c_lt *= 16 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_c_lt /= note_speed options
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_dist run scoreboard players get #note_dist display_calc
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_size run data get storage rhythm_axe:runtime cur_note.size 100
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_easing run data get storage rhythm_axe:runtime cur_note.anim_easing
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_power run data get storage rhythm_axe:runtime cur_note.anim_power
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] if score @s note_c_easing matches 0 run scoreboard players set @s note_c_easing 1
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] if score @s note_c_power matches 0 run scoreboard players set @s note_c_power 1
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_glass_dur = #dur display_calc
# ★ 2026-09-01 玻璃 duration 缩放：note_glass_dur = duration×16/note_speed（与前半段 note_c_lt 缩放一致，保持前后段速度相同；endpoint dist×dur/lt 因 note_c_lt 同步缩放而不变）
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_glass_dur *= 16 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_glass_dur /= note_speed options
# 染色玻璃缓动参数（混凝土缓动参数在上面已统一；玻璃 note_c_easing/power 已在上面设置）# 混凝土缓动参数（concrete_move 每 tick 应用 anim_easing/anim_power；默认 1=线性）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_easing run data get storage rhythm_axe:runtime cur_note.anim_easing
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_power run data get storage rhythm_axe:runtime cur_note.anim_power
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] if score @s note_c_easing matches 0 run scoreboard players set @s note_c_easing 1
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] if score @s note_c_power matches 0 run scoreboard players set @s note_c_power 1
# ★ 阶段A（性能轮）：展示实体 Pos/scale 固定 → 一次性快照到计分板，move 每 tick 读计分板替代 data get entity（省每音符每 tick 4 次 NBT 读）
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_base_x run data get entity @s Pos[0] 100
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_base_y run data get entity @s Pos[1] 100
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_base_z run data get entity @s Pos[2] 100
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_time run data get storage rhythm_axe:runtime cur_note.time
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_half_size run data get entity @s transformation.scale[1] 100
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_half_size /= 2 const
# note_cur_tz 初始 = 初始局部 z（-dist；step/glass_move 每 tick 覆盖，move 读它算视觉位置；混凝土 move 跳过不设）
$execute unless score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_cur_tz = #neg_dist display_calc

# 交互实体（判定检测；width/height = size）
# 注意：所有操作交互实体的选择器都必须限定 tag=note_interaction，
#   因为同一音符还有一个 item_display 展示实体（note_display，兼作完美判定区域代表，见下方）
$summon interaction $(pos_x) $(pos_y) $(pos_z) {width:1f,height:1f,response:true,Tags:["note","note_interaction","$(mapid)_n$(id)","map_$(mapid)"]}
$execute store result entity @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] width float 0.01 run data get storage rhythm_axe:runtime cur_note.size 100
$execute store result entity @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] height float 0.01 run data get storage rhythm_axe:runtime cur_note.size 100
# 交互实体初始位置 = 视觉出生位置（判定位置 + start_pos）
execute store result score #ipx play_state run data get storage rhythm_axe:runtime cur_note.pos_x 100
execute store result score #ipx2 play_state run data get storage rhythm_axe:runtime cur_note.start_x 100
scoreboard players operation #ipx play_state += #ipx2 play_state
execute store result score #ipy play_state run data get storage rhythm_axe:runtime cur_note.pos_y 100
execute store result score #ipy2 play_state run data get storage rhythm_axe:runtime cur_note.start_y 100
scoreboard players operation #ipy play_state += #ipy2 play_state
# 交互实体 Pos 为脚底、展示实体 Pos 为方块中心 → y 减去 音符尺寸×0.5（×100 尺度：size×100/2）
#   使交互实体碰撞箱完全包裹展示模型（设计：交互实体嵌套展示实体、中心同一）
execute store result score #tmp_size play_state run data get storage rhythm_axe:runtime cur_note.size 100
scoreboard players operation #tmp_size play_state /= 2 const
scoreboard players operation #ipy play_state -= #tmp_size play_state
execute store result score #ipz play_state run data get storage rhythm_axe:runtime cur_note.pos_z 100
execute store result score #ipz2 play_state run data get storage rhythm_axe:runtime cur_note.start_z 100
scoreboard players operation #ipz play_state += #ipz2 play_state
$execute store result entity @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] Pos[0] double 0.01 run scoreboard players get #ipx play_state
$execute store result entity @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] Pos[1] double 0.01 run scoreboard players get #ipy play_state
$execute store result entity @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] Pos[2] double 0.01 run scoreboard players get #ipz play_state
# 混凝土：note_prev_cx/cy/cz 初始 = 交互实体初始位置（= 出生位置头端，y 已减 size/2；concrete_move 每刻写上一刻头端用）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev_cx = #ipx play_state
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev_cy = #ipy play_state
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev_cz = #ipz play_state

# 初始化展示实体"上一刻位置"计分板（move 解耦延迟用；= 初始视觉位置 ×100，y 不含交互底部偏移）
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev_x = #ipx play_state
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev_z = #ipz play_state
execute store result score #tmp_vy play_state run data get storage rhythm_axe:runtime cur_note.pos_y 100
execute store result score #tmp_sy play_state run data get storage rhythm_axe:runtime cur_note.start_y 100
scoreboard players operation #tmp_vy play_state += #tmp_sy play_state
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev_y = #tmp_vy play_state
# note_prev2_*（上上一刻）初始同 note_prev_*（玻璃扫掠段起点用；初始视觉中心）
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev2_x = #ipx play_state
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev2_y = #tmp_vy play_state
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players operation @s note_prev2_z = #ipz play_state

# 玻璃判定中心 marker（混凝土模式：交互实体仅位置跟随，判定用 marker）
# 位置 = 玻璃中心 = 初始视觉位置（y 不减 size/2 = #tmp_vy；x/z = #ipx/#ipz）
$execute if score #note_type play_state matches 4 run summon marker $(pos_x) $(pos_y) $(pos_z) {Tags:["note","note_glass_center","$(mapid)_n$(id)_center","map_$(mapid)"]}
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id)_center,type=marker,limit=1] run scoreboard players set @s note_id $(id)
# 玻璃中心 marker 也记录颜色（damage 撞墙反馈在 marker 上跑，particle_glass 需要）
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id)_center,type=marker,limit=1] run scoreboard players set @s note_color 0
$execute if score #note_type play_state matches 4 if data storage rhythm_axe:runtime cur_note.color run execute as @e[tag=$(mapid)_n$(id)_center,type=marker,limit=1] run execute store result score @s note_color run data get storage rhythm_axe:runtime cur_note.color
$execute if score #note_type play_state matches 4 run execute store result entity @e[tag=$(mapid)_n$(id)_center,type=marker,limit=1] Pos[0] double 0.01 run scoreboard players get #ipx play_state
$execute if score #note_type play_state matches 4 run execute store result entity @e[tag=$(mapid)_n$(id)_center,type=marker,limit=1] Pos[1] double 0.01 run scoreboard players get #tmp_vy play_state
$execute if score #note_type play_state matches 4 run execute store result entity @e[tag=$(mapid)_n$(id)_center,type=marker,limit=1] Pos[2] double 0.01 run scoreboard players get #ipz play_state

# 给展示实体与交互实体记录 note_id（配对用；note_id 为独立计分板）
$execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players set @s note_id $(id)
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_id $(id)

# ===== 音符间引导线（M2-todo）：0/1/2 且 following_point=true → 连到上一个 0/1/2 =====
# following_point 缺省 0（关闭，与编辑器一致）；为 true 且有上一个存活 0/1/2 → 生成引导线连接前后
# ★ 指针 #guide_last_id 记录"排序后数组前一个 0/1/2"（生成顺序 = 数组顺序；3/4 跳过不更新）
scoreboard players set #is_following_point play_state 0
execute if data storage rhythm_axe:runtime cur_note.following_point run execute store result score #is_following_point play_state run data get storage rhythm_axe:runtime cur_note.following_point
# 把上一个 0/1/2 的 id 存入 cur_note.guide_prev 作为宏参数（spawn 用）
execute if score #note_type play_state matches 0..2 if score #is_following_point play_state matches 1 run execute store result storage rhythm_axe:runtime cur_note.guide_prev int 1 run scoreboard players get #guide_last_id play_state
# 记录时间参数：time_prev = 前一个音符判定时刻、n = 当前判定时刻 - 前一个判定时刻（收缩公式用）
execute if score #note_type play_state matches 0..2 if score #is_following_point play_state matches 1 run execute as @e[type=item_display,tag=note_display] if score @s note_id = #guide_last_id play_state run execute store result score #guide_tp play_state run scoreboard players get @s note_time
execute if score #note_type play_state matches 0..2 if score #is_following_point play_state matches 1 run execute store result score #guide_tt play_state run data get storage rhythm_axe:runtime cur_note.time
scoreboard players operation #guide_n play_state = #guide_tt play_state
scoreboard players operation #guide_n play_state -= #guide_tp play_state
execute if score #note_type play_state matches 0..2 if score #is_following_point play_state matches 1 if score #guide_last_id play_state matches 0.. if score #guide_n play_state matches 1.. run execute store result storage rhythm_axe:runtime cur_note.guide_tp int 1 run scoreboard players get #guide_tp play_state
execute if score #note_type play_state matches 0..2 if score #is_following_point play_state matches 1 if score #guide_last_id play_state matches 0.. if score #guide_n play_state matches 1.. run execute store result storage rhythm_axe:runtime cur_note.guide_n int 1 run scoreboard players get #guide_n play_state
# 生成：仅当上一个展示实体仍存活（as @e 匹配 note_id 才执行）且 n>=1；spawn 宏上下文 = cur_note
execute if score #note_type play_state matches 0..2 if score #is_following_point play_state matches 1 if score #guide_last_id play_state matches 0.. if score #guide_n play_state matches 1.. run execute as @e[type=item_display,tag=note_display] if score @s note_id = #guide_last_id play_state run function rhythm_axe:play/note/guide/spawn with storage rhythm_axe:runtime cur_note
# 更新指针 = 当前音符 id（仅 0/1/2；3/4 不参与引导线，保持指针不变）
$execute if score #note_type play_state matches 0..2 run scoreboard players set #guide_last_id play_state $(id)

# 交互实体补加类型 tag（必须在本行，因为 summon interaction 在此之前才生成交互实体）
$execute if score #note_type play_state matches 0 run tag @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] add note_noteblock
$execute if score #note_type play_state matches 1 run tag @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] add note_plank
$execute if score #note_type play_state matches 2 run tag @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] add note_jukebox
$execute if score #note_type play_state matches 3 run tag @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] add note_concrete
$execute if score #note_type play_state matches 4 run tag @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] add note_stained_glass

# 染色玻璃交互实体记录持续时长（M2-G 出窗用：寿命 + duration <= 0 → 清除；#dur 已统一读取）
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_glass_dur = #dur display_calc
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_glass_dur *= 16 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_glass_dur /= note_speed options
# 记录交互实体初始寿命（= 基础寿命，每 tick 递减，M2-B）
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run execute store result score @s note_life run data get storage rhythm_axe:runtime cur_note.note_base_life
# ★ 2026-09-01 流速缩放：note_life = base_life×16/note_speed（流速16恒等；ignore_note_speed 不缩放）
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_life *= 16 const
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_life /= note_speed options
# 记录判定反馈组号（note_hitsound / note_hit_particles，M2-H 查表；缺省 0）
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_hitsound = #note_type play_state
$execute if data storage rhythm_axe:runtime cur_note.hitsound run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run execute store result score @s note_hitsound run data get storage rhythm_axe:runtime cur_note.hitsound
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_hit_particles = #note_type play_state
$execute if data storage rhythm_axe:runtime cur_note.hit_particles run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run execute store result score @s note_hit_particles run data get storage rhythm_axe:runtime cur_note.hit_particles
# 记录音符颜色（混凝土默认组3动态破坏粒子用；缺省 0）
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_color 0
$execute if data storage rhythm_axe:runtime cur_note.color run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run execute store result score @s note_color run data get storage rhythm_axe:runtime cur_note.color
# 混凝土交互实体记录 note_c_m（出窗已改用 -duration，此值仅保留，供潜在调试；m=duration）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_m = #cm display_calc
# ===== 混凝土判定初始化（M2-F）=====
# 段落：每 density 刻一段；段 1 从寿命 0 开始，段 k 结束寿命 = -k×density；最后一段到 -duration
# 交互实体存 density、duration 与段落状态
# ★ density 缺省默认 8（★ 先 set 8，若字段存在再覆盖；data get 字段缺失会失败写 0 → 不能直接 store）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_c_density 8
$execute if score #note_type play_state matches 3 if data storage rhythm_axe:runtime cur_note.density run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run execute store result score @s note_c_density run data get storage rhythm_axe:runtime cur_note.density
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_dur = #dur display_calc
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_c_seg_done 0
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_seg_end = @s note_c_density
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_seg_end *= -1 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_c_seg_idx 1
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_c_done 0
# 段数 = ceil(dur/density)（推进时末段 seg_end 用 -duration，非整数倍不能继续减 density）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_seg_count = @s note_c_dur
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_seg_count += @s note_c_density
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_seg_count -= 1 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players operation @s note_c_seg_count /= @s note_c_density
# 单段（seg_count==1）时首段=末段，seg_end = -duration（按末段处理，保护2/推进均适用）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] if score @s note_c_seg_count matches 1 run scoreboard players operation @s note_c_seg_end = @s note_c_dur
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] if score @s note_c_seg_count matches 1 run scoreboard players operation @s note_c_seg_end *= -1 const
# ===== 混凝土判定区域 marker =====
# 判定区域：判定点沿前进方向 4 格长、1 格宽、3 格高（不受 size 影响）
# 水平距离 > 1：marker 在判定点 + Rotation(yaw)=运动方向，检测时用本地 ^ 逐格探 4 格
# 水平距离 ≤ 1：marker 在判定点，检测时用 3×3×3
# marker yaw（实体）= atan2(-dir_x, dir_z)（#num = -dir_x = start_x，#den = dir_z = -start_z）
scoreboard players operation #num display_calc = #dir_x play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #dir_z play_state
execute if score #note_type play_state matches 3 run function rhythm_axe:utilization/math/atan2
# 水平距离（×100）
execute if score #note_type play_state matches 3 run scoreboard players operation #hz2 display_calc = #dir_x play_state
execute if score #note_type play_state matches 3 run scoreboard players operation #hz2 display_calc *= #dir_x play_state
execute if score #note_type play_state matches 3 run scoreboard players operation #hzz display_calc = #dir_z play_state
execute if score #note_type play_state matches 3 run scoreboard players operation #hzz display_calc *= #dir_z play_state
execute if score #note_type play_state matches 3 run scoreboard players operation #hz2 display_calc += #hzz display_calc
execute if score #note_type play_state matches 3 run scoreboard players operation #sqrt_sq display_calc = #hz2 display_calc
execute if score #note_type play_state matches 3 run function rhythm_axe:utilization/math/sqrt
# 生成 marker（判定位置）；远距离 note_c_zone（^ 探格），近距离 note_c_zone_near（3×3×3）
# ★ 同展示实体：宏整数坐标会对齐方块中心 → summon 到原点后 data modify 写精确 Pos
$execute if score #note_type play_state matches 3 if score #sqrt_out display_calc matches 101.. run summon marker 0.0 0.0 0.0 {Tags:["note","note_c_zone","$(mapid)_n$(id)_zone","map_$(mapid)"],Rotation:[0f,0f]}
$execute if score #note_type play_state matches 3 if score #sqrt_out display_calc matches ..100 run summon marker 0.0 0.0 0.0 {Tags:["note","note_c_zone_near","$(mapid)_n$(id)_zone","map_$(mapid)"],Rotation:[0f,0f]}
$execute if score #note_type play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id)_zone,type=marker,limit=1] Pos[0] set from storage rhythm_axe:runtime cur_note.pos_x
$execute if score #note_type play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id)_zone,type=marker,limit=1] Pos[1] set from storage rhythm_axe:runtime cur_note.pos_y
$execute if score #note_type play_state matches 3 run data modify entity @e[tag=$(mapid)_n$(id)_zone,type=marker,limit=1] Pos[2] set from storage rhythm_axe:runtime cur_note.pos_z
# marker 设置 yaw（Rotation[0]，度×100 → float 0.01）与 note_id（配对检测/删除）
$execute if score #note_type play_state matches 3 run execute store result entity @e[tag=$(mapid)_n$(id)_zone,type=marker,limit=1] Rotation[0] float 0.01 run scoreboard players get #atan_deg100 display_calc
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id)_zone,type=marker,limit=1] run scoreboard players set @s note_id $(id)
# 判定保护状态与记录寿命初始化（M2-C）；note_recorded_life 用 -1 表示“无记录”
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_protect 0
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_recorded_life -1
# note_active=0：出生 tick 不递减（避免判定时刻偏差 1 tick），下 tick 起开始递减
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_active 0
# 混凝土/染色玻璃展示实体也记录寿命（与交互同步递减，concrete/tick、glass/tick 用）与 note_active
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_life run data get storage rhythm_axe:runtime cur_note.note_base_life
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_life *= 16 const
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_life /= note_speed options
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players set @s note_active 0
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_life run data get storage rhythm_axe:runtime cur_note.note_base_life
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_life *= 16 const
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless data storage rhythm_axe:runtime cur_note.ignore_note_speed run scoreboard players operation @s note_life /= note_speed options
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run scoreboard players set @s note_active 0
# 混凝土/染色玻璃展示实体：interpolation_duration=1（持续值；display_animation/start 每次启动也会设，
#   但这里先设保证出生首帧/段间衔接也平滑）
# ★ 抖动已解决：旋转在实体 Rotation（不入 transformation，不受 display 插值影响）——见上方"实体 Rotation 朝向"段；
#   辅助措施：transform 剩余字段（平移/缩放）每刻也须批量单次 merge 写入，多次单独写会每写一次触发插值重定位 → 抖
$execute if score #note_type play_state matches 3 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {interpolation_duration:1}
$execute if score #note_type play_state matches 4 run data merge entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] {interpolation_duration:1}
# 混凝土接入（★ 2026-08-10 分流）：线性（幂次 1）→ 客户端插值三段（seg1_client → seg2_client → seg3_client）；
#   非线性 → display_animation 三段（concrete/init → seg2 → seg3）
#   ★ 所有混凝土参数（note_c_*）已存储、translation 已设局部起点 → 线性走 seg1_client（方案3 预置插值参数），非线性走 init（预置段① display_animation）
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] if score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg1_client
$execute if score #note_type play_state matches 3 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/init
# 玻璃接入 display_animation：非线性（幂次 ≠1）或 dur=0（无后段）→ 启动段①（到位；tick 推进段②穿过后段）
#   ★ 线性玻璃（幂次 1 dur≥1）走客户端插值（motion/init），不在这里
#   ★ 所有玻璃参数（note_c_*、note_glass_dur）已存储、translation 已设局部起点 → init 预置段①参数并启动
# ★ 用实体自身 note_c_power 判断（幂次 1 = 线性，与缓动类型无关）
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] unless score @s note_c_power matches 1 run function rhythm_axe:play/note/glass/init
$execute if score #note_type play_state matches 4 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] if score @s note_c_power matches 1 if score #dur display_calc matches ..0 run function rhythm_axe:play/note/glass/init

# ===== 完美判定区域 marker（判定位置；仅用于判定保护进入检测）=====
# ===== 完美判定区域 = 展示实体本身（Pos=判定位置；无碰撞箱不挡视线）=====
# 判定保护进入条件 = 在 bad 前一刻（寿命=3x+1）玩家视线与该区域相交（音符.md）
# 区域 = 以判定位置为中心、尺寸与音符大小相同的区域
# 展示实体 Pos 恒定 = 判定位置（transformation.translation 是动画偏移）→ 直接代表完美判定区域中心
# 展示实体无碰撞箱 → 不阻挡视线（interaction 会挡，已弃用）
# 射线步进（active_note/raycast）用"采样点距离检测"判断玩家视线是否经过判定位置

# ===== 移动动画：translation 从 start_pos → 0（时长 = note_base_life）=====
# 动画终点 = 起始 + DELTA = start_pos + (-start_pos) = 0（判定位置）
# 时序（display_animation/display_animation 当刻首帧 + 判定箱解耦见 move.mcfunction）：
#   inline 首帧 → NBT 完成于 T_(duration-1)；duration=note_base_life → NBT 在 life=1 完成。
#   渲染插值晚约1刻 → 视觉 life=0 到位；判定箱跟随视觉 → 也 life=0 到位。
#   玩家看着音符到判定位置时打 = perfect。
execute store result score #ANIM_DURATION display_calc run data get storage rhythm_axe:runtime cur_note.note_base_life
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
# （#ANIM_DURATION = note_base_life 已在上方设置：非线性 display_animation 用它；
#   线性音符改用统一 #m_dur：普通=lt、玻璃=lt+dur，见下方"线性运动统一模型"）
execute store result score #ANIM_EASING display_calc run data get storage rhythm_axe:runtime cur_note.anim_easing
execute if score #ANIM_EASING display_calc matches 0 run scoreboard players set #ANIM_EASING display_calc 1
execute store result score #ANIM_POWER display_calc run data get storage rhythm_axe:runtime cur_note.anim_power
execute if score #ANIM_POWER display_calc matches 0 run scoreboard players set #ANIM_POWER display_calc 1
# 普通音符移动动画：translation 用局部坐标沿路径（局部 +z 朝运动方向；起点 (0,0,-dist) → 终点 0）
# ★ 之前用世界 start_pos 作 DELTA 会被朝向旋转 → 运动方向与朝向不一致（朝向 bug 根因）
scoreboard players set #ANIM_START_PX display_calc 0
scoreboard players set #ANIM_START_PY display_calc 0
scoreboard players operation #ANIM_START_PZ display_calc = #note_dist display_calc
scoreboard players operation #ANIM_START_PZ display_calc *= -1 const
scoreboard players set #ANIM_DELTA_PX display_calc 0
scoreboard players set #ANIM_DELTA_PY display_calc 0
scoreboard players operation #ANIM_DELTA_PZ display_calc = #note_dist display_calc
scoreboard players set #ANIM_APPLY_POSITION display_calc 0
# 普通音符（0/1/2）：启动移动动画
# 混凝土（3）：display_animation 三段（concrete/init 拉伸 → seg2 平移 → seg3 收缩）
# 染色玻璃（4）：display_animation 两段（glass/init 到位 → seg2 穿过后段；镜像缓动）
#   ★ 线性音符（幂次 1）走客户端插值 motion/init；非线性走上述 display_animation
# ★ 阶段C（线性客户端插值，2026-08-08）：anim_power=1 的纯线性音符 → 一次性客户端插值
#   （出生下一 tick 设置"起点→终点"插值，原版自动渲染，服务器不再每 tick 驱动 → 省 step 计算 + 展示实体 NBT 写入）
#   非线性音符 → 原 display_animation 逐帧驱动（兜底不变）。
#   ★ 可回退：把下面所有 if #ANIM_EASING/#ANIM_POWER 分支的动作改回 anim_task + display_animation 即可整体回退到阶段A。
# ===== 线性运动统一模型（阶段C 重写，2026-08-08）=====
# 普通 0/1/2 + 玻璃 4 的纯线性音符（幂次 1）共用一套客户端插值：
#   点沿直线从局部 z=-dist 运动到 +end（普通 end=0 → 到位判定位置；玻璃 end=dist×dur/lt → 穿过后段）
#   插值时长 #m_dur（D）：普通=lt，玻璃=lt+dur（★ 2026-08-29：出生提前 4 刻、寿命+4，可见移动占满 note_base_life → 速度=dist/lt）
#   ★ 客户端插值只在出生+4 tick 一次性下发 参数+终点（motion/start），服务器不再每 tick 驱动展示实体 NBT
#     → 省 easing 计算 + 展示实体 NBT 写入（高 BPM 性能关键，mspt 需求 30 以下）
# 非线性音符 → 原 display_animation 逐帧驱动（兜底不变）；玻璃非线性/无后段 → glass/init（display_animation 两段）。
# ★ 2026-08-29 线性音符寿命 +DELAY(4)：scan_birth_one 已把出生提前 4 刻，这里把交互实体寿命延长 4，
#   使 note_life 仍在判定时刻 =0（节拍不变）；可见移动占满 note_base_life → 速度 = dist/note_base_life
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players add @s note_life 4
$execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players add @s note_life 4
# ---- 统一线性参数 #m_dur（D）/ #m_end（end×100）----
# 普通（0/1/2）：D=lt（★ 2026-08-29：出生提前 4 刻→移动起始=判定前 lt 刻，插值时长=lt，速度=dist/lt）、end=0
#   ★ 服务器交互同步用 note_lin_dur=D → 客户端与服务器速度一致（消除"速度不一致"担忧）
scoreboard players operation #m_dur display_calc = #ANIM_DURATION display_calc
execute if score #m_dur display_calc matches ..0 run scoreboard players set #m_dur display_calc 1
scoreboard players set #m_end display_calc 0
scoreboard players set #m_sz_end display_calc 0
# 玻璃（4，幂次 1 dur≥1）：D=lt+dur（★ 2026-08-29：出生提前 4 刻、寿命+4，可见移动占满 lt+dur，基速=dist/lt）、end=dist×dur/lt
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_dur display_calc = #ANIM_DURATION display_calc
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_dur display_calc += #dur display_calc
# ★ 2026-09-01 线性玻璃 D 缩放：#m_dur = (lt+dur)×16/note_speed（与 note_life 同步，保持到位在节拍）
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_dur display_calc *= 16 const
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_dur display_calc /= note_speed options
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. if score #m_dur display_calc matches ..0 run scoreboard players set #m_dur display_calc 1
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_end display_calc = #note_dist display_calc
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_end display_calc *= #dur display_calc
execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run scoreboard players operation #m_end display_calc /= #ANIM_DURATION display_calc
# ===== 线性音符出生隐藏（★ 2026-08-29）：出生 scale=0（不可见，避免延迟期停在出生位置），motion/start 恢复 size =====
#   先存 note_c_size = size×100（普通 0/1/2 原本不存，motion/start 恢复 scale 用；玻璃 4 已有，重复存无害）
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_size run data get storage rhythm_axe:runtime cur_note.size 100
$execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run execute store result score @s note_c_size run data get storage rhythm_axe:runtime cur_note.size 100
#   隐藏：scale 归零（note_half_size 已在上方从 size 快照，不受影响）
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.scale set value [0.0,0.0,0.0]
$execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run data modify entity @e[tag=$(mapid)_n$(id),type=item_display,limit=1] transformation.scale set value [0.0,0.0,0.0]
# ---- 调用统一初始化（motion/init：记录 D/end/scale 终点/进度 + 打 pending；参数改由 motion/start 与终点同刻下发）----
# 普通 0/1/2 纯线性（幂次 1）→ 客户端插值
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run function rhythm_axe:play/note/motion/init
# 玻璃 4 纯线性且 dur≥1 → 客户端插值（dur=0 = 无后段 → 走 glass/init display_animation 两段）
$execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run execute as @e[tag=$(mapid)_n$(id),type=item_display,limit=1] run function rhythm_axe:play/note/motion/init
# ---- 非线性分支：原 display_animation 路径（逐帧驱动，兜底；混凝土/玻璃不在此）----
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 unless score #ANIM_POWER display_calc matches 1 run tag @e[tag=$(mapid)_n$(id),type=item_display,limit=1] add anim_task
execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 unless score #ANIM_POWER display_calc matches 1 run function rhythm_axe:utilization/display_animation/display_animation

# ===== M2-H 判定反馈：存储 hit_events + 生成反馈（spawn 音效/粒子 + spawn 事件）=====
# hit_events 存 storage（判定/生成时按 note_id 读取执行；音符清除时删除）
# ★ 无 hit_events 数据时也存默认空列表（以默认值执行：无特效指令；使反馈链始终走执行流程，未来默认特效可扩展）
$execute if data storage rhythm_axe:runtime cur_note.hit_events run data modify storage rhythm_axe:runtime hit_events.$(id) set from storage rhythm_axe:runtime cur_note.hit_events
$execute unless data storage rhythm_axe:runtime cur_note.hit_events run data modify storage rhythm_axe:runtime hit_events.$(id) set value []
# ★ 2026-08-29 spawn 反馈在"开始移动"那一刻执行一次（各类型开始移动时刻不同）：
#   - 线性音符（普通 0/1/2、线性玻璃）：开始移动 = 出生+4 刻 → 延迟 5
#   - 其他（混凝土/非线性/玻璃 dur=0）：开始移动 = 出生当刻 → 延迟 1（立即触发）
#   用 note_spawn_delay 计数（active_note 递减、归 0 触发一次）；note_moving 标记已开始运动（tick 事件每刻用）
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_spawn_delay 1
$execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_moving 0
$execute unless score #note_type play_state matches 3 unless score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_spawn_delay 5
$execute if score #note_type play_state matches 4 if score #ANIM_POWER display_calc matches 1 if score #dur display_calc matches 1.. run execute as @e[tag=$(mapid)_n$(id),type=interaction,tag=note_interaction,limit=1] run scoreboard players set @s note_spawn_delay 5
