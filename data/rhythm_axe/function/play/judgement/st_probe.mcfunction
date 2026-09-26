# 同一刻判定限制 · 第一遍（@s = 音符交互实体，执行位置 = 音符；本玩家 = @a[tag=st_me]）
# 命中检测：原来写在 judgement / main_plank 里的那块 predicate 检测搬到这里（窗口与原来一致 = life<=3x）。
#   命中 → 音符侧打 looked_at（判定 + 保护记录共用）与 st_hit（第二遍的筛子）。
# ★ 参与配额（更新 #st_min）的条件 = 非保护中、**life > 0**（还没到判定位置）、且是**音符盒**；
#   life <= 0 的音符不参与竞争（已到判定位置，同刻可各自独立判定，见 st_mark）；
#   木板飞行期命中只记录、不当场判 ⇒ **永不当候选**（占了名额也不用 = 白白压制别人）。
# ★ 只处理音符盒(0)/木板(1)：唱片机(2) 天然单目标、混凝土(3)/玻璃(4) 不适用
execute unless entity @s[tag=note_noteblock] unless entity @s[tag=note_plank] run return 0
# 3x：命中检测窗口上界（与 judgement 的 #protect_high / main_plank 原 #look_high 同为 3x）
scoreboard players operation #st_h3 play_state = #judgement_scale play_state
scoreboard players operation #st_h3 play_state *= 3 const
execute if score @s note_life > #st_h3 play_state run return 0
# 视线命中（命中范围 = 交互实体 width/height = 音符大小）
# ★ 距离基准 = 玩家视线位置：执行位置下移 1.62 格后，distance 等价于测「音符 → 玩家眼睛」
# ★ 2026-09-26 判定延迟补偿：客机先按他自己的 RTT 把判定箱回退（st_lag_apply）再测。
#   ⚠ 距离筛量的是 at @s 在 [调用本函数时] 捕获的执行位置，不会随实体 Pos 更新 ⇒
#     这里仍按 ..4.5（= 补偿前同一把尺子）；st_mark 是重新 at @s（已是回退后的位置），那边才需要放宽。
tag @s add to_be_looked_at
scoreboard players set #st_seen play_state 0
execute if score #st_lag play_state matches 1.. run function rhythm_axe:play/judgement/st_lag_apply
execute positioned ~ ~-1.62 ~ if entity @a[tag=st_me,distance=..4.5,predicate=rhythm_axe:looking_at] run scoreboard players set #st_seen play_state 1
tag @s remove to_be_looked_at
execute if score #st_seen play_state matches 0 run return 0
tag @s add looked_at
tag @s add st_hit
# ===== 是否参与本刻配额 =====
# 保护中音符不算候选、不占名额（其 life==0 结算不受本限制约束，见 judgement/protected*）
execute if score @s note_protect matches 1 run return 0
# ★ 2026-09-26：竞争只约束「还在飞向判定位置」的音符盒（life > 0）；life <= 0 不参与（st_mark 直接放行）
execute unless entity @s[tag=note_noteblock] run return 0
execute unless score @s note_life matches 1.. run return 0
# 命中且 life > 0 → 参与配额（取最小）
execute if score @s note_life < #st_min play_state run scoreboard players operation #st_min play_state = @s note_life
