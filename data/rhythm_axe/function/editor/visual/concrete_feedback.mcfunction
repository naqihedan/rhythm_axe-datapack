# 混凝土单段反馈（@s = 混凝土展示实体）：组装参数调 trigger_，情况键 = prop.ct_case（缺省 perfect）
# ★ 不打 editor_n_triggered（混凝土多段、每段独立判定）；不 kill（长条继续向下走）
# ★ 橙光仅快进快退（非播放）时亮，提示判定时刻（与 trigger / concrete_seg_trigger 同款）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 0 run data modify entity @s Glowing set value 1b
execute if score #temp editor matches 0 run data modify entity @s glow_color_override set value 16766720
scoreboard players operation #ctf_nid editor = @s note_id
execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #ctf_nid editor
scoreboard players operation #ctf_hs editor = @s note_hitsound
execute store result storage rhythm_axe:prop hitsound int 1 run scoreboard players get #ctf_hs editor
scoreboard players operation #ctf_hp editor = @s note_hit_particles
execute store result storage rhythm_axe:prop hit_particles int 1 run scoreboard players get #ctf_hp editor
execute if score #ctf_hs editor matches 0 run execute store result storage rhythm_axe:prop hitsound int 1 run scoreboard players get note_hitsound options
execute if score #ctf_hp editor matches 0 run execute store result storage rhythm_axe:prop hit_particles int 1 run scoreboard players get note_particle options
# 音符类型（trigger_ 用 $(note_type) 查二维表）
execute store result storage rhythm_axe:prop note_type int 1 run scoreboard players get @s editor_n_type
scoreboard players operation #ctf_idx editor = @s editor_n_idx
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #ctf_idx editor
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop case set value "perfect"
execute if data storage rhythm_axe:prop ct_case run data modify storage rhythm_axe:prop case set from storage rhythm_axe:prop ct_case
function rhythm_axe:editor/visual/trigger_ with storage rhythm_axe:prop
# ★ 文字反馈（聊天栏 / actionbar）：只在【游玩测试】模式输出（自动预览保持旧行为：只有音效/粒子）
#   #ed_disp 由调用方设好（大P=3 / miss=6 / 判级=#ed_level）；feedback_text 用完会 reset #ed_disp
execute if score editor_note_judge options matches 1 run function rhythm_axe:editor/judge/feedback_text
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop hitsound
data remove storage rhythm_axe:prop hit_particles
data remove storage rhythm_axe:prop note_type
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop case
