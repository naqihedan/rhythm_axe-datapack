# 混凝土每 tick 判定（@s = 混凝土交互实体，at 其位置；由 active_note 调用）
# 段落判定（M2-F，用户确认的语义）+ 判定保护（音符.md，Python 模拟验证）：
#   - 长条按 density 分段；段 k 判定区间 = 寿命 [-(k-1)·density, -k·density]（段 1 从寿命 0 开始）
#   - 段内任意时刻玩家在判定区域 → 立即大P（该段完成，段末不再判）
#   - 段末该段从未进过判定区域 → 该段 miss；miss 不中断
#   - 保护1 首段过早离开：记录窗口 l∈[1,3x] 在区域内→记录寿命；首段段末不在区域且已记录→按记录寿命判级
#   - 保护2 末段过短：末段长 = dur%density（0则=density）< 3x → 延长 3x，延长段按 level(l+dur) 判级
# 判定区域：判定点沿前进方向 4 格长、1 宽、3 高（marker 常驻，见 summon）

# 记录 note_id 用于配对本长条的 marker
scoreboard players operation #nid play_state = @s note_id
# 3×判定缩放（保护用；#judgement_scale 由时间点维护）
scoreboard players operation #x3 play_state = #judgement_scale play_state
scoreboard players operation #x3 play_state *= 3 const
# 末段长度 dur%density（0→density）；过短（<3x）→ 延长 ext=3x
scoreboard players operation #ll play_state = @s note_c_dur
scoreboard players operation #ll play_state %= @s note_c_density
execute if score #ll play_state matches 0 run scoreboard players operation #ll play_state = @s note_c_density
scoreboard players operation #ext play_state = 0 const
execute if score #ll play_state < #x3 play_state run scoreboard players operation #ext play_state = #x3 play_state
# 有效下界 #neg_dur = -(dur + ext)（出窗/判段下界）
scoreboard players operation #neg_dur play_state = @s note_c_dur
scoreboard players operation #neg_dur play_state += #ext play_state
scoreboard players operation #neg_dur play_state *= -1 const

# ===== 检测玩家是否处于判定区域 =====
# ★ 自动模式（2026-08-09）：auto=1 时玩家始终在判定区域 → #in_zone 直接置 1，跳过 marker 遍历
scoreboard players set #in_zone play_state 0
execute if score auto play_state matches 1 run scoreboard players set #in_zone play_state 1
# 远距离（水平 > 1）：marker 在判定点，沿本地 ^（yaw=运动方向）逐格探 4 格，每格检测 1×3×1
execute if score auto play_state matches 0 as @e[type=marker,tag=note_c_zone] if score @s note_id = #nid play_state at @s positioned ^ ^ ^0 positioned ~-0.5 ~ ~-0.5 if entity @a[dx=0,dy=3,dz=0] run scoreboard players set #in_zone play_state 1
execute if score auto play_state matches 0 as @e[type=marker,tag=note_c_zone] if score @s note_id = #nid play_state at @s positioned ^ ^ ^1 positioned ~-0.5 ~ ~-0.5 if entity @a[dx=0,dy=3,dz=0] run scoreboard players set #in_zone play_state 1
execute if score auto play_state matches 0 as @e[type=marker,tag=note_c_zone] if score @s note_id = #nid play_state at @s positioned ^ ^ ^2 positioned ~-0.5 ~ ~-0.5 if entity @a[dx=0,dy=3,dz=0] run scoreboard players set #in_zone play_state 1
execute if score auto play_state matches 0 as @e[type=marker,tag=note_c_zone] if score @s note_id = #nid play_state at @s positioned ^ ^ ^3 positioned ~-0.5 ~ ~-0.5 if entity @a[dx=0,dy=3,dz=0] run scoreboard players set #in_zone play_state 1
# 近距离（水平 ≤ 1）：marker 在判定点，检测 3×3×3（文档：以判定点为中心半径1.5格、高3格）
# ★ dx=2 = 3 格宽：positioned ~-1.5 后 dx=2 覆盖 [-1.5,+1.5]（dx=N 表示宽度 N+1 格）
execute if score auto play_state matches 0 as @e[type=marker,tag=note_c_zone_near] if score @s note_id = #nid play_state at @s positioned ~-1.5 ~ ~-1.5 if entity @a[dx=2,dy=3,dz=2] run scoreboard players set #in_zone play_state 1

# ===== 保护1：记录窗口 l∈[1,3x] 且 in_zone → 记录寿命（最后一刻记录为准）=====
execute if score @s note_life matches 1.. if score @s note_life <= #x3 play_state if score #in_zone play_state matches 1 run scoreboard players operation @s note_recorded_life = @s note_life

# ===== 段内判定（l<=0 且 l>seg_end 且 l>#neg_dur 且未判 且 in_zone）→ 大P =====
execute if score @s note_life matches ..0 if score @s note_life > @s note_c_seg_end if score @s note_life > #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 1 run function rhythm_axe:play/judgement/concrete_perfect

# ===== 末段过短：延长段判级（仅末段 seg_idx==seg_count；l<=seg_end=-dur 且 l>#neg_dur 且 in_zone）=====
# #judge_life = l + duration（负值→pL/gL/miss）
execute if score #ext play_state matches 1.. if score @s note_c_seg_idx = @s note_c_seg_count if score @s note_life <= @s note_c_seg_end if score @s note_life > #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 1 run scoreboard players operation #judge_life play_state = @s note_life
execute if score #ext play_state matches 1.. if score @s note_c_seg_idx = @s note_c_seg_count if score @s note_life <= @s note_c_seg_end if score @s note_life > #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 1 run scoreboard players operation #judge_life play_state += @s note_c_dur
execute if score #ext play_state matches 1.. if score @s note_c_seg_idx = @s note_c_seg_count if score @s note_life <= @s note_c_seg_end if score @s note_life > #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 1 run function rhythm_axe:play/judgement/concrete_judge_level

# ===== 首段过早离开保护（首段段末不在区域且已记录 → 按记录寿命判级）=====
execute if score @s note_c_seg_idx matches 1 if score @s note_life <= @s note_c_seg_end if score @s note_life >= #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 0 if score @s note_recorded_life matches 0.. run scoreboard players operation #judge_life play_state = @s note_recorded_life
execute if score @s note_c_seg_idx matches 1 if score @s note_life <= @s note_c_seg_end if score @s note_life >= #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 0 if score @s note_recorded_life matches 0.. run function rhythm_axe:play/judgement/concrete_judge_level

# ===== 末段过短：延长窗口结束（l<=#neg_dur）仍未判 → miss =====
execute if score #ext play_state matches 1.. if score @s note_c_seg_idx = @s note_c_seg_count if score @s note_life <= #neg_dur play_state if score @s note_c_seg_done matches 0 run function rhythm_axe:play/judgement/concrete_miss

# ===== 正常段末判定（末段过短时末段由上面延长处理；此处只处理：末段不过短的所有段 + 过短音符的非末段）=====
execute if score #ext play_state matches 0 if score @s note_life <= @s note_c_seg_end if score @s note_life >= #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 1 run function rhythm_axe:play/judgement/concrete_perfect
execute if score #ext play_state matches 0 if score @s note_life <= @s note_c_seg_end if score @s note_life >= #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 0 run function rhythm_axe:play/judgement/concrete_miss
execute if score #ext play_state matches 1.. unless score @s note_c_seg_idx = @s note_c_seg_count if score @s note_life <= @s note_c_seg_end if score @s note_life >= #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 1 run function rhythm_axe:play/judgement/concrete_perfect
execute if score #ext play_state matches 1.. unless score @s note_c_seg_idx = @s note_c_seg_count if score @s note_life <= @s note_c_seg_end if score @s note_life >= #neg_dur play_state if score @s note_c_seg_done matches 0 if score #in_zone play_state matches 0 run function rhythm_axe:play/judgement/concrete_miss

# ===== 段末后推进到下一段（本段已判完；末段不再推进）=====
execute if score @s note_life <= @s note_c_seg_end if score @s note_c_seg_done matches 1 unless score @s note_c_seg_idx = @s note_c_seg_count run function rhythm_axe:play/judgement/concrete_next_seg

# ===== 全部段落已过（寿命 ≤ -dur-ext）→ 标记 done（出窗静默清除）=====
execute if score @s note_life <= #neg_dur play_state run scoreboard players set @s note_c_done 1
