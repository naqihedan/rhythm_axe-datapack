# 生成编辑器音符的一对实体（宏参数：nid,pos_x,pos_y,pos_z,start_x,start_y,start_z,size,type,color,lt,dur,prog1000,easing,power,hitsound,hit_particles,idx）
# 与游玩视觉一致：判定位置 = (pos_x,pos_y,pos_z)；当前位置按 playhead 由 place 统一计算（局部 z）
# 朝向 = 实体 Rotation（yaw/pitch）朝运动方向（dir = -start_pos）
# tag 与游玩隔离：editor_note（统一清理）+ editor_n_<nid>（唯一定位）
#arg: nid,pos_x,pos_y,pos_z,start_x,start_y,start_z,size,type,color,lt,dur,prog1000,easing,power,density,hitsound,hit_particles,idx

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

# ===== 展示实体（先 summon 到原点，再精确写 Pos/translation）=====
$summon item_display 0.0 0.0 0.0 {item:{id:"minecraft:note_block",count:1},Tags:["editor_note","editor_n_$(nid)"],brightness:{block:15,sky:15},transformation:{translation:[0.0,0.0,0.0],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
# ★ 2026-08-25 用 data modify set from 写 Pos（26.x 对实体 Pos 的 store result 写入实测失效，Pos 留在 0）
$data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] Pos[0] set from storage rhythm_axe:prop pos_x
$data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] Pos[1] set from storage rhythm_axe:prop pos_y
$data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] Pos[2] set from storage rhythm_axe:prop pos_z
# 朝向写实体 Rotation（不入 transformation，不受插值影响）
$execute store result entity @e[tag=editor_n_$(nid),type=item_display,limit=1] Rotation[0] float 0.01 run scoreboard players get #c_yaw display_calc
$execute store result entity @e[tag=editor_n_$(nid),type=item_display,limit=1] Rotation[1] float 0.01 run scoreboard players get #c_pitch display_calc
# ===== 外观：类型→物品 + 类型 tag =====
execute store result score #note_type play_state run data get storage rhythm_axe:prop type
$execute if score #note_type play_state matches 0 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:note_block"
$execute if score #note_type play_state matches 1 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:birch_planks"
$execute if score #note_type play_state matches 2 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:jukebox"
# 染色玻璃：color 1~16（文档颜色表；默认 6=红色）
$execute if score #note_type play_state matches 4 if score #n_color editor matches 1 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:white_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 2 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:gray_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 3 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:light_gray_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 4 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:black_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 5 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:brown_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 6 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:red_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 7 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:orange_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 8 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:yellow_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 9 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:lime_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 10 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:green_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 11 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:cyan_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 12 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:light_blue_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 13 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:blue_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 14 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:purple_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 15 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:magenta_stained_glass"
$execute if score #note_type play_state matches 4 if score #n_color editor matches 16 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:pink_stained_glass"
$execute if score #note_type play_state matches 4 unless score #n_color editor matches 1..16 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:red_stained_glass"
# 混凝土：color 1~16（默认 9=黄绿）
$execute if score #note_type play_state matches 3 if score #n_color editor matches 1 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:white_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 2 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:gray_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 3 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:light_gray_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 4 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:black_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 5 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:brown_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 6 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:red_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 7 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:orange_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 8 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:yellow_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 9 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:lime_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 10 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:green_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 11 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:cyan_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 12 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:light_blue_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 13 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:blue_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 14 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:purple_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 15 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:magenta_concrete"
$execute if score #note_type play_state matches 3 if score #n_color editor matches 16 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:pink_concrete"
$execute if score #note_type play_state matches 3 unless score #n_color editor matches 1..16 run data modify entity @e[tag=editor_n_$(nid),type=item_display,limit=1] item.id set value "minecraft:lime_concrete"
# 音符命名：{类型}_{id}
$execute if score #note_type play_state matches 0 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"音符盒_$(nid)"}}
$execute if score #note_type play_state matches 1 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"木板_$(nid)"}}
$execute if score #note_type play_state matches 2 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"唱片机_$(nid)"}}
$execute if score #note_type play_state matches 3 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"混凝土_$(nid)"}}
$execute if score #note_type play_state matches 4 run data merge entity @e[tag=editor_n_$(nid),type=item_display,limit=1] {CustomName:{"text":"染色玻璃_$(nid)"}}
# 缩放 = size（x/y/z 统一）
$execute store result entity @e[tag=editor_n_$(nid),type=item_display,limit=1] transformation.scale[0] float 0.01 run data get storage rhythm_axe:prop size 100
$execute store result entity @e[tag=editor_n_$(nid),type=item_display,limit=1] transformation.scale[1] float 0.01 run data get storage rhythm_axe:prop size 100
$execute store result entity @e[tag=editor_n_$(nid),type=item_display,limit=1] transformation.scale[2] float 0.01 run data get storage rhythm_axe:prop size 100
# 混凝土长条全长（×100）：短 hold = dist×dur/lt；长 hold = dist+size（尾端起点往回退 size/2 → 头端到位 s/2 需多走 size）
# ★ 2026-08-26：短 hold 同游玩（dist×dur/lt）；长 hold 因尾端起点 = -d-s/2、头端终点 = s/2，全长 = d+s
scoreboard players operation #L100 display_calc = #note_dist display_calc
execute if score #note_type play_state matches 3 if score #n_dur editor <= #n_lt editor run scoreboard players operation #L100 display_calc *= #n_dur editor
execute if score #note_type play_state matches 3 if score #n_dur editor <= #n_lt editor run scoreboard players operation #L100 display_calc /= #n_lt editor
execute if score #note_type play_state matches 3 if score #n_dur editor > #n_lt editor run execute store result score #sz100 display_calc run data get storage rhythm_axe:prop size 100
execute if score #note_type play_state matches 3 if score #n_dur editor > #n_lt editor run scoreboard players operation #L100 display_calc += #sz100 display_calc
$execute if score #note_type play_state matches 3 run execute store result entity @e[tag=editor_n_$(nid),type=item_display,limit=1] transformation.scale[2] float 0.01 run scoreboard players get #L100 display_calc
# 混凝土全长（×100）存实体（place 分段拉伸用）
$execute if score #note_type play_state matches 3 run execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_len = #L100 display_calc

# ===== 交互实体（重现只看不碰；为后续编辑交互预留）=====
$summon interaction $(pos_x) $(pos_y) $(pos_z) {width:1f,height:1f,response:true,Tags:["editor_note","editor_n_$(nid)"]}
$execute store result entity @e[tag=editor_n_$(nid),type=interaction,limit=1] width float 0.01 run data get storage rhythm_axe:prop size 100
$execute store result entity @e[tag=editor_n_$(nid),type=interaction,limit=1] height float 0.01 run data get storage rhythm_axe:prop size 100
# 交互实体记 note_id（后续编辑交互用）
$execute as @e[tag=editor_n_$(nid),type=interaction,limit=1] run scoreboard players set @s note_id $(nid)

# ===== 存储移动参数到展示实体（place 统一计算位置 + 播放 tick 清理用）=====
# note_id：唯一 id；editor_n_birth/time/end：出生/判定/消失虚拟时刻；editor_n_dist：dist×100
# editor_n_type：类型；editor_n_dur/lt：duration/note_base_life；editor_n_easing/power：缓动参数；editor_n_len：混凝土长条全长×100
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players set @s note_id $(nid)
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_birth = #n_birth editor
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_time = #n_time editor
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_end = #n_end editor
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_dist = #note_dist display_calc
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_type = #n_type editor
# 玻璃（4）穿过后段时长随流速缩放（×16/note_speed，ignore 除外）→ 与游玩 note_glass_dur 一致
scoreboard players operation #glass_dur editor = #n_dur editor
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_dur editor *= 16 const
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_dur editor /= note_speed options
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_dur = #glass_dur editor
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_density = #n_density editor
# 混凝土段判定游标（对齐游玩：段 k 结束 rel=min(k×density, dur)，k=1..seg_count）
# 播放生成（playhead<time 出生中）→ seg=1（首段结束 time+density）逐段+1；seek 生成（playhead≥time）→ seg=ceil((playhead-time)/density) 至少 1
scoreboard players operation #seg_calc editor = #playhead editor
scoreboard players operation #seg_calc editor -= #n_time editor
scoreboard players operation #seg_rem editor = #seg_calc editor
scoreboard players operation #seg_rem editor %= #n_density editor
scoreboard players operation #seg_calc editor /= #n_density editor
execute if score #seg_rem editor matches 1.. run scoreboard players add #seg_calc editor 1
execute if score #seg_calc editor matches ..0 run scoreboard players set #seg_calc editor 1
$execute if score #note_type play_state matches 3 if score #playhead editor < #n_time editor run execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players set @s editor_n_seg 1
$execute if score #note_type play_state matches 3 if score #playhead editor >= #n_time editor run execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_seg = #seg_calc editor
# seg_count = ceil(dur/density)（最后一段 rel=dur 出窗判定；段结束时刻 min(k×density, dur)）
scoreboard players operation #seg_cnt editor = #n_dur editor
scoreboard players operation #seg_cnt editor += #n_density editor
scoreboard players operation #seg_cnt editor -= 1 const
scoreboard players operation #seg_cnt editor /= #n_density editor
$execute if score #note_type play_state matches 3 run execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_seg_count = #seg_cnt editor
# 玻璃段①时长也随流速缩放（×16/note_speed，ignore 除外）→ 与游玩 note_c_lt 一致；
#   s2 终点 dist×dur/lt 因 dur、lt 同缩而抵消不变
scoreboard players operation #glass_lt editor = #n_lt editor
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_lt editor *= 16 const
execute if score #note_type play_state matches 4 unless data storage rhythm_axe:prop ignore_speed run scoreboard players operation #glass_lt editor /= note_speed options
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_lt = #glass_lt editor
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_easing = #n_easing editor
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players operation @s editor_n_power = #n_power editor
# 存击打反馈参数与音符下标（trigger 播放击打音效/粒子/执行 hit_events 用）
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players set @s note_hitsound $(hitsound)
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players set @s note_hit_particles $(hit_particles)
# 存音符颜色（混凝土默认组3动态破坏粒子用；缺省 0）
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players set @s note_color 0
$execute if data storage rhythm_axe:prop color run execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s note_color run data get storage rhythm_axe:prop color
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run scoreboard players set @s editor_n_idx $(idx)
# 判定位置与起始偏移（place 算交互实体世界坐标用；double ×1000）
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_px run data get storage rhythm_axe:prop pos_x 1000
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_py run data get storage rhythm_axe:prop pos_y 1000
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_pz run data get storage rhythm_axe:prop pos_z 1000
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_sx run data get storage rhythm_axe:prop start_x 1000
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_sy run data get storage rhythm_axe:prop start_y 1000
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_sz run data get storage rhythm_axe:prop start_z 1000
# 存 size×1000：交互实体 Y 定位需减 size/2（interaction 在方块底部，展示实体中心在判定 Y 处）
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run execute store result score @s editor_n_size run data get storage rhythm_axe:prop size 1000
# 生成后立即按当前 playhead 定位（统一 place）
$execute as @e[tag=editor_n_$(nid),type=item_display,limit=1] run function rhythm_axe:editor/visual/place
