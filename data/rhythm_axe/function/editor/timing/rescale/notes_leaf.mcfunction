#arg:cursor,i
# 单个音符缩放（宏叶子，不递归）
#   判定时间 time      → f(t)（段内按比例、段后平移；单调 ⇒ notes[] 顺序不变）
#   长条持续 duration  → ×ratio（段内 + 【长条时长】开关；混凝土 ≥1 / 玻璃 ≥0）
#   判定密度 density   → ×ratio（段内 + 【长条时长】开关；仅混凝土，≥1）
#   基础寿命 base_life → ×ratio（段内 + 【飞行时长】开关；≥1）
# 缺字段按谱面默认值兜底：duration 混凝土 8 / 玻璃 3、density 8、note_base_life 24
#
# ⚠️⚠️ 本文件**绝对不能出现 return**（2026-10-29 实测踩坑）：
#   `/return` 会终止**整条函数调用栈**，连调用它的 notes_drive 递归一起砍掉
#   ⇒ 表现为「#rs_i 不推进 / 永不越界 / 死循环」。
#   越界时置 #rs_done=1，后续所有行靠 `if score #rs_done editor matches 0` 守卫跳过。
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type run scoreboard players set #rs_done editor 0
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type run scoreboard players set #rs_done editor 1

# 类型（缺省 0 = 音符盒）
execute if score #rs_done editor matches 0 run scoreboard players set #rs_ntype editor 0
$execute if score #rs_done editor matches 0 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type run execute store result score #rs_ntype editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type

# ── 判定时间 ──
$execute if score #rs_done editor matches 0 run execute store result score #rs_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
execute if score #rs_done editor matches 0 run function rhythm_axe:editor/timing/rescale/fval
# 段内标记（duration/density/note_base_life 只在「以 a 为起点的那一段」内缩放）
execute if score #rs_done editor matches 0 run scoreboard players set #rs_inseg editor 0
execute if score #rs_done editor matches 0 if score #rs_t editor >= #rs_a editor unless score #rs_use_delta editor matches 1 run scoreboard players set #rs_inseg editor 1
# 判定时间写回（没变就不写；不能早退——段起点那个音符 time 不变但时长仍要缩）
$execute if score #rs_done editor matches 0 unless score #rs_ft editor = #rs_t editor run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time int 1 run scoreboard players get #rs_ft editor
execute if score #rs_done editor matches 0 unless score #rs_ft editor = #rs_t editor run scoreboard players add #rs_count editor 1

# ── 长条持续 + 判定密度（段内、混凝土/玻璃、开关开）──
execute if score #rs_done editor matches 0 run scoreboard players set #rs_do_hold editor 0
execute if score #rs_done editor matches 0 if score #rs_inseg editor matches 1 if score editor_scale_hold options matches 1 if score #rs_ntype editor matches 3..4 run scoreboard players set #rs_do_hold editor 1

# duration：缺省 混凝土 8 / 玻璃 3
execute if score #rs_do_hold editor matches 1 run scoreboard players set #rs_v editor 0
$execute if score #rs_do_hold editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].duration run execute store result score #rs_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].duration
execute if score #rs_do_hold editor matches 1 if score #rs_v editor matches ..0 if score #rs_ntype editor matches 3 run scoreboard players set #rs_v editor 8
execute if score #rs_do_hold editor matches 1 if score #rs_v editor matches ..0 if score #rs_ntype editor matches 4 run scoreboard players set #rs_v editor 3
execute if score #rs_do_hold editor matches 1 run scoreboard players operation #rs_off editor = #rs_v editor
execute if score #rs_do_hold editor matches 1 run function rhythm_axe:editor/timing/rescale/scale
# 混凝土下限 1（玻璃 duration=0 = 不延伸，合法）
execute if score #rs_do_hold editor matches 1 if score #rs_ntype editor matches 3 if score #rs_out editor matches ..0 run scoreboard players set #rs_out editor 1
$execute if score #rs_do_hold editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].duration int 1 run scoreboard players get #rs_out editor

# density：缺省 8，仅混凝土
execute if score #rs_do_hold editor matches 1 if score #rs_ntype editor matches 3 run scoreboard players set #rs_do_den editor 1
execute unless score #rs_do_hold editor matches 1 run scoreboard players set #rs_do_den editor 0
execute if score #rs_do_hold editor matches 1 unless score #rs_ntype editor matches 3 run scoreboard players set #rs_do_den editor 0
execute if score #rs_do_den editor matches 1 run scoreboard players set #rs_v editor 0
$execute if score #rs_do_den editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].density run execute store result score #rs_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].density
execute if score #rs_do_den editor matches 1 if score #rs_v editor matches ..0 run scoreboard players set #rs_v editor 8
execute if score #rs_do_den editor matches 1 run scoreboard players operation #rs_off editor = #rs_v editor
execute if score #rs_do_den editor matches 1 run function rhythm_axe:editor/timing/rescale/scale
execute if score #rs_do_den editor matches 1 if score #rs_out editor matches ..0 run scoreboard players set #rs_out editor 1
$execute if score #rs_do_den editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].density int 1 run scoreboard players get #rs_out editor

# ── 基础寿命（段内 + 【飞行时长】开关；缺省 24，下限 1）──
execute if score #rs_done editor matches 0 if score #rs_inseg editor matches 1 if score editor_scale_life options matches 1 run scoreboard players set #rs_do_bl editor 1
execute unless score #rs_done editor matches 0 run scoreboard players set #rs_do_bl editor 0
execute if score #rs_done editor matches 0 unless score #rs_inseg editor matches 1 run scoreboard players set #rs_do_bl editor 0
execute if score #rs_done editor matches 0 unless score editor_scale_life options matches 1 run scoreboard players set #rs_do_bl editor 0
execute if score #rs_do_bl editor matches 1 run scoreboard players set #rs_v editor 0
$execute if score #rs_do_bl editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].note_base_life run execute store result score #rs_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].note_base_life
execute if score #rs_do_bl editor matches 1 if score #rs_v editor matches ..0 run scoreboard players set #rs_v editor 24
execute if score #rs_do_bl editor matches 1 run scoreboard players operation #rs_off editor = #rs_v editor
execute if score #rs_do_bl editor matches 1 run function rhythm_axe:editor/timing/rescale/scale
execute if score #rs_do_bl editor matches 1 if score #rs_out editor matches ..0 run scoreboard players set #rs_out editor 1
$execute if score #rs_do_bl editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].note_base_life int 1 run scoreboard players get #rs_out editor
