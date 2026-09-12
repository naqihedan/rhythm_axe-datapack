#arg:cursor,i,min,max
# 单个音符判定（命中则打 selected:1b + 计数；黄光/标记只对当前存活的实体生效）：
#   ① 判定时间 time 落在 [min,max] 内（含两端）；或者
#   ② 长音符（**仅混凝土** type 3，且 duration ≥ 1）的自家跨度 [time, time+duration-1]
#      与选择区间有交集 —— 否则「判定时间在区间外、但持续时间延伸进区间」的混凝土会选不到
$execute store result score #ts_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
# 跨度末端（默认 = time，长音符再往后加 duration-1）
scoreboard players set #ts_end editor 0
scoreboard players operation #ts_end editor = #ts_time editor
scoreboard players set #ts_hit editor 0
$execute if score #ts_time editor matches $(min)..$(max) run scoreboard players set #ts_hit editor 1
$execute store result score #ts_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type
scoreboard players set #ts_dur editor 0
$execute store result score #ts_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].duration
execute if score #ts_type editor matches 3 if score #ts_dur editor matches 1.. run scoreboard players operation #ts_end editor += #ts_dur editor
execute if score #ts_type editor matches 3 if score #ts_dur editor matches 1.. run scoreboard players remove #ts_end editor 1
# 区间交集判定（用驱动器已算好的 #ts_min/#ts_max）：time ≤ max 且 跨度末端 ≥ min
execute if score #ts_time editor <= #ts_max editor if score #ts_end editor >= #ts_min editor run scoreboard players set #ts_hit editor 1
execute if score #ts_hit editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #ts_i editor
$execute if score #ts_hit editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #ts_hit editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/tool/select/time_select_tag with storage rhythm_axe:prop
