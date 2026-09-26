# 编辑器真实判定：单音符判定检查（@s = 编辑器音符展示实体；at @s 由 tick_one 保证）
# 调用条件：判定模式（options.editor_note_judge=1）且播放中（tick_one 内分流；自动预览模式不走这里）
# 窗口：life = editor_n_time − #playhead（正=音符还在飞来，负=已过判定位置）；x = #ed_scale（当前时间点 judgment_scale）
#   检测期 [3x, -2x]（3x = 保护期上界）
#   立即判定窗（分支 B）音符盒/唱片机 [3x, -2x]；木板见下
#   ★ 木板（2026-09-26 改）：未抵达判定位置（life>=1）命中只记录，抵达及之后（life<=0）才判大P
#   ★ 同一刻判定限制（2026-09-26 改）：竞争只约束 life > 0 的候选；**life <= 0 不受竞争约束**（命中即判、同刻可多个）
#   life < -2x → 未命中收尾（木板静默清除、其余 miss，见 window_out）
# 命中输入（照搬游玩语义）：type 0/1（音符盒/木板）= 玩家视线命中；type 2（唱片机）= 玩家点击标记
# 判定保护（照搬游玩 protected；**只有音符盒** —— 木板天然是「先记录、后结算」，不需要保护状态；保护进入靠 judge/raycast 的射线步进）：
#   life == 3x+1 且本刻"视线经过**判定位置**（完美判定区域）" → 进入保护（**只置状态，绝不在此判定**）
#   保护中：保护期 [3x,0] 内「看着」→ 记录寿命（editor_n_rec_life），**暂不判定**；life==0 结算（见 judge/protect）
#     「看着」= 视线与**音符**相交（@s editor_n_hit）**或** 视线在**完美判定区域**内（editor_n_looked_perfect）
#   无记录（保护期内一次都没看着）⇒ 等同无保护：life<0 时放行到分支 B（#ed_pblock），按"相交那一刻的寿命"判
#   ⚠ 本刻 life == 3x+1 > 3x ⇒ 下面的 predicate 限窗会直接 return，不会意外走到"命中检测"
# 唱片机末刻兜底（照搬游玩 jukebox_late）：life == -2x 仍未点击 → 看向则 good_late，不看则 miss
# ★ 命中/未命中后立即清除音符对（与游玩「判定即消失」一致；自动预览模式的"到点消失"不受影响）
# ★ 《同一刻判定限制》（★ 2026-09-26 改）：只约束 life > 0 的候选 —— 同一刻只放行 note_life 最小
#   （= time 最小、最靠前）的那一批；**life <= 0（已抵达判定位置）不参与竞争，命中即判、同刻可多个一起判**。
#   候选集（**仅音符盒**）与最小寿命由 judge/probe 每刻预扫一次（#ed_min_life），命中标记写在各实体的 @s editor_n_hit 上；
#   本函数只读这两份结果（不再自己检测），保证「最小寿命」与「命中」来自同一份快照。
execute if entity @s[tag=editor_n_triggered] run return fail
scoreboard players operation #ed_life editor = @s editor_n_time
scoreboard players operation #ed_life editor -= #playhead editor
# 3x（检测期/保护期上界）与 3x+1（保护进入刻）
scoreboard players operation #ed_p3 editor = #ed_scale editor
scoreboard players operation #ed_p3 editor *= 3 const
scoreboard players operation #ed_p3e editor = #ed_p3 editor
scoreboard players add #ed_p3e editor 1
# -2x（窗口下界）
scoreboard players operation #ed_lo editor = #ed_scale editor
scoreboard players operation #ed_lo editor *= -2 const
# ===== 判定保护：进入检查（life == 3x+1 且本刻视线经过判定位置）=====
execute if score @s editor_n_type matches 0 if score #ed_life editor = #ed_p3e editor if score @s editor_n_protect matches 0 if entity @s[tag=editor_n_looked_perfect] run scoreboard players set @s editor_n_protect 1
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
#   若始终不相交，则由 window_out 收尾（音符盒 miss / 木板静默清除）。
scoreboard players set #ed_pblock editor 1
execute if score @s editor_n_protect matches 1 if score #ed_life editor matches ..-1 if score @s editor_n_rec_life matches ..-1 run scoreboard players set #ed_pblock editor 0
execute if score @s editor_n_protect matches 1 if score #ed_pblock editor matches 1 run return 0
# ===== 分支 B（未保护）=====
# ★ 同刻限制：life > 0 的候选须 life == #ed_min_life（被压制的本刻不判、不惩罚 —— 下刻寿命 -1 后重新参与，
#   若因此越过窗口则照常 miss）；**life <= 0 的命中不受竞争约束**，直接判、同刻可多个。
# ★ 木板（type 1）：判定天然是「先记录、后结算」（与游玩一致；★ 2026-09-26 起不再走判定保护分支）
#   未抵达判定位置（寿命 >= 1）被注视 → 只记录（editor_n_rec_life = 0），不当场判；
#   抵达判定位置及之后（寿命 <= 0）→ 有记录 或 此刻被注视 → 判大P（hit 内部把寿命视 0）。木板永不当候选 ⇒ 不看 #ed_min_life
#   ★「被注视」= 视线与【音符】相交（editor_n_hit）**或** 视线在【完美判定区域】内（editor_n_looked_perfect）
#     —— 后者兜住时序：tick_one 是「先判定后 place」，寿命 0 那刻交互实体还停在上一刻位置，只看 hit 会漏判
execute if score @s editor_n_type matches 1 if score #ed_life editor matches 1.. if score @s editor_n_hit matches 1 run scoreboard players set @s editor_n_rec_life 0
execute if score @s editor_n_type matches 1 if score #ed_life editor matches 1.. if entity @s[tag=editor_n_looked_perfect] run scoreboard players set @s editor_n_rec_life 0
execute if score @s editor_n_type matches 1 if score #ed_life editor matches ..0 if score @s editor_n_rec_life matches 0.. run function rhythm_axe:editor/judge/hit
execute if score @s editor_n_type matches 1 if score #ed_life editor matches ..0 if score @s editor_n_rec_life matches ..-1 if score @s editor_n_hit matches 1 run function rhythm_axe:editor/judge/hit
execute if score @s editor_n_type matches 1 if score #ed_life editor matches ..0 if score @s editor_n_rec_life matches ..-1 if entity @s[tag=editor_n_looked_perfect] run function rhythm_axe:editor/judge/hit
# ★ 音符盒（type 0）：life > 0 → 命中 + 本刻最小寿命才收尾；life <= 0 → 命中即收尾（不受竞争约束）
execute if score @s editor_n_type matches 0 if score #ed_life editor matches 1.. if score @s editor_n_hit matches 1 if score #ed_life editor = #ed_min_life editor run function rhythm_axe:editor/judge/hit
execute if score @s editor_n_type matches 0 if score #ed_life editor matches ..0 if score @s editor_n_hit matches 1 run function rhythm_axe:editor/judge/hit
# 唱片机（type 2）：点击命中即收尾。**不参与同刻限制** —— 原版每刻每玩家只能与一个交互实体交互，天然单目标
execute if score @s editor_n_type matches 2 if score @s editor_n_hit matches 1 run function rhythm_axe:editor/judge/hit
# 唱片机末刻兜底（life == -2x 仍未点击 → miss；命中的情况已由上一行按 goodL 判定）
execute if score @s editor_n_type matches 2 if score #ed_life editor = #ed_lo editor if score @s editor_n_hit matches 0 run function rhythm_axe:editor/judge/window_out

