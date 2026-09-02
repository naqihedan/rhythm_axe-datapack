# 音符判定核心（@s = 音符交互实体；每 tick 由 active_note/active_note 调用）
# M2-C：音符盒判定（视线检测 + 判定保护）
# 流程：
#   1. 临时加 to_be_looked_at 标签，检测玩家是否看着本音符
#   2. 判定保护：bad 前一刻（寿命=3x+1）视线相交 → 进入保护，记录寿命
#   3. 非保护：寿命在判定窗口内（<=3x）且视线相交 → 立即判定
#      （寿命 > 3x 时音符尚未进入任何判定窗口，不做判定，避免提前看着就 miss）
#   4. 保护中：寿命=0 → 按记录寿命判定

# 先复制当前寿命到 #life（供 level_from_life 使用）
scoreboard players operation #life play_state = @s note_life

# ===== 检测玩家是否看着本音符（原版 looking_at 精确命中音符 hitbox）=====
# ★ predicate 限窗（优化3，2026-08-09）：looked_at 只被分支B（寿命<=3x）和保护期
#   记录（保护期 [3x,0]，见 protected）消费；寿命 > 3x = 音符还在飞向判定位置，
#   检测了也没人用 → 跳过整个 predicate 扫描（省每 tick 对所有远处音符的 @a 扫描 + 谓词评估）。
#   保护进入（3x+1）用的是 looked_at_perfect（raycast 打标），不走 predicate，故 3x+1 也不需要。
# 先算 3x（bad 区间上界；与下方分支 B 共用，避免重复计算）
scoreboard players operation #protect_high play_state = #judgement_scale play_state
scoreboard players operation #protect_high play_state *= 3 const
# 实际判定用原版 looking_at（命中范围 = 交互实体 width/height = 音符大小，方块形状）
# ★ 距离基准 = 玩家视线位置（2026-08-09 用户确认）：@a[distance] 默认测玩家脚底，
#   下移执行位置 1.62 格（positioned ~ ~-1.62 ~）后等价于测"音符→玩家眼睛"距离，
#   与 looking_at 射线（从眼睛出发）基准统一；sort=nearest 对全体玩家排序不受影响
execute if score #life play_state <= #protect_high play_state run tag @s add to_be_looked_at
execute if score #life play_state <= #protect_high play_state positioned ~ ~-1.62 ~ if entity @a[sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run tag @s add looked_at
execute if score #life play_state <= #protect_high play_state run tag @s remove to_be_looked_at
# looked_at_perfect 由 active_note 的射线步进统一打标（检测判定位置的展示实体，无碰撞箱不挡视线）

# ===== 判定保护检查 =====
# 进入保护条件：寿命 == 3x+1（bad 前一刻，bad 区间 [2x+1,3x] 的上界+1）
#   且此时玩家视线经过完美判定区域（判定位置）→ 提前瞄准保护
# 先算 3x+1
scoreboard players operation #protect_enter play_state = #judgement_scale play_state
scoreboard players operation #protect_enter play_state *= 3 const
scoreboard players add #protect_enter play_state 1
# 若寿命 == 3x+1 且 looked_at_perfect → 进入保护
execute if score #life play_state = #protect_enter play_state if score @s note_protect matches 0 if entity @s[tag=looked_at_perfect] run scoreboard players set @s note_protect 1

# ===== 判定逻辑 =====
# 分支 A：处于保护状态
execute if score @s note_protect matches 1 run function rhythm_axe:play/judgement/protected
# 分支 B：未保护、玩家看着且寿命在判定窗口内（<=3x，#protect_high 已在上方算好）→ 立即判定（用当前寿命）
execute if score @s note_protect matches 0 if score #life play_state <= #protect_high play_state if entity @s[tag=looked_at] run scoreboard players operation #judge_life play_state = @s note_life
execute if score @s note_protect matches 0 if score #life play_state <= #protect_high play_state if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge

# 视线标记统一由 active_note 每 tick 清理（此处不再清理）
