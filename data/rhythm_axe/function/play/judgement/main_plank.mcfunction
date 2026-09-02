# 木板判定核心（@s = 木板交互实体；每 tick 由 active_note/active_note 调用）
# M2-D：木板判定（简化版音符盒）
# 规则：
#   - 视线与木板相交则判定，判定恒转换为大P（#judge_life 直接设 0）
#   - 没有 bad 判定（bad 区间 [2x+1,3x] 内看着也不判定）
#   - 没有 miss 判定（出窗由 active_note 的全局检查静默清除，见 clear_note）
#   - 判定保护与音符盒相同：bad 前一刻（寿命=3x+1）看着 → 进入保护，
#     保护期 [3x,0] 记录寿命，寿命0 结算（恒大P）
# 流程：
#   1. 检测玩家是否看着本音符
#   2. 判定保护检查
#   3. 分支A保护/protected_plank；分支B非保护且寿命在 goodE 及之后（<=2x）→ 判大P

# 复制当前寿命
scoreboard players operation #life play_state = @s note_life

# ===== 检测玩家是否看着本音符（原版 looking_at 精确命中音符 hitbox）=====
# ★ predicate 限窗（优化3，2026-08-09）：looked_at 被分支B（寿命<=2x）和保护期
#   记录（保护期 [3x,0]，见 protected_plank）消费；寿命 > 3x = 音符还在飞向判定位置，
#   检测了也没人用 → 跳过整个 predicate 扫描。
#   保护进入（3x+1）用的是 looked_at_perfect（raycast 打标），不走 predicate，故 3x+1 也不需要。
# 先算 3x（保护期上界；分支 B 的 2x 在下方算）
scoreboard players operation #look_high play_state = #judgement_scale play_state
scoreboard players operation #look_high play_state *= 3 const
# 实际判定用原版 looking_at（命中范围 = 交互实体 width/height = 音符大小，方块形状）
# ★ 距离基准 = 玩家视线位置（2026-08-09 用户确认）：positioned ~ ~-1.62 ~ 使 distance 测音符→玩家眼睛
execute if score #life play_state <= #look_high play_state run tag @s add to_be_looked_at
execute if score #life play_state <= #look_high play_state positioned ~ ~-1.62 ~ if entity @a[sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run tag @s add looked_at
execute if score #life play_state <= #look_high play_state run tag @s remove to_be_looked_at
# looked_at_perfect 由 active_note 的射线步进统一打标（检测判定位置的展示实体，无碰撞箱不挡视线）

# ===== 判定保护检查 =====
# 进入保护：寿命 == 3x+1 且此时玩家视线经过完美判定区域（判定位置）（与音符盒相同）
scoreboard players operation #protect_enter play_state = #judgement_scale play_state
scoreboard players operation #protect_enter play_state *= 3 const
scoreboard players add #protect_enter play_state 1
execute if score #life play_state = #protect_enter play_state if score @s note_protect matches 0 if entity @s[tag=looked_at_perfect] run scoreboard players set @s note_protect 1

# ===== 判定逻辑 =====
# 先算 2x（goodE 上界；bad 区间 [2x+1,3x] 不判定，寿命 <=2x 才判定）
scoreboard players operation #protect_high play_state = #judgement_scale play_state
scoreboard players operation #protect_high play_state *= 2 const
# 分支 A：保护状态
execute if score @s note_protect matches 1 run function rhythm_axe:play/judgement/protected_plank
# 分支 B：未保护、看着、寿命在 goodE 及之后（<=2x）→ 恒判大P（#judge_life=0）
execute if score @s note_protect matches 0 if score #life play_state <= #protect_high play_state if entity @s[tag=looked_at] run scoreboard players set #judge_life play_state 0
execute if score @s note_protect matches 0 if score #life play_state <= #protect_high play_state if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge

# 视线标记统一由 active_note 每 tick 清理（此处不再清理）
