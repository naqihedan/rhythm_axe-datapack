# 生成编辑器音符的一对实体（宏参数：nid,pos_x,pos_y,pos_z,start_x,start_y,start_z,size,type,color,lt,dur,prog1000,easing,power,hitsound,hit_particles,idx）
# 与游玩视觉一致：判定位置 = (pos_x,pos_y,pos_z)；当前位置按 playhead 由 place 统一计算（局部 z）
# 朝向 = 实体 Rotation（yaw/pitch）朝运动方向（dir = -start_pos）
# tag 与游玩隔离：editor_note（统一清理）+ editor_n_<nid>（唯一定位）
#arg: nid,pos_x,pos_y,pos_z,start_x,start_y,start_z,size,type,color,lt,dur,prog1000,easing,power,density,hitsound,hit_particles,idx

# ★ 2026-09-04 防"原点幽灵"：播放路径（tick_birth_go_ 宏递归）可能重复 summon 同一音符，导致未配置的重复副本堆积
#   （副本没有 editor_n_type/Pos，停在原点、默认音符盒贴图）。生成前先清掉同名旧实体，保证每个 note_id 只有一份且被正确配置。
$kill @e[tag=editor_n_$(nid)]

# ===== 朝向：dir = -start_pos（运动方向 = 出生→判定）=====
execute store result score #dir_x play_state run data get storage rhythm_axe:prop start_x 100
scoreboard players operation #dir_x play_state *= -1 const
execute store result score #dir_y play_state run data get storage rhythm_axe:prop start_y 100
scoreboard players operation #dir_y play_state *= -1 const
execute store result score #dir_z play_state run data get storage rhythm_axe:prop start_z 100
scoreboard players operation #dir_z play_state *= -1 const
# 水平距离 h
scoreboard players operation #hz2 display_calc = #dir_x play_state
scoreboard players operation #hz2 display_calc *= #dir_x play_state
scoreboard players operation #hzz display_calc = #dir_z play_state
scoreboard players operation #hzz display_calc *= #dir_z play_state
scoreboard players operation #hz2 display_calc += #hzz display_calc
scoreboard players operation #sqrt_sq display_calc = #hz2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #h_dist display_calc = #sqrt_out display_calc
# yaw = atan2(-dir_x, dir_z)（★ 2026-08-26 实测旋转矩阵确认：local+z = (-sin y·cos p, -sin p, cos y·cos p)；
#   此式使局部 +z 指向运动方向 dir=-start；translation 只用局部 z 才不被旋转扭曲）
scoreboard players operation #num display_calc = #dir_x play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #dir_z play_state
function rhythm_axe:utilization/math/atan2
# 视觉朝向四舍五入到整度（消除 atan2 近似误差在长混凝土条上的可见偏移；引导线/判定不在此取整）
function rhythm_axe:utilization/math/round_deg100
scoreboard players operation #c_yaw display_calc = #atan_deg100 display_calc
# pitch = atan2(-dir_y, h)（垂直分量朝运动方向）
scoreboard players operation #num display_calc = #dir_y play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #h_dist display_calc
function rhythm_axe:utilization/math/atan2
function rhythm_axe:utilization/math/round_deg100
scoreboard players operation #c_pitch display_calc = #atan_deg100 display_calc
# 3D 距离 dist = |start_pos|×100
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
scoreboard players operation #note_dist display_calc = #sqrt_out display_calc

# ===== 展示实体（summon 用宏坐标在判别位置生成，再 store result 覆写精确 Pos）=====
# ★ 2026-09-04：summon 用宏参数（即使被对齐方块中心也"能加载"）；精确位置由下方 store result 覆写
#   （data modify set from 写实体 Pos 实测失效，Pos 留 0,0,0 → 远处音符展示实体停在原点）
$summon item_display $(pos_x) $(pos_y) $(pos_z) {item:{id:"minecraft:note_block",count:1},Tags:["editor_note","editor_n_$(nid)"],brightness:{block:15,sky:15},transformation:{translation:[0.0,0.0,0.0],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
# （Pos/Rotation 已移至 fill_disp：1 次选择器代 5 次扫描）
# ===== 外观：类型→物品 + 类型 tag =====
execute store result score #note_type play_state run data get storage rhythm_axe:prop type
# （item.id 外观分支已移至 fill_disp：分支短路，无实体扫描）
# 音符命名：{类型}_{id}
$execute if score #note_type play_state matches 0 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"音符盒_$(nid)"}}
$execute if score #note_type play_state matches 1 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"木板_$(nid)"}}
$execute if score #note_type play_state matches 2 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"唱片机_$(nid)"}}
$execute if score #note_type play_state matches 3 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"混凝土_$(nid)"}}
$execute if score #note_type play_state matches 4 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"染色玻璃_$(nid)"}}
# 缩放 = size（x/y/z 统一）；#nsz = round(size×100)（浮点精度四舍五入）
scoreboard players set #nsz display_calc 0
execute store result score #nsz display_calc run data get storage rhythm_axe:prop size 1000
scoreboard players operation #nsz display_calc += 5 const
scoreboard players operation #nsz display_calc /= 10 const
# （scale 写入已移至 fill_disp）
# 混凝土长条全长（×100）：短 hold = dist×dur/lt；长 hold = dist+size（尾端起点往回退 size/2 → 头端到位 s/2 需多走 size）
# ★ 2026-08-26：短 hold 同游玩（dist×dur/lt）；长 hold 因尾端起点 = -d-s/2、头端终点 = s/2，全长 = d+s
scoreboard players operation #L100 display_calc = #note_dist display_calc
execute if score #note_type play_state matches 3 if score #n_dur editor <= #n_lt editor run scoreboard players operation #L100 display_calc *= #n_dur editor
execute if score #note_type play_state matches 3 if score #n_dur editor <= #n_lt editor run scoreboard players operation #L100 display_calc /= #n_lt editor
execute if score #note_type play_state matches 3 if score #n_dur editor > #n_lt editor run scoreboard players operation #sz100 display_calc = #nsz display_calc
execute if score #note_type play_state matches 3 if score #n_dur editor > #n_lt editor run scoreboard players operation #L100 display_calc += #sz100 display_calc
# （混凝土长条 scale[2] / editor_n_len 写入已移至 fill_disp）

# ===== 交互实体（重现只看不碰；为后续编辑交互预留）=====
$summon interaction $(pos_x) $(pos_y) $(pos_z) {width:1f,height:1f,response:true,Tags:["editor_note","editor_n_$(nid)"]}
# width/height（按 #nsz 缩放）+ note_id + editor_n_idx：由 fill_inter 一次性 @s 写入（1 次选择器代 4 次）
$execute as @e[tag=editor_n_$(nid),type=interaction,limit=1] run function rhythm_axe:editor/visual/fill_inter

# ===== 存储移动参数到展示实体（place 统一计算位置 + 播放 tick 清理用）=====
# note_id：唯一 id；editor_n_birth/time/end：出生/判定/消失虚拟时刻；editor_n_dist：dist×100
# editor_n_type：类型；editor_n_dur/lt：duration/note_base_life；editor_n_easing/power：缓动参数；editor_n_len：混凝土长条全长×100
# ===== 计分板参数已由 fill_disp 以 @s 写入（30+ 次选择器 → 1 次）；此处只保留中间量计算 =====
# 玻璃（4）穿过后段时长随流速缩放（×16/note_speed，ignore 除外）→ 与游玩 note_glass_dur 一致
scoreboard players operation #glass_dur editor = #n_dur editor
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_dur editor *= 16 const
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_dur editor /= note_speed options
# 混凝土段判定游标（对齐游玩：段 k 结束 rel=min(k×density, dur)，k=1..seg_count）
# 播放生成（playhead<time 出生中）→ seg=1（首段结束 time+density）逐段+1；seek 生成（playhead≥time）→ seg=ceil((playhead-time)/density) 至少 1
scoreboard players operation #seg_calc editor = #playhead editor
scoreboard players operation #seg_calc editor -= #n_time editor
scoreboard players operation #seg_rem editor = #seg_calc editor
scoreboard players operation #seg_rem editor %= #n_density editor
scoreboard players operation #seg_calc editor /= #n_density editor
execute if score #seg_rem editor matches 1.. run scoreboard players add #seg_calc editor 1
execute if score #seg_calc editor matches ..0 run scoreboard players set #seg_calc editor 1
# seg_count = ceil(dur/density)（最后一段 rel=dur 出窗判定；段结束时刻 min(k×density, dur)）
scoreboard players operation #seg_cnt editor = #n_dur editor
scoreboard players operation #seg_cnt editor += #n_density editor
scoreboard players operation #seg_cnt editor -= 1 const
scoreboard players operation #seg_cnt editor /= #n_density editor
# 玻璃段①时长也随流速缩放（×16/note_speed，ignore 除外）→ 与游玩 note_c_lt 一致；
#   s2 终点 dist×dur/lt 因 dur、lt 同缩而抵消不变
scoreboard players operation #glass_lt editor = #n_lt editor
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_lt editor *= 16 const
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_lt editor /= note_speed options
# ===== 一次性填充展示实体全部字段（1 次选择器）→ 再按当前 playhead 定位（统一 place）=====
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run function rhythm_axe:editor/visual/fill_disp
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run function rhythm_axe:editor/visual/place
