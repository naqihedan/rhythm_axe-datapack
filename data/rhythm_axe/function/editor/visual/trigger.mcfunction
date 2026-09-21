# 编辑器音符击打触发（@s = 展示实体）：标记已触发，组装参数调 trigger_ 播放音效/粒子/执行 hit_events
# 触发条件由 tick_one 保证（自动预览：playhead == time 且未触发；真实判定：judge 命中/miss 后主动调用）
# ★ 判定等级 → 情况键：judge 命中/miss 前写 #ed_level（0..6）；未写/已清 = 自动预览（perfect）
#   必须【最前】读取并立刻清空：type=4 的 return fail 会提前结束本函数，残留等级会污染下一次触发
scoreboard players set #ed_tmp_lv editor 3
execute if score #ed_level editor matches 0..6 run scoreboard players operation #ed_tmp_lv editor = #ed_level editor
scoreboard players reset #ed_level editor
# ★ 玻璃（type=4）从头到尾零特效：即使误入也直接 return，不标记、不调 trigger_（双保险，与 tick_one 的 unless type 4 配合）
execute if score @s editor_n_type matches 4 run return fail
# ★ 橙光仅快进快退（非播放）时亮，提示判定时刻；正常播放判定只播音效/粒子、不发光
#   判定（发光）那一刻的下一刻出窗：自动预览 end = time；真实判定 end = time+2x+1（judge/window_extend）
#   playing 键恒存在（0b/1b），unless data storage 恒失败；按值判断：非播放 = playing==0
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 0 run data modify entity @s Glowing set value 1b
execute if score #temp editor matches 0 run data modify entity @s glow_color_override set value 16766720
tag @s add editor_n_triggered
scoreboard players operation #tmp_nid editor = @s note_id
execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #tmp_nid editor
scoreboard players operation #tmp_hs editor = @s note_hitsound
execute store result storage rhythm_axe:prop hitsound int 1 run scoreboard players get #tmp_hs editor
scoreboard players operation #tmp_hp editor = @s note_hit_particles
execute store result storage rhythm_axe:prop hit_particles int 1 run scoreboard players get #tmp_hp editor
scoreboard players operation #tmp_idx editor = @s editor_n_idx
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #tmp_idx editor
# cursor 传入（trigger_ 读 history[$(cursor)].notes 的 hit_events）
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
# 情况键（bad/good_early/perfect_early/perfect/perfect_late/good_late/miss）：由 #ed_tmp_lv 决定
data modify storage rhythm_axe:prop case set value "perfect"
execute if score #ed_tmp_lv editor matches 0 run data modify storage rhythm_axe:prop case set value "bad"
execute if score #ed_tmp_lv editor matches 1 run data modify storage rhythm_axe:prop case set value "good_early"
execute if score #ed_tmp_lv editor matches 2 run data modify storage rhythm_axe:prop case set value "perfect_early"
execute if score #ed_tmp_lv editor matches 4 run data modify storage rhythm_axe:prop case set value "perfect_late"
execute if score #ed_tmp_lv editor matches 5 run data modify storage rhythm_axe:prop case set value "good_late"
execute if score #ed_tmp_lv editor matches 6 run data modify storage rhythm_axe:prop case set value "miss"
function rhythm_axe:editor/visual/trigger_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop hitsound
data remove storage rhythm_axe:prop hit_particles
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop case
