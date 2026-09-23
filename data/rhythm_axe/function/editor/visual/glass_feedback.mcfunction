# 玻璃命中反馈（@s = 玻璃展示实体；执行位置已由调用方 at 到采样命中点）
# ★ 由 glass_sweep_step 以 `with storage rhythm_axe:editor.runtime` 调用 —— 宏参数由 glass_check 每刻组装
# 照搬游玩 damage 反馈组：case = damage 查 feedback.sounds / feedback.particles，并跑 hit_events
# ★ 不扣血、不计成绩、不加连击（编辑器侧只有反馈）
# ★ 不走 trigger_/play_sound/play_particle —— 三者都有「玻璃零反馈」防线，播放走 glass_play_* 专用子函数
# ★ 冷却：调用方已确认未在冷却中，这里把【玩家级】#ed_g_cd 置回 options.damage_cooldown（与游玩同节奏）
#arg: gf_hs, gf_hp, gf_case, gf_cursor, gf_idx, gf_nid
scoreboard players set #ed_g_hit editor 1
scoreboard players operation #ed_g_cd editor = damage_cooldown options
# ---- 音效：feedback.sounds[组].damage → cur_sound → glass_play_sound ----
execute if data storage rhythm_axe:editor.runtime cur_sound run data remove storage rhythm_axe:editor.runtime cur_sound
$execute if data storage rhythm_axe:feedback sounds[$(gf_hs)][4].$(gf_case) run data modify storage rhythm_axe:editor.runtime cur_sound set from storage rhythm_axe:feedback sounds[$(gf_hs)][4].$(gf_case)
execute if data storage rhythm_axe:editor.runtime cur_sound run function rhythm_axe:editor/visual/glass_play_sound with storage rhythm_axe:editor.runtime
# ---- 粒子：feedback.particles[组].damage（表内存完整指令）→ glass_play_particle ----
execute if data storage rhythm_axe:editor.runtime cur_particle run data remove storage rhythm_axe:editor.runtime cur_particle
$execute if data storage rhythm_axe:feedback particles[$(gf_hp)][4].$(gf_case) run data modify storage rhythm_axe:editor.runtime cur_particle set from storage rhythm_axe:feedback particles[$(gf_hp)][4].$(gf_case)
execute if data storage rhythm_axe:editor.runtime cur_particle run function rhythm_axe:editor/visual/glass_play_particle with storage rhythm_axe:editor.runtime
# ---- hit_events：editor_play_events=1 时，复制该音符的 hit_events 并按 case 跑（与谱面事件点同一个开关）----
$execute if score editor_play_events options matches 1 run data modify storage rhythm_axe:editor.runtime case_name set value "$(gf_case)"
$execute if score editor_play_events options matches 1 if data storage rhythm_axe:maps.editor history[$(gf_cursor)].notes[$(gf_idx)].hit_events run data modify storage rhythm_axe:editor.runtime hit_events.$(gf_nid) set from storage rhythm_axe:maps.editor history[$(gf_cursor)].notes[$(gf_idx)].hit_events
$execute if score editor_play_events options matches 1 unless data storage rhythm_axe:maps.editor history[$(gf_cursor)].notes[$(gf_idx)].hit_events run data modify storage rhythm_axe:editor.runtime hit_events.$(gf_nid) set value []
$execute if score editor_play_events options matches 1 run data modify storage rhythm_axe:editor.runtime fb_nid set value $(gf_nid)
execute if score editor_play_events options matches 1 run function rhythm_axe:editor/visual/run_hit_events with storage rhythm_axe:editor.runtime
# ---- 文字反馈（聊天栏 / actionbar）：只在【游玩测试】模式输出 ----
#   #ed_disp = 7 = DAMAGE（玻璃撞到玩家 = 游玩里会扣 1 血）
execute if score editor_note_judge options matches 1 run scoreboard players set #ed_disp editor 7
execute if score editor_note_judge options matches 1 run function rhythm_axe:editor/judge/feedback_text
# ---- 清理本函数产生的临时键（gf_* 由 glass_check 每刻组装，不在这里删）----
$execute if data storage rhythm_axe:editor.runtime hit_events.$(gf_nid) run data remove storage rhythm_axe:editor.runtime hit_events.$(gf_nid)
execute if data storage rhythm_axe:editor.runtime cur_sound run data remove storage rhythm_axe:editor.runtime cur_sound
execute if data storage rhythm_axe:editor.runtime cur_particle run data remove storage rhythm_axe:editor.runtime cur_particle
execute if data storage rhythm_axe:editor.runtime case_name run data remove storage rhythm_axe:editor.runtime case_name
execute if data storage rhythm_axe:editor.runtime fb_nid run data remove storage rhythm_axe:editor.runtime fb_nid
