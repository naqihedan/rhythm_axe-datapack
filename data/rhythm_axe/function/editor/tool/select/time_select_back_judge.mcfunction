#arg:cursor,i
# 反向命中判定（#ts_i 之前的音符，time < min）：只有**混凝土**（type 3，duration ≥ 1）可能
#   「判定时间在区间外、但持续时间延伸进区间」→ 自己的跨度末端 time+duration-1 ≥ min 就命中
# 早退上界：#ts_maxdur = 本次反向扫描已见的最大混凝土时长 → 更早音符的末端 ≤ time + #ts_maxdur - 1，
#   该上界 < min 时置 #ts_stop=1，驱动器立即停（notes 按 time 升序，更早的 time 只会更小）
$execute store result score #ts_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
$execute store result score #ts_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type
scoreboard players set #ts_dur editor 0
$execute store result score #ts_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].duration
execute if score #ts_type editor matches 3 if score #ts_dur editor > #ts_maxdur editor run scoreboard players operation #ts_maxdur editor = #ts_dur editor
# 本音符自己的跨度末端（非混凝土 = 判定时间，不会命中）
scoreboard players set #ts_end editor 0
scoreboard players operation #ts_end editor = #ts_time editor
execute if score #ts_type editor matches 3 if score #ts_dur editor matches 1.. run scoreboard players operation #ts_end editor += #ts_dur editor
execute if score #ts_type editor matches 3 if score #ts_dur editor matches 1.. run scoreboard players remove #ts_end editor 1
scoreboard players set #ts_hit editor 0
execute if score #ts_type editor matches 3 if score #ts_dur editor matches 1.. if score #ts_end editor >= #ts_min editor run scoreboard players set #ts_hit editor 1
# 早退上界（time + 已见最大时长 - 1）
scoreboard players set #ts_stop editor 0
scoreboard players operation #ts_ub editor = #ts_time editor
scoreboard players operation #ts_ub editor += #ts_maxdur editor
scoreboard players remove #ts_ub editor 1
execute if score #ts_ub editor < #ts_min editor run scoreboard players set #ts_stop editor 1
# 命中收尾（与正向一致：打 selected:1b + 计数 + 活着的实体补黄光/标记）
execute if score #ts_hit editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #ts_j editor
$execute if score #ts_hit editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #ts_hit editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/tool/select/time_select_tag with storage rhythm_axe:prop
