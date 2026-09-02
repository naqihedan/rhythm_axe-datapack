# 判定反馈查表+执行（M2-H 核心；宏参数由调用方预置到 storage rhythm_axe:runtime）
# 宏参数：fb_hitsound（音效组号）、fb_particles（粒子组号）、fb_nid（音符 id）、case_name（情况名）
# 流程：查音效表 → 播放；查粒子表 → 播放；执行该音符 hit_events（按 case_name 过滤）
# 执行者 = 音符交互实体，位置 = 交互实体位置（@s；判定由 judge 链以 @s=交互实体调用，spawn 由 summon as @e at @s 调用）
# 播放函数内 ~ ~ ~ 以交互实体位置为基准（不做位置归零；归零仅事件系统 events 用）
#arg: fb_hitsound, fb_particles, fb_nid, case_name
# 清残留（上次反馈的值；查表失败时不误播）
execute if data storage rhythm_axe:runtime cur_sound run data remove storage rhythm_axe:runtime cur_sound
execute if data storage rhythm_axe:runtime cur_particle run data remove storage rhythm_axe:runtime cur_particle
# 查音效表：feedback.sounds[组].(情况) → cur_sound → 播放
$execute if data storage rhythm_axe:feedback sounds[$(fb_hitsound)].$(case_name) run data modify storage rhythm_axe:runtime cur_sound set from storage rhythm_axe:feedback sounds[$(fb_hitsound)].$(case_name)
execute if data storage rhythm_axe:runtime cur_sound run function rhythm_axe:play/feedback/play_sound with storage rhythm_axe:runtime
# 查粒子表：feedback.particles[组].(情况) → cur_particle → 播放
$execute if data storage rhythm_axe:feedback particles[$(fb_particles)].$(case_name) run data modify storage rhythm_axe:runtime cur_particle set from storage rhythm_axe:feedback particles[$(fb_particles)].$(case_name)
execute if data storage rhythm_axe:runtime cur_particle run function rhythm_axe:play/feedback/play_particle with storage rhythm_axe:runtime
# hit_events：按情况 enabled 过滤后宏执行（该音符的击打特效）
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid) run function rhythm_axe:play/feedback/run_hit_events with storage rhythm_axe:runtime
