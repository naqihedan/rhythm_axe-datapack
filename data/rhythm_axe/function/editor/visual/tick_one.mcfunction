# 播放 tick 单实体：@s = 编辑器音符展示实体（item_display, tag=editor_note）
# 按当前 playhead 更新位置（统一 place）；已消失 / 未出生（跳回）→ 清理
# 经过判定时间（playhead == time）且未触发 → 播放击打音效/粒子（+ hit_events 按设置）
# 实体计分板：note_id / editor_n_birth / editor_n_time / editor_n_end / editor_n_dist / editor_n_type
#                  editor_n_idx / note_hitsound / note_hit_particles
execute if score #playhead editor > @s editor_n_end run function rhythm_axe:editor/visual/tick_kill
execute if score #playhead editor < @s editor_n_birth run function rhythm_axe:editor/visual/tick_kill
# 触发（仅播放中经过判定时刻；跳转定位不触发；相等用 双 unless > < 等价写法）
# ★ 普通音符白名单 type=0..2 才触发：type 空（幽灵/异常实体）或 3/4（混凝土/玻璃）一律不触发，杜绝"出窗时 type 读不到→误判"
execute if score @s editor_n_type matches 0..2 unless score #playhead editor > @s editor_n_time unless score #playhead editor < @s editor_n_time unless entity @s[tag=editor_n_triggered] run function rhythm_axe:editor/visual/trigger
# ★ 混凝土密度段判定（对齐游玩 auto 每段判 P）：段 k 结束 rel=min(k×density, dur)，k=1..seg_count
#   首段结束=time+density；最后一段=time+dur（出窗判定）；单实体检查（concrete_seg_check 内写→判防串扰）
execute if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. if score #playhead editor >= @s editor_n_time run function rhythm_axe:editor/visual/concrete_seg_check
execute unless score #playhead editor > @s editor_n_end unless score #playhead editor < @s editor_n_birth run function rhythm_axe:editor/visual/place
