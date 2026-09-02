# 最后一刻视线兜底（@s = 唱片机交互实体，interacted 无点击标记）
# 判定保护：goodL 最后一刻（寿命 == -2x）仍未通过点击取得判定：
#   玩家视线与唱片机（展示模型）相交 → good_late；相离 → miss
scoreboard players operation #life play_state = @s note_life
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
# ★ predicate 限窗（优化3，2026-08-09）：本函数每 tick 无条件被 main_jukebox 调用，
#   但 looked_at 只在寿命 == -2x（goodL 末刻兜底）那一刻消费；其余 tick 检测了也没人用
#   → 限定 -2x 那刻才做 predicate 扫描（唱片机存活期长，省大头）
# 视线检测：检测玩家看着的交互实体（interaction hitbox 包裹展示模型，看模型即命中交互实体）
#   ⚠️ display（item_display）无 hitbox，无法被 looking_at 射线选中，不能检测 display
# ★ 距离基准 = 玩家视线位置（2026-08-09 用户确认）：positioned ~ ~-1.62 ~ 使 distance 测音符→玩家眼睛
execute if score #life play_state = #tn2 play_state run tag @s add to_be_looked_at
execute if score #life play_state = #tn2 play_state positioned ~ ~-1.62 ~ if entity @a[sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run tag @s add looked_at
execute if score #life play_state = #tn2 play_state run tag @s remove to_be_looked_at
# 寿命 == -2x：视线相交 → 按当前寿命（= goodL）判定；相离 → miss
execute if score #life play_state = #tn2 play_state if entity @s[tag=looked_at] run scoreboard players operation #judge_life play_state = @s note_life
execute if score #life play_state = #tn2 play_state if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge
execute if score #life play_state = #tn2 play_state unless entity @s[tag=looked_at] run scoreboard players set #judge_life play_state -999
execute if score #life play_state = #tn2 play_state unless entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge
