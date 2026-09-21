# 编辑器真实判定：单音符判定检查（@s = 编辑器音符展示实体；at @s 由 tick_one 保证）
# 调用条件：判定模式（options.editor_note_judge=1）且播放中（tick_one 内分流；自动预览模式不走这里）
# 窗口：life = editor_n_time − #playhead（正=音符还在飞来，负=已过判定位置）；x = #ed_scale（当前时间点 judgment_scale）
#   检测期 [3x, -2x]（3x = 保护期上界）
#   立即判定窗（分支 B）音符盒/唱片机 [3x, -2x]；★ 木板 [2x, -2x]（无 bad 段：bad 区间 [2x+1,3x] 内看着也不判）
#   life < -2x → 未命中收尾（木板静默清除、其余 miss，见 window_out）
# 命中输入（照搬游玩语义）：type 0/1（音符盒/木板）= 玩家视线命中；type 2（唱片机）= 玩家点击标记
# 判定保护（照搬游玩 protected / protected_plank + 文档情况 1/2 三款；保护进入靠 judge/raycast 的射线步进）：
#   life == 3x+1 且本刻"视线经过**判定位置**（完美判定区域）" → 进入保护（**只置状态，绝不在此判定**）
#   保护中：保护期 [3x,0] 内「看着」→ 记录寿命（editor_n_rec_life），**暂不判定**；life==0 结算（见 judge/protect）
#     「看着」= 视线与**音符**相交（@s editor_n_hit）**或** 视线在**完美判定区域**内（editor_n_looked_perfect）
#   无记录（保护期内一次都没看着）⇒ 等同无保护：life<0 时放行到分支 B（#ed_pblock），按"相交那一刻的寿命"判
#   ⚠ 本刻 life == 3x+1 > 3x ⇒ 下面的 predicate 限窗会直接 return，不会意外走到"命中检测"
# 唱片机末刻兜底（照搬游玩 jukebox_late）：life == -2x 仍未点击 → 看向则 good_late，不看则 miss
# ★ 命中/未命中后立即清除音符对（与游玩「判定即消失」一致；自动预览模式的"到点消失"不受影响）
# ★ 《同一刻判定限制》：同一刻只放行 note_life 最小（= time 最小、最靠前）的那一批候选取得判定 ——
#   候选集与最小寿命由 judge/probe 每刻预扫一次（#ed_min_life），命中标记写在各实体的 @s editor_n_hit 上；
#   本函数只读这两份结果（不再自己检测），保证"最小寿命"与"命中"来自同一份快照。
execute if entity @s[tag=editor_n_triggered] run return fail
scoreboard players operation #ed_life editor = @s editor_n_time
scoreboard players operation #ed_life editor -= #playhead editor
# 3x（检测期/保护期上界）与 3x+1（保护进入刻）
scoreboard players operation #ed_p3 editor = #ed_scale editor
scoreboard players operation #ed_p3 editor *= 3 const
scoreboard players operation #ed_p3e editor = #ed_p3 editor
scoreboard players add #ed_p3e editor 1
# 分支 B 立即判定门槛：音符盒/唱片机 = 3x；木板（type 1）= 2x
scoreboard players operation #ed_jhi editor = #ed_p3 editor
scoreboard players operation #ed_j2 editor = #ed_scale editor
scoreboard players operation #ed_j2 editor *= 2 const
execute if score @s editor_n_type matches 1 run scoreboard players operation #ed_jhi editor = #ed_j2 editor
# -2x（窗口下界）
scoreboard players operation #ed_lo editor = #ed_scale editor
scoreboard players operation #ed_lo editor *= -2 const
# ===== 判定保护：进入检查（life == 3x+1 且本刻视线经过判定位置）=====
execute if score @s editor_n_type matches 0..1 if score #ed_life editor = #ed_p3e editor if score @s editor_n_protect matches 0 if entity @s[tag=editor_n_looked_perfect] run scoreboard players set @s editor_n_protect 1
# 超窗 → 未命中收尾（收尾里 kill 自己；下面这行只是防后续命令继续跑）
execute if score #ed_life editor < #ed_lo editor run function rhythm_axe:editor/judge/window_out
execute if score #ed_life editor < #ed_lo editor run return 0
# 还没进检测期（音符仍在飞向判定位置）→ 不检测（与游玩 judgement/main_plank 的 predicate 限窗一致）
execute if score #ed_life editor > #ed_p3 editor run return 0
# ===== 命中检测 =====
# ★ 本刻命中标记（@s editor_n_hit）由 judge/probe 统一检测（含唱片机点击标记的消费与视线检测），
#   这里只读结果 —— 视线检测每刻只做一次，且"同刻最小寿命"用的是同一份命中集合
# ===== 保护中 → 保护分支（记录寿命 / life==0 结算）=====
execute if score @s editor_n_protect matches 1 run function rhythm_axe:editor/judge/protect
# ★ 保护中默认不再走分支 B（保护期 [3x,0] 内"暂不判定"）。
#   但文档《判定保护情况下音符取得判定的几种情况》第 2 条第 3 款：**保护期内视线从未与音符相交（无记录）
#   ⇒ 情况同 1（等同无保护）** —— 此时 life < 0 要放行到分支 B，按"相交那一刻的寿命"继续判（perfectL/goodL）；
#   木板同理（相交即判 → 恒大P）。若始终不相交，则由 window_out 收尾（音符盒 miss / 木板静默清除）。
scoreboard players set #ed_pblock editor 1
execute if score @s editor_n_protect matches 1 if score #ed_life editor matches ..-1 if score @s editor_n_rec_life matches ..-1 run scoreboard players set #ed_pblock editor 0
execute if score @s editor_n_protect matches 1 if score #ed_pblock editor matches 1 run return 0
# ===== 分支 B（未保护）=====
# ★ 《同一刻判定限制》：本刻只放行 note_life 最小的一批候选（#ed_min_life 由 judge/probe 预扫得出）。
#   被压制的候选本刻不判、不惩罚 —— 下刻寿命 -1 后重新参与；若因此越过窗口则照常 miss（文档规则表）
# 音符盒/木板：命中 + 寿命进入立即判定窗 + 本刻最小寿命 → 收尾（音符盒按寿命判等级、木板恒大P）
execute if score @s editor_n_type matches 0..1 if score #ed_life editor <= #ed_jhi editor if score @s editor_n_hit matches 1 if score #ed_life editor = #ed_min_life editor run function rhythm_axe:editor/judge/hit
# 唱片机：点击命中 + 本刻最小寿命 → 收尾
execute if score @s editor_n_type matches 2 if score @s editor_n_hit matches 1 if score #ed_life editor = #ed_min_life editor run function rhythm_axe:editor/judge/hit
# 唱片机末刻兜底（life == -2x 仍未点击 → miss；命中的情况已由上一行按 goodL 判定）
execute if score @s editor_n_type matches 2 if score #ed_life editor = #ed_lo editor if score @s editor_n_hit matches 0 run function rhythm_axe:editor/judge/window_out

