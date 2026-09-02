# 编辑器音符击打触发执行（宏参数：nid, hitsound, hit_particles, idx）
# @s = 展示实体（at 其位置播击打音效/粒子，与游玩 auto 一致：情况 = perfect）
# ★ 音符判定时刻（playhead==time）即在判定位置 Pos，音效/粒子用 ~ ~ ~（=Pos）播放，玩家在附近可听到/看到
# hit_events 自定义指令：editor_note_hitevents=1 时才执行（编辑器专属反馈链，与游玩系统互不干扰）
# ★ 全部使用 storage rhythm_axe:editor.runtime（编辑器专属，不用游玩系统的 rhythm_axe:runtime）
#arg: cursor, nid, hitsound, hit_particles, idx
# ★ 玻璃（type=4）零反馈：任何路径到 trigger_ 都直接 return（终极防线第 4 层）
execute if score @s editor_n_type matches 4 run return fail

# 播放击打音效（查表 feedback.sounds[组].perfect）
$execute if data storage rhythm_axe:feedback sounds[$(hitsound)].perfect run data modify storage rhythm_axe:editor.runtime cur_sound set from storage rhythm_axe:feedback sounds[$(hitsound)].perfect
execute if data storage rhythm_axe:editor.runtime cur_sound run function rhythm_axe:editor/visual/play_sound with storage rhythm_axe:editor.runtime
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][trigger]","color":"gray"},{"text":" sound=","color":"yellow"},{"nbt":"cur_sound","storage":"rhythm_axe:editor.runtime","interpret":true},{"text":" 实体Pos=","color":"gray"},{"nbt":"Pos","entity":"@s"}]
# 播放击打粒子（查表 feedback.particles[组].perfect）
$execute if data storage rhythm_axe:feedback particles[$(hit_particles)].perfect run data modify storage rhythm_axe:editor.runtime cur_particle set from storage rhythm_axe:feedback particles[$(hit_particles)].perfect
execute if data storage rhythm_axe:editor.runtime cur_particle run function rhythm_axe:editor/visual/play_particle with storage rhythm_axe:editor.runtime
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][trigger]","color":"gray"},{"text":" particle=","color":"yellow"},{"nbt":"cur_particle","storage":"rhythm_axe:editor.runtime","interpret":true},{"text":" 实体Pos=","color":"gray"},{"nbt":"Pos","entity":"@s"}]
# 清理查表残留
execute if data storage rhythm_axe:editor.runtime cur_sound run data remove storage rhythm_axe:editor.runtime cur_sound
execute if data storage rhythm_axe:editor.runtime cur_particle run data remove storage rhythm_axe:editor.runtime cur_particle
# hit_events：editor_note_hitevents=1 → 复制该音符 hit_events 到 editor.runtime 并执行（情况 = perfect）
# ★ 无 hit_events 数据时也存默认空列表并走执行流程（以默认值执行：无特效指令）
execute if score editor_note_hitevents options matches 1 run data modify storage rhythm_axe:editor.runtime case_name set value "perfect"
$execute if score editor_note_hitevents options matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].hit_events run data modify storage rhythm_axe:editor.runtime hit_events.$(nid) set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].hit_events
$execute if score editor_note_hitevents options matches 1 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].hit_events run data modify storage rhythm_axe:editor.runtime hit_events.$(nid) set value []
# run_hit_events 按宏参数 fb_nid 读 hit_events.$(fb_nid)：编辑器此处 fb_nid = 音符 id（nid）
$execute if score editor_note_hitevents options matches 1 run data modify storage rhythm_axe:editor.runtime fb_nid set value $(nid)
execute if score editor_note_hitevents options matches 1 run function rhythm_axe:editor/visual/run_hit_events with storage rhythm_axe:editor.runtime
# 清理 hit_events 存储与 case_name / fb_nid
$execute if data storage rhythm_axe:editor.runtime hit_events.$(nid) run data remove storage rhythm_axe:editor.runtime hit_events.$(nid)
execute if data storage rhythm_axe:editor.runtime case_name run data remove storage rhythm_axe:editor.runtime case_name
execute if data storage rhythm_axe:editor.runtime fb_nid run data remove storage rhythm_axe:editor.runtime fb_nid
