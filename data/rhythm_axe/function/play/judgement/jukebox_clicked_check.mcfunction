# 点击判定（@s = 唱片机交互实体，interacted 通用点击标记 >= 1）
# 判定窗口 = [3x, -2x]（bad 上界 ~ goodL 末刻，包含 bad/goodE/perfectE/P/pL/goodL 全等级）
# 在窗口内 → 按当前寿命判定；窗口外（过早/过晚点击）→ 忽略并清除标记
scoreboard players operation #life play_state = @s note_life
# 上界 3x、下界 -2x
scoreboard players operation #tmp3 play_state = #judgement_scale play_state
scoreboard players operation #tmp3 play_state *= 3 const
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
# 窗口内 → 判定（按当前寿命）
execute if score #life play_state <= #tmp3 play_state if score #life play_state >= #tn2 play_state run scoreboard players operation #judge_life play_state = @s note_life
execute if score #life play_state <= #tmp3 play_state if score #life play_state >= #tn2 play_state run function rhythm_axe:play/judgement/judge
# 窗口外（过早/过晚）→ 忽略并清除标记
scoreboard players set @s interacted 0
