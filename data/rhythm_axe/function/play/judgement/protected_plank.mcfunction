# 木板判定保护分支（@s = 木板交互实体，note_protect = 1）
# 保护期 [3x,0]：视线相交 → 记录寿命（与音符盒相同）
# 寿命==0 → 结算（恒大P：有记录或当前看着均判）
# 无记录(哨兵-1)且寿命==0 没看着 → 等同无保护不结算（由 active_note 出窗静默清除）
# 出窗（寿命 < -2x）由 active_note 的全局检查静默清除，本函数不处理 miss

# 保护期上界 = 3x
scoreboard players operation #protect_high play_state = #judgement_scale play_state
scoreboard players operation #protect_high play_state *= 3 const

# 保护期内视线相交 → 记录寿命
execute if score #life play_state <= #protect_high play_state if score #life play_state >= 0 const if entity @s[tag=looked_at] run scoreboard players operation @s note_recorded_life = #life play_state

# 寿命==0 → 结算（恒大P）
# 有记录（含0）→ 大P
execute if score #life play_state matches 0 if score @s note_recorded_life matches 0.. run scoreboard players set #judge_life play_state 0
execute if score #life play_state matches 0 if score @s note_recorded_life matches 0.. run function rhythm_axe:play/judgement/judge
# 无记录(哨兵-1)且看着 → 大P（等同无保护）
execute if score #life play_state matches 0 if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run scoreboard players set #judge_life play_state 0
execute if score #life play_state matches 0 if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge
