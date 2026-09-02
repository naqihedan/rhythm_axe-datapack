# 创建音符：前置 prop.time（判定时间刻）、prop.type（0-4）
# 可选 prop：position_x/y/z（缺省取执行者位置）、start_x/y/z（缺省 0）、size、duration、color、density、
#           note_base_life、anim_easing、anim_power、hitsound、hit_particles、following_point、custom_tag

# 音符按 time 升序插入 notes，id 从 next_note_id 分配；操作快照由 begin/commit 管理
execute unless data storage rhythm_axe:prop time run tellraw @s [{"text":"[编辑器] 缺少时间（prop.time）","color":"red"}]
execute unless data storage rhythm_axe:prop time run return fail

execute unless data storage rhythm_axe:prop type run tellraw @s [{"text":"[编辑器] 缺少类型（prop.type）","color":"red"}]
execute unless data storage rhythm_axe:prop type run return fail

execute store result score #note_type editor run data get storage rhythm_axe:prop type
execute unless score #note_type editor matches 0..4 run tellraw @s [{"text":"[编辑器] 音符类型无效（0-4）","color":"red"}]
execute unless score #note_type editor matches 0..4 run return fail

function rhythm_axe:editor/file/begin
# 撤销标签：创建{音符种类}
execute store result score #temp editor run data get storage rhythm_axe:prop type
execute if score #temp editor matches 0 run data modify storage rhythm_axe:maps.editor op_label set value "创建音符盒"
execute if score #temp editor matches 1 run data modify storage rhythm_axe:maps.editor op_label set value "创建木板"
execute if score #temp editor matches 2 run data modify storage rhythm_axe:maps.editor op_label set value "创建唱片机"
execute if score #temp editor matches 3 run data modify storage rhythm_axe:maps.editor op_label set value "创建混凝土"
execute if score #temp editor matches 4 run data modify storage rhythm_axe:maps.editor op_label set value "创建染色玻璃"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor

# 默认值组装（调用方已提供的键不覆盖）
execute unless data storage rhythm_axe:prop position_x run data modify storage rhythm_axe:prop position_x set from entity @s Pos[0]
execute unless data storage rhythm_axe:prop position_y run data modify storage rhythm_axe:prop position_y set from entity @s Pos[1]
execute unless data storage rhythm_axe:prop position_z run data modify storage rhythm_axe:prop position_z set from entity @s Pos[2]
execute unless data storage rhythm_axe:prop start_x run data modify storage rhythm_axe:prop start_x set value 0.0d
execute unless data storage rhythm_axe:prop start_y run data modify storage rhythm_axe:prop start_y set value 0.0d
execute unless data storage rhythm_axe:prop start_z run data modify storage rhythm_axe:prop start_z set value 24.0d
execute unless data storage rhythm_axe:prop size run data modify storage rhythm_axe:prop size set value 1.0f
execute unless data storage rhythm_axe:prop note_base_life run data modify storage rhythm_axe:prop note_base_life set value 24
execute unless data storage rhythm_axe:prop anim_easing run data modify storage rhythm_axe:prop anim_easing set value 1
execute unless data storage rhythm_axe:prop anim_power run data modify storage rhythm_axe:prop anim_power set value 1
execute unless data storage rhythm_axe:prop hitsound run execute store result storage rhythm_axe:prop hitsound int 1 run scoreboard players get #note_type editor
execute unless data storage rhythm_axe:prop hit_particles run execute store result storage rhythm_axe:prop hit_particles int 1 run scoreboard players get #note_type editor
execute unless data storage rhythm_axe:prop following_point run data modify storage rhythm_axe:prop following_point set value 0b
execute unless data storage rhythm_axe:prop custom_tag run data modify storage rhythm_axe:prop custom_tag set value ""

execute if score #note_type editor matches 3 unless data storage rhythm_axe:prop duration run data modify storage rhythm_axe:prop duration set value 8
execute if score #note_type editor matches 4 unless data storage rhythm_axe:prop duration run data modify storage rhythm_axe:prop duration set value 8
execute if score #note_type editor matches 0..2 unless data storage rhythm_axe:prop duration run data modify storage rhythm_axe:prop duration set value 0
execute if score #note_type editor matches 3 unless data storage rhythm_axe:prop color run data modify storage rhythm_axe:prop color set value 9b
execute if score #note_type editor matches 4 unless data storage rhythm_axe:prop color run data modify storage rhythm_axe:prop color set value 6b
execute if score #note_type editor matches 0..2 unless data storage rhythm_axe:prop color run data modify storage rhythm_axe:prop color set value 0b
execute if score #note_type editor matches 3 unless data storage rhythm_axe:prop density run data modify storage rhythm_axe:prop density set value 8
execute if score #note_type editor matches 4 unless data storage rhythm_axe:prop density run data modify storage rhythm_axe:prop density set value 0
execute if score #note_type editor matches 0..2 unless data storage rhythm_axe:prop density run data modify storage rhythm_axe:prop density set value 0

# 类型规范化（宏展开时输出带正确 NBT 后缀；Float/Double 用 data modify 保留原类型——26.x store result storage 会截断小数 0.5→0）
execute store result storage rhythm_axe:prop type byte 1 run data get storage rhythm_axe:prop type
data modify storage rhythm_axe:prop size set from storage rhythm_axe:prop size
execute store result storage rhythm_axe:prop following_point byte 1 run data get storage rhythm_axe:prop following_point
execute store result storage rhythm_axe:prop color byte 1 run data get storage rhythm_axe:prop color
data modify storage rhythm_axe:prop position_x set from storage rhythm_axe:prop position_x
data modify storage rhythm_axe:prop position_y set from storage rhythm_axe:prop position_y
data modify storage rhythm_axe:prop position_z set from storage rhythm_axe:prop position_z
data modify storage rhythm_axe:prop start_x set from storage rhythm_axe:prop start_x
data modify storage rhythm_axe:prop start_y set from storage rhythm_axe:prop start_y
data modify storage rhythm_axe:prop start_z set from storage rhythm_axe:prop start_z
execute store result storage rhythm_axe:prop duration int 1 run data get storage rhythm_axe:prop duration
execute store result storage rhythm_axe:prop density int 1 run data get storage rhythm_axe:prop density
execute store result storage rhythm_axe:prop note_base_life int 1 run data get storage rhythm_axe:prop note_base_life
execute store result storage rhythm_axe:prop anim_easing int 1 run data get storage rhythm_axe:prop anim_easing
execute store result storage rhythm_axe:prop anim_power int 1 run data get storage rhythm_axe:prop anim_power
execute store result storage rhythm_axe:prop hitsound int 1 run data get storage rhythm_axe:prop hitsound
execute store result storage rhythm_axe:prop hit_particles int 1 run data get storage rhythm_axe:prop hit_particles

# 分配 id
execute store result score #new_id editor run data get storage rhythm_axe:maps.editor next_note_id
execute store result storage rhythm_axe:prop new_id int 1 run scoreboard players get #new_id editor
scoreboard players add #new_id editor 1
execute store result storage rhythm_axe:maps.editor next_note_id int 1 run scoreboard players get #new_id editor

# 按 time 升序插入
data modify storage rhythm_axe:prop list_name set value "notes"
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop time
execute store result storage rhythm_axe:prop new_time int 1 run data get storage rhythm_axe:prop new_time
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"append"} run function rhythm_axe:editor/note/create/create_append with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"insert"} run function rhythm_axe:editor/note/create/create_insert with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh

# 清理 prop
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop type
data remove storage rhythm_axe:prop position_x
data remove storage rhythm_axe:prop position_y
data remove storage rhythm_axe:prop position_z
data remove storage rhythm_axe:prop start_x
data remove storage rhythm_axe:prop start_y
data remove storage rhythm_axe:prop start_z
data remove storage rhythm_axe:prop size
data remove storage rhythm_axe:prop duration
data remove storage rhythm_axe:prop color
data remove storage rhythm_axe:prop density
data remove storage rhythm_axe:prop note_base_life
data remove storage rhythm_axe:prop anim_easing
data remove storage rhythm_axe:prop anim_power
data remove storage rhythm_axe:prop hitsound
data remove storage rhythm_axe:prop hit_particles
data remove storage rhythm_axe:prop following_point
data remove storage rhythm_axe:prop custom_tag
data remove storage rhythm_axe:prop new_id
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop cursor
