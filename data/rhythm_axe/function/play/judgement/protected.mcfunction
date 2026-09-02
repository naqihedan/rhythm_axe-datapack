# 判定保护分支（@s = 音符交互实体，note_protect = 1）
# 保护期 [3x, 0]（寿命 3x 到 0）：
#   - 视线相交（looked_at）→ 记录寿命（note_recorded_life = 当前寿命），不判定
#   - 寿命 == 0 → 结算：
#       * 有记录且当前看着 → 大P（按 #life=0）
#       * 有记录但当前没看着 → 按最后记录寿命判定
#       * 无记录 → 等同无保护（当前看着则按 #life=0 判定）
# 保护期后（寿命 < 0）仍无判定 → 出窗判定（goodL/miss）

# 保护期上界 = 3x
scoreboard players operation #protect_high play_state = #judgement_scale play_state
scoreboard players operation #protect_high play_state *= 3 const

# 在保护期 [3x, 0] 内视线相交 → 记录寿命（note_recorded_life = 当前寿命）
execute if score #life play_state <= #protect_high play_state if score #life play_state >= 0 const if entity @s[tag=looked_at] run scoreboard players operation @s note_recorded_life = #life play_state

# 寿命 == 0 → 结算
# 有记录（含 0，即保护期一直看到寿命 0）且当前看着 → 大P（#judge_life = 0）
execute if score #life play_state matches 0 if score @s note_recorded_life matches 0.. if entity @s[tag=looked_at] run scoreboard players set #judge_life play_state 0
# 有记录但当前没看着 → 按最后记录寿命判定
execute if score #life play_state matches 0 if score @s note_recorded_life matches 0.. unless entity @s[tag=looked_at] run scoreboard players operation #judge_life play_state = @s note_recorded_life
execute if score #life play_state matches 0 if score @s note_recorded_life matches 0.. run function rhythm_axe:play/judgement/judge

# 寿命 == 0 但从未记录（note_recorded_life 为负数哨兵 -1）→ 等同无保护：当前看着则按 #life=0 判定
execute if score #life play_state matches 0 if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run scoreboard players set #judge_life play_state 0
execute if score #life play_state matches 0 if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge

# 出窗：保护期后（寿命 < 0）无判定，寿命越过 goodL 末刻（< -2x）→ miss
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
execute if score #life play_state < #tn2 play_state run scoreboard players set #judge_life play_state -999
execute if score #life play_state < #tn2 play_state run function rhythm_axe:play/judgement/judge
