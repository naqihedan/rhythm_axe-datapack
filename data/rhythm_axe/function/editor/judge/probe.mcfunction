# 编辑器真实判定：同刻候选预扫（@s = 编辑器音符展示实体；at @s 由 visual/tick 提供）
# 目的：《同一刻判定限制》——同一刻内每个玩家只放行 note_life 最小（= time 最小、最靠前）的那一批候选取得判定，
#       time 相同的整批放行。判定不能依赖逐音符的遍历顺序，故必须「先扫一遍求最小寿命、再判」。
# 输出：
#   #ed_min_life     本刻候选的最小寿命（无候选时保持 999999 ⇒ note_check 的判定门控全部不成立）
#   @s editor_n_hit  1 = 本刻命中（视线 / 点击）⇒ 供 note_check、protect 复用（视线检测每刻只做一次）
# 候选 = **仅音符盒（type 0）**：木板（1）飞行期命中不当场判、唱片机（2）点击天然单目标、混凝土/玻璃不适用 ⇒ 都排除；
#        条件 = 未判定、非保护中、寿命 **> 0**（还没到判定位置）、且本刻命中
#   · 命中检测窗 = [−2x, 3x]（所有类型一致）
#   · ★ 2026-09-26：竞争只约束 life > 0 的音符 —— life <= 0（已抵达判定位置）不参与竞争，
#     note_check 直接放行（同刻可多个一起判）；木板永不当候选（占名额也不用 = 白白压制别人）
#   · 保护进入刻（life == 3x+1 > 3x）天然不在窗口内
#   · 保护中音符不算候选、不占名额，但仍需本刻命中标记（protect 记录寿命要用）⇒ 命中检测放在排除之前
# 编辑器同一时刻只有一位编辑者，故 #ed_min_life 用全局临时量（游玩侧为「每玩家各限一批」）
execute if entity @s[tag=editor_n_triggered] run return fail
execute unless score @s editor_n_type matches 0..2 run return fail
scoreboard players set @s editor_n_hit 0
scoreboard players operation #ed_life editor = @s editor_n_time
scoreboard players operation #ed_life editor -= #playhead editor
# 命中检测窗口上界 = 3x（所有类型一致；2026-09-26：木板不再用 2x —— 它的「判定时机」已整体推迟，
#   但飞行期仍需要本刻命中标记来做记录，故检测窗口与音符盒保持一致）
scoreboard players operation #ed_pp_hi editor = #ed_scale editor
scoreboard players operation #ed_pp_hi editor *= 3 const
execute if score #ed_life editor > #ed_pp_hi editor run return fail
scoreboard players operation #ed_pp_lo editor = #ed_scale editor
scoreboard players operation #ed_pp_lo editor *= -2 const
execute if score #ed_life editor < #ed_pp_lo editor run return fail
# ===== 本刻命中检测（写 @s editor_n_hit）=====
# 唱片机（type 2）：消费点击标记（按 note_id 精确配对；标记由 input_click 在玩家点击瞬间打上）
scoreboard players set #ed_hit editor 0
scoreboard players operation #ed_nid editor = @s note_id
execute if score @s editor_n_type matches 2 as @e[type=interaction,tag=editor_note,tag=editor_n_clicked] if score @s note_id = #ed_nid editor run scoreboard players set #ed_hit editor 1
execute if score #ed_hit editor matches 1 run scoreboard players set @s editor_n_hit 1
# 音符盒/木板（type 0/1）：视线命中（配对交互实体打临时标签 → 谓词检测 → 撤标签）
execute unless score @s editor_n_type matches 2 run function rhythm_axe:editor/judge/look_check
# ===== 候选 ⇒ 更新最小寿命（保护中不算候选、不占名额）=====
execute if score @s editor_n_protect matches 1 run return fail
# ★ 2026-09-26：竞争只约束「还在飞向判定位置」的音符（life > 0）；life <= 0 不参与（note_check 直接放行）
execute unless score #ed_life editor matches 1.. run return fail
# ★ 只有音符盒（type 0）参与竞争：木板飞行期命中只记录、不当场判（占了名额也不用 = 白白压制别人）；
#   唱片机点击天然单目标（原版每刻每玩家只能与一个交互实体交互），不需要此限制
execute unless score @s editor_n_type matches 0 run return fail
# 命中 → 参与配额（取最小）
execute if score @s editor_n_hit matches 1 if score #ed_life editor < #ed_min_life editor run scoreboard players operation #ed_min_life editor = #ed_life editor
