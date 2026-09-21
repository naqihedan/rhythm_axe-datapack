# 播放 tick 单实体：@s = 编辑器音符展示实体（item_display, tag=editor_note）
# 按当前 playhead 更新位置（统一 place）；已消失 / 未出生（跳回）→ 清理
# 经过判定时间（playhead == time）且未触发 → 播放击打音效/粒子（+ hit_events 按设置）
# 实体计分板：note_id / editor_n_birth / editor_n_time / editor_n_end / editor_n_dist / editor_n_type
#                  editor_n_idx / note_hitsound / note_hit_particles
# ★ 出窗上界：游玩测试模式下混凝土要覆盖「末段过短延长 3×缩放 + 判定余量」
#   ⇒ 上界改用 time + dur + 3x + 1（否则延长窗口还没走完就被 kill）
scoreboard players operation #pe_end editor = @s editor_n_end
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players operation #pe_end editor = @s editor_n_time
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players operation #pe_end editor += @s editor_n_dur
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players operation #pe_x editor = #ed_scale editor
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players operation #pe_x editor *= 3 const
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players operation #pe_end editor += #pe_x editor
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players add #pe_end editor 1
execute if score #playhead editor > #pe_end editor run function rhythm_axe:editor/visual/tick_kill
execute if score #playhead editor < @s editor_n_birth run function rhythm_axe:editor/visual/tick_kill
# 触发（仅播放中经过判定时刻；跳转定位不触发；相等用 双 unless > < 等价写法）
# ★ 普通音符白名单 type=0..2 才触发：type 空（幽灵/异常实体）或 3/4（混凝土/玻璃）一律不触发，杜绝"出窗时 type 读不到→误判"
# ★ 自动预览模式（editor_note_judge=0）＝ 现状：到判定时刻即播音符事件（情况 = perfect）
execute if score editor_note_judge options matches 0 if score @s editor_n_type matches 0..2 unless score #playhead editor > @s editor_n_time unless score #playhead editor < @s editor_n_time unless entity @s[tag=editor_n_triggered] run function rhythm_axe:editor/visual/trigger
# ★ 真实判定模式（editor_note_judge=1）：不再自动触发——每刻做输入判定
#   （窗口内视线/点击命中 → 播音符事件；超窗未命中 → miss / 木板静默清除，见 editor/judge/note_check）
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 0..2 run function rhythm_axe:editor/judge/note_check
# ★ 混凝土判定：自动预览（游玩测试关）= 密度段自动判 P；游玩测试（开）= 区域判定 + 分段 + 保护1/2（judge/concrete_check）
#   首段结束=time+density；最后一段=time+dur（出窗判定）；单实体检查（concrete_seg_check 内写→判防串扰）
execute if score editor_note_judge options matches 0 if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. if score #playhead editor >= @s editor_n_time run function rhythm_axe:editor/visual/concrete_seg_check
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run function rhythm_axe:editor/judge/concrete_check
# ★ 玻璃：判定前先快照「上一刻视觉中心」（紧接着的 place 会把 editor_n_v* 更新为当前刻）
#   玻璃判定 = 移动碰撞，需要「上一刻中心 → 当前中心」线段做 CCD 扫掠（见 judge/glass_check）
execute if score @s editor_n_type matches 4 run scoreboard players operation @s editor_n_vvx = @s editor_n_vx
execute if score @s editor_n_type matches 4 run scoreboard players operation @s editor_n_vvy = @s editor_n_vy
execute if score @s editor_n_type matches 4 run scoreboard players operation @s editor_n_vvz = @s editor_n_vz
# ★ 定位（place）上界：混凝土在游玩测试模式下改为 #pe_end —— editor_n_end 是 time+dur−1，
#   它会让 place 在尾端进度还差 1 刻时停手 ⇒ 长度停在最后一帧（不归零、尾巴留一截）。
#   游玩侧靠「清除比收缩完成晚 4 刻」让 gt 到 1（长度 = Δ(1−1) = 0），这里把上界放到 #pe_end 等价。
#   其余类型仍用 editor_n_end（它们的视觉不需要越过消失刻继续算）。
scoreboard players operation #pe_place editor = @s editor_n_end
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 3 run scoreboard players operation #pe_place editor = #pe_end editor
execute unless score #playhead editor > #pe_place editor unless score #playhead editor < @s editor_n_birth run function rhythm_axe:editor/visual/place
# ★ 玻璃真实判定（必须在 place 之后：此刻 editor_n_v* = 当前刻视觉中心、vv* = 上一刻）
execute if score editor_note_judge options matches 1 if score @s editor_n_type matches 4 run function rhythm_axe:editor/judge/glass_check
