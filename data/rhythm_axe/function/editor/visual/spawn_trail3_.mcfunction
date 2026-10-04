# 窗口化辅助：统计 type 3/4（混凝土 / 染色玻璃）的「尾长」= end − time，累加到 #vis_trail_max
#   用途：refresh 窗口化的**下界缓存** —— 判断「time < playhead − 尾长上界 ⇒ 该音符必定已消失」，可整段跳过。
#   type 0..2 的尾长由调用方（refresh）用「3x+1」兜底，不需要逐个统计。
#   前置：prop.note = 当前音符元素（spawn_one_ 已复制）、#n_type / #n_time 已读；
#         调用方用 `execute if score #n_type matches 3..` 门控（type 0..2 不走本函数）
#   ★ 只增不减（调用方从缓存值起累加）⇒ 永远偏保守，不会漏渲染
scoreboard players set #n_dur_t editor 0
execute if data storage rhythm_axe:prop note.duration run execute store result score #n_dur_t editor run data get storage rhythm_axe:prop note.duration
execute if score #n_type editor matches 3 unless data storage rhythm_axe:prop note.duration run scoreboard players set #n_dur_t editor 1
execute if score #n_type editor matches 4 unless data storage rhythm_axe:prop note.duration run scoreboard players set #n_dur_t editor 3
scoreboard players set #n_ig_t editor 0
execute store result score #n_ig_t editor run data get storage rhythm_axe:prop note.ignore_note_speed
# 玻璃：尾长 = dur×16/流速 + 1（ignore_note_speed 时 = dur + 1）；混凝土：dur − 1（取 dur 更保守）
scoreboard players operation #n_trail editor = #n_dur_t editor
execute if score #n_type editor matches 4 if score #n_ig_t editor matches 0 run scoreboard players operation #n_trail editor *= 16 const
execute if score #n_type editor matches 4 if score #n_ig_t editor matches 0 run scoreboard players operation #n_trail editor /= note_speed options
execute if score #n_type editor matches 4 run scoreboard players add #n_trail editor 1
execute if score #n_trail editor > #vis_trail_max editor run scoreboard players operation #vis_trail_max editor = #n_trail editor
