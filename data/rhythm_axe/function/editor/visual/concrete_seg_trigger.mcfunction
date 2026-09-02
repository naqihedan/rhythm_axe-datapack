# 混凝土密度段判定（类似游玩 auto 每段判 P）：播放 perfect 音效/粒子 + 橙光 + 段计数+1
# @s = 混凝土展示实体；rel == seg×density 由 tick_one 保证（段 0 = time 首段）
# ★ 不打 editor_n_triggered（混凝土多段，每段独立判定；普通音符的 trigger 才打该 tag）
# ★ 橙光仅快进快退（非播放）时亮，提示判定时刻；正常播放判定只播音效/粒子
#   playing 键恒存在（0b/1b），unless data storage 恒失败；按值判断：非播放 = playing==0
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 0 run data modify entity @s Glowing set value 1b
execute if score #temp editor matches 0 run data modify entity @s glow_color_override set value 16766720
# 组装参数调 trigger_（同 trigger.mcfunction 的组装，但混凝土段判定不打 triggered tag）
scoreboard players operation #tmp_nid editor = @s note_id
execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #tmp_nid editor
scoreboard players operation #tmp_hs editor = @s note_hitsound
execute store result storage rhythm_axe:prop hitsound int 1 run scoreboard players get #tmp_hs editor
scoreboard players operation #tmp_hp editor = @s note_hit_particles
execute store result storage rhythm_axe:prop hit_particles int 1 run scoreboard players get #tmp_hp editor
scoreboard players operation #tmp_idx editor = @s editor_n_idx
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #tmp_idx editor
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/visual/trigger_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop hitsound
data remove storage rhythm_axe:prop hit_particles
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop cursor
# 段计数 +1（下段判定）
scoreboard players add @s editor_n_seg 1
