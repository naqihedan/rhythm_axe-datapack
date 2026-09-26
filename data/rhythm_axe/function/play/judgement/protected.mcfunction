# 判定保护分支（@s = 音符交互实体，note_protect = 1）
# 保护期 [3x, 0]（寿命 3x 到 0）：
#   - 视线相交（looked_at）→ 记录寿命（note_recorded_life = 当前寿命），不判定
#   - 寿命 == 0 → 结算：
#       * 有记录且当前看着 → 大P（按 #life=0）
#       * 有记录但当前没看着 → 按最后记录寿命判定
#       * 无记录 → 等同无保护（当前看着则按 #life=0 判定）
# ★ 保护期后（寿命 < 0）：
#   - 保护期内**从未相交**（无记录）⇒ 等同无保护 → 按“相交那一刻的寿命”继续判（perfectL/goodL）
#     （文档《判定保护情况下音符取得判定的几种情况》第 2 条第 3 款；与编辑器 judge/note_check 的 #ed_pblock 同一语义）
#   - 保护期内相交过（有记录）⇒ 不再补判（保护语义：结算点锁定在寿命 0）
#   - 越过 goodL 末刻（< -2x）仍未判 → miss

# 保护期上界 = 3x；出窗下界 = -2x
scoreboard players operation #protect_high play_state = #judgement_scale play_state
scoreboard players operation #protect_high play_state *= 3 const
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const

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

# ★ 保护期后（寿命 ∈ [-2x, -1]）且**从未记录** → 等同无保护：按当前寿命判（perfectL/goodL）
#   修复：旧版只在寿命 0 结算，导致“进保护后移开准星、之后再回来打”会直接 miss（游玩与编辑器/文档不一致）
execute if score #life play_state matches ..-1 if score #life play_state >= #tn2 play_state if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run scoreboard players operation #judge_life play_state = @s note_life
execute if score #life play_state matches ..-1 if score #life play_state >= #tn2 play_state if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge

# 出窗：寿命越过 goodL 末刻（< -2x）仍未判 → miss
execute if score #life play_state < #tn2 play_state run scoreboard players set #judge_life play_state -999
execute if score #life play_state < #tn2 play_state run function rhythm_axe:play/judgement/judge
