# 最后一刻视线兜底（@s = 唱片机交互实体，interacted 无点击标记）
# 判定保护（★ 2026-09-29 放宽为「窗口内相交过」）：goodL 最后一刻（寿命 == -2x）仍未通过点击取得判定：
#   判定窗口 [3x, -2x] 内任一刻视线与唱片机相交过（note_jb_seen）→ good_late；全程未相交过 → miss
# 视线检测：检测玩家看着的交互实体（interaction hitbox 包裹展示模型，看模型即命中交互实体）
#   ⚠️ display（item_display）无 hitbox，无法被 looking_at 射线选中，不能检测 display
#   ★ 记录改由 main_jukebox 每刻调 jukebox_seen 维护（窗口内每刻检测、命中即打 note_jb_seen 且不再扫），
#     本函数只读标记 —— 末刻那一下也已被本刻（main_jukebox 先于本函数）记录进去，无需再扫谓词
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
# 寿命 == -2x：窗口内相交过 → 按当前寿命（= goodL）判定；全程未相交过 → miss
#   ⚠️ 直接用 @s note_life 比较（不经 #life 中转）：clicked_check 判定后已 scoreboard reset @s，
#      已判定的音符没有 note_life ⇒ 条件天然不成立，不会在已删除实体上重复判定（旧版靠 #life 中转会残留旧值）
execute if score @s note_life = #tn2 play_state if entity @s[tag=note_jb_seen] run scoreboard players operation #judge_life play_state = @s note_life
execute if score @s note_life = #tn2 play_state if entity @s[tag=note_jb_seen] run function rhythm_axe:play/judgement/judge
execute if score @s note_life = #tn2 play_state unless entity @s[tag=note_jb_seen] run scoreboard players set #judge_life play_state -999
execute if score @s note_life = #tn2 play_state unless entity @s[tag=note_jb_seen] run function rhythm_axe:play/judgement/judge
