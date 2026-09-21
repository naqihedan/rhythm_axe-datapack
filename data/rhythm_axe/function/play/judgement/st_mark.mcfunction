# 同一刻判定限制 · 第二遍（@s = 带 st_hit 的音符，执行位置 = 音符；本玩家 = @a[tag=st_me]）
# 第一遍已确认「存在某玩家命中且在本刻配额窗内」，此处只做两件事：
#   ① 重新确认「**本玩家**命中」—— st_hit / looked_at 都是「任意玩家」口径，
#      而本限制要的是「每人每刻各限一批」，所以必须逐玩家重测；
#   ② life == #st_min ⇒ 打 st_pass（判定侧只放行带它的音符）。
# 窗口/保护过滤不必重复：带 st_hit 就说明第一遍已通过（过滤只取决于音符自身与判定缩放）
tag @s add to_be_looked_at
scoreboard players set #st_seen play_state 0
execute positioned ~ ~-1.62 ~ if entity @a[tag=st_me,distance=..4.5,predicate=rhythm_axe:looking_at] run scoreboard players set #st_seen play_state 1
tag @s remove to_be_looked_at
execute if score #st_seen play_state matches 0 run return 0
execute if score @s note_life = #st_min play_state run tag @s add st_pass
