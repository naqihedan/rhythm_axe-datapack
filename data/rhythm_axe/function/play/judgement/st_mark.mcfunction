# 同一刻判定限制 · 第二遍（@s = 带 st_hit 的音符，执行位置 = 音符；本玩家 = @a[tag=st_me]）
# 第一遍已确认「存在某玩家命中且在本刻配额窗内」，此处只做两件事：
#   ① 重新确认「**本玩家**命中」—— st_hit / looked_at 都是「任意玩家」口径，
#      而本限制要的是「每人每刻各限一批」，所以必须逐玩家重测；
#   ② 放行：life <= 0（已抵达判定位置）的直接放行，不受竞争约束；life > 0 的须 life == #st_min。
# 窗口/保护过滤不必重复：带 st_hit 就说明第一遍已通过（过滤只取决于音符自身与判定缩放）
# ★ 2026-09-26 判定延迟补偿：判定箱已由 st_probe 按本玩家 RTT 回退过（st_lag_apply），
#   这里只重测、**不要重复回退**（再回退一次就等于回到没补偿的位置）。
#   ⚠ 本函数重新 at @s ⇒ 距离是量在**回退后**的位置上（比补偿前离玩家更远），
#     故补偿时把上限放宽到 6 格，否则刚进窗口的音符会在第二遍被筛掉。
tag @s add to_be_looked_at
scoreboard players set #st_seen play_state 0
execute if score #st_lag play_state matches 0 positioned ~ ~-1.62 ~ if entity @a[tag=st_me,distance=..4.5,predicate=rhythm_axe:looking_at] run scoreboard players set #st_seen play_state 1
execute if score #st_lag play_state matches 1.. positioned ~ ~-1.62 ~ if entity @a[tag=st_me,distance=..6,predicate=rhythm_axe:looking_at] run scoreboard players set #st_seen play_state 1
tag @s remove to_be_looked_at
execute if score #st_seen play_state matches 0 run return 0
# ★ 2026-09-26 诊断（lv.1）：判定箱按本玩家 RTT 回退了几刻（验证多人延迟补偿是否生效）
execute if score debug_output options matches 1.. if score #st_lag play_state matches 1.. run tellraw @a ["",{"text":"[调试.lv1][延迟补偿]","color":"gold"},{"text":" id=","color":"gray"},{"score":{"objective":"note_id","name":"@s"}},{"text":" 回退=","color":"gray"},{"score":{"objective":"play_state","name":"#st_lag"}},{"text":"刻","color":"gray"}]
# ★ 2026-09-26：life <= 0（已抵达判定位置）→ 不参与竞争，直接放行，同刻多个可同时判定
execute if score @s note_life matches ..0 run tag @s add st_pass
# life > 0 → 只有抢到本刻最小寿命（#st_min）才放行
execute if score @s note_life matches 1.. if score @s note_life = #st_min play_state run tag @s add st_pass
