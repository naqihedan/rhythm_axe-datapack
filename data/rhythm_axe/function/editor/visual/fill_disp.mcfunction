# 展示实体字段填充：@s = 刚生成的 editor_n_<nid> item_display（由 summon_ 调用）
# ★ 2026-09-14 性能重构（O(n²) → O(n)）：
#   原先对同一个展示实体要用约 36 条 `@e[tag=editor_n_$(nid),type=item_display,limit=1]` 命令，
#   每条选择器都要遍历全世界实体（≈ 存活音符数 × 2：item_display + interaction）。
#   n 个音符 → 配置成本 ∝ n²，977 音符时单次全量 refresh ≈ 260ms（中段插入 / 快进快退都走 refresh）。
#   现改为：调用方 1 次选择器 + 本函数内全部 @s ⇒ 每个音符 36 次扫描 → 1 次。
# ★ 本文件【不得】出现宏行（$ 开头）：调用方用普通 function 调用，零宏展开开销。
# 前置（调用方已算好）：
#   display_calc：#c_yaw #c_pitch #nsz #L100 #note_dist
#   editor：#note_type #n_color #n_time #n_birth #n_end #n_type #n_density
#           #glass_dur #glass_lt #seg_calc #seg_cnt #n_easing #n_power #playhead
#   storage rhythm_axe:prop：nid pos_x pos_y pos_z start_x start_y start_z size color hitsound hit_particles idx

# ===== 判定位置 + 朝向 =====
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop pos_x 100
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #fd_tmp editor
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop pos_y 100
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #fd_tmp editor
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop pos_z 100
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #fd_tmp editor
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get #c_yaw display_calc
execute store result entity @s Rotation[1] float 0.01 run scoreboard players get #c_pitch display_calc

# ===== 外观：类型 → 物品 id（分支短路，无实体扫描）=====
execute if score #note_type play_state matches 0 run data modify entity @s item.id set value "minecraft:note_block"
execute if score #note_type play_state matches 1 run data modify entity @s item.id set value "minecraft:birch_planks"
execute if score #note_type play_state matches 2 run data modify entity @s item.id set value "minecraft:jukebox"
# 染色玻璃：color 1~16（默认 6=红色）
execute if score #note_type play_state matches 4 if score #n_color editor matches 1 run data modify entity @s item.id set value "minecraft:white_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 2 run data modify entity @s item.id set value "minecraft:gray_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 3 run data modify entity @s item.id set value "minecraft:light_gray_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 4 run data modify entity @s item.id set value "minecraft:black_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 5 run data modify entity @s item.id set value "minecraft:brown_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 6 run data modify entity @s item.id set value "minecraft:red_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 7 run data modify entity @s item.id set value "minecraft:orange_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 8 run data modify entity @s item.id set value "minecraft:yellow_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 9 run data modify entity @s item.id set value "minecraft:lime_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 10 run data modify entity @s item.id set value "minecraft:green_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 11 run data modify entity @s item.id set value "minecraft:cyan_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 12 run data modify entity @s item.id set value "minecraft:light_blue_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 13 run data modify entity @s item.id set value "minecraft:blue_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 14 run data modify entity @s item.id set value "minecraft:purple_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 15 run data modify entity @s item.id set value "minecraft:magenta_stained_glass"
execute if score #note_type play_state matches 4 if score #n_color editor matches 16 run data modify entity @s item.id set value "minecraft:pink_stained_glass"
execute if score #note_type play_state matches 4 unless score #n_color editor matches 1..16 run data modify entity @s item.id set value "minecraft:red_stained_glass"
# 混凝土：color 1~16（默认 9=黄绿）
execute if score #note_type play_state matches 3 if score #n_color editor matches 1 run data modify entity @s item.id set value "minecraft:white_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 2 run data modify entity @s item.id set value "minecraft:gray_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 3 run data modify entity @s item.id set value "minecraft:light_gray_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 4 run data modify entity @s item.id set value "minecraft:black_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 5 run data modify entity @s item.id set value "minecraft:brown_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 6 run data modify entity @s item.id set value "minecraft:red_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 7 run data modify entity @s item.id set value "minecraft:orange_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 8 run data modify entity @s item.id set value "minecraft:yellow_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 9 run data modify entity @s item.id set value "minecraft:lime_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 10 run data modify entity @s item.id set value "minecraft:green_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 11 run data modify entity @s item.id set value "minecraft:cyan_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 12 run data modify entity @s item.id set value "minecraft:light_blue_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 13 run data modify entity @s item.id set value "minecraft:blue_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 14 run data modify entity @s item.id set value "minecraft:purple_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 15 run data modify entity @s item.id set value "minecraft:magenta_concrete"
execute if score #note_type play_state matches 3 if score #n_color editor matches 16 run data modify entity @s item.id set value "minecraft:pink_concrete"
execute if score #note_type play_state matches 3 unless score #n_color editor matches 1..16 run data modify entity @s item.id set value "minecraft:lime_concrete"

# ===== 缩放 = size（x/y/z 统一）=====
execute store result entity @s transformation.scale[0] float 0.01 run scoreboard players get #nsz display_calc
execute store result entity @s transformation.scale[1] float 0.01 run scoreboard players get #nsz display_calc
execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #nsz display_calc
# 混凝土长条全长（×100，#L100 由 summon_ 算）= scale[2] 拉伸
execute if score #note_type play_state matches 3 run execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #L100 display_calc
execute if score #note_type play_state matches 3 run scoreboard players operation @s editor_n_len = #L100 display_calc

# ===== 计分板参数（place / 播放 tick 清理 / 判定用）=====
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop nid
scoreboard players operation @s note_id = #fd_tmp editor
scoreboard players operation @s editor_n_birth = #n_birth editor
scoreboard players operation @s editor_n_time = #n_time editor
scoreboard players operation @s editor_n_end = #n_end editor
scoreboard players operation @s editor_n_dist = #note_dist display_calc
scoreboard players operation @s editor_n_type = #n_type editor
scoreboard players operation @s editor_n_dur = #glass_dur editor
scoreboard players operation @s editor_n_density = #n_density editor
# 混凝土段判定游标（对齐游玩：段 k 结束 rel=min(k×density, dur)，k=1..seg_count）
# 播放生成（playhead<time 出生中）→ seg=1（首段结束 time+density）逐段+1；seek 生成（playhead≥time）→ seg=ceil((playhead-time)/density) 至少 1
execute if score #note_type play_state matches 3 if score #playhead editor < #n_time editor run scoreboard players set @s editor_n_seg 1
execute if score #note_type play_state matches 3 if score #playhead editor >= #n_time editor run scoreboard players operation @s editor_n_seg = #seg_calc editor
execute if score #note_type play_state matches 3 run scoreboard players operation @s editor_n_seg_count = #seg_cnt editor
# 玻璃段①时长也随流速缩放（×16/note_speed，ignore 除外；#glass_lt 由 summon_ 算）
scoreboard players operation @s editor_n_lt = #glass_lt editor
scoreboard players operation @s editor_n_easing = #n_easing editor
scoreboard players operation @s editor_n_power = #n_power editor
# 击打反馈参数与音符下标（trigger 播放击打音效/粒子/执行 hit_events 用）
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop hitsound
scoreboard players operation @s note_hitsound = #fd_tmp editor
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop hit_particles
scoreboard players operation @s note_hit_particles = #fd_tmp editor
# 音符颜色（混凝土默认组3动态破坏粒子用；缺省 0）
scoreboard players set @s note_color 0
execute if data storage rhythm_axe:prop color run execute store result score @s note_color run data get storage rhythm_axe:prop color
execute store result score #fd_tmp editor run data get storage rhythm_axe:prop idx
scoreboard players operation @s editor_n_idx = #fd_tmp editor
# 判定位置与起始偏移（place 算交互实体世界坐标用；×1000）
execute store result score @s editor_n_px run data get storage rhythm_axe:prop pos_x 1000
execute store result score @s editor_n_py run data get storage rhythm_axe:prop pos_y 1000
execute store result score @s editor_n_pz run data get storage rhythm_axe:prop pos_z 1000
execute store result score @s editor_n_sx run data get storage rhythm_axe:prop start_x 1000
execute store result score @s editor_n_sy run data get storage rhythm_axe:prop start_y 1000
execute store result score @s editor_n_sz run data get storage rhythm_axe:prop start_z 1000
# size×1000：交互实体 Y 定位需减 size/2（interaction 在方块底部，展示实体中心在判定 Y 处）
execute store result score @s editor_n_size run data get storage rhythm_axe:prop size 1000
