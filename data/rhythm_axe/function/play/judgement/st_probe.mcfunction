# 同一刻判定限制 · 第一遍（@s = 音符交互实体，执行位置 = 音符；本玩家 = @a[tag=st_me]）
# 命中检测：原来写在 judgement / main_plank 里的那块 predicate 检测搬到这里（窗口与原来一致 = life<=3x）。
#   命中 → 音符侧打 looked_at（判定 + 保护记录共用）与 st_hit（第二遍的筛子）。
# 参与配额（更新 #st_min）的额外条件：非保护中、寿命在判定窗 [−2x, hi]（木板 hi=2x，无 bad 段）。
# ★ 只处理音符盒(0)/木板(1)：唱片机(2) 天然单目标、混凝土(3)/玻璃(4) 不适用
execute unless entity @s[tag=note_noteblock] unless entity @s[tag=note_plank] run return 0
# 3x：命中检测窗口上界（与 judgement 的 #protect_high / main_plank 原 #look_high 同为 3x）
scoreboard players operation #st_h3 play_state = #judgement_scale play_state
scoreboard players operation #st_h3 play_state *= 3 const
execute if score @s note_life > #st_h3 play_state run return 0
# 视线命中（命中范围 = 交互实体 width/height = 音符大小）
# ★ 距离基准 = 玩家视线位置：执行位置下移 1.62 格后，distance 等价于测「音符 → 玩家眼睛」
tag @s add to_be_looked_at
scoreboard players set #st_seen play_state 0
execute positioned ~ ~-1.62 ~ if entity @a[tag=st_me,distance=..4.5,predicate=rhythm_axe:looking_at] run scoreboard players set #st_seen play_state 1
tag @s remove to_be_looked_at
execute if score #st_seen play_state matches 0 run return 0
tag @s add looked_at
tag @s add st_hit
# ===== 是否参与本刻配额 =====
# 保护中音符不算候选、不占名额（其 life==0 结算不受本限制约束，见 judgement/protected*）
execute if score @s note_protect matches 1 run return 0
# 判定窗下界 −2x
scoreboard players operation #st_lo play_state = #judgement_scale play_state
scoreboard players operation #st_lo play_state *= -2 const
execute if score @s note_life < #st_lo play_state run return 0
# 判定窗上界：木板 2x（bad 区间内命中也不判，无 bad 段）；音符盒 3x
scoreboard players operation #st_hi play_state = #st_h3 play_state
execute if entity @s[tag=note_plank] run scoreboard players operation #st_hi play_state = #judgement_scale play_state
execute if entity @s[tag=note_plank] run scoreboard players operation #st_hi play_state *= 2 const
execute if score @s note_life > #st_hi play_state run return 0
# 命中且在判定窗内 → 参与配额（取最小）
execute if score @s note_life < #st_min play_state run scoreboard players operation #st_min play_state = @s note_life
