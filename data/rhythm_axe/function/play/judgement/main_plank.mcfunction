# 木板判定核心（@s = 木板交互实体；interact_judge 每 tick 在寿命 <= 3x+1 时调用）
# M2-D：木板判定（简化版音符盒）
# 规则：
#   - 视线与木板相交 → 判定，恒转换为大P（#judge_life 直接设 0）
#   - **判定天然是「先记录、后结算」**（★ 2026-09-26）：未抵达判定位置（寿命 >= 1）时被视线穿透
#     → **只记录、不当场判**；抵达判定位置及之后（寿命 <= 0）→ 有记录，或此刻被注视 → **一定判大P**
#     （`note_recorded_life`：-1 = 无记录，summon 初始化；有记录一律记 0，因为判定恒转大P）
#   - 没有 bad 判定（bad 区间 [2x+1,3x] 内看着也不判定）
#   - 没有 miss 判定（出窗由 active_note 的全局检查静默清除，见 clear_note）
#   - ★ 2026-09-26：木板**不再需要单独的「提前瞄准保护」** —— 它天然就是「记录 + 延迟结算」，
#     与保护的效果完全重合（保护原本只是把结算点锁死在寿命 0、并让记录窗口含寿命 0，两者对结果无影响）。
#     删除后木板只有一条判定路径，行为更统一；`note_protect` 对木板恒为 0。
#   - ★ 同刻限制（《同一刻判定限制》）：木板只在寿命 <= 0 判 ⇒ 不参与「最小寿命竞争」，
#     故不需要 st_pass 门控（life <= 0 的音符在 same_tick/st_mark 里无条件放行）。
# 流程（命中检测已搬到 same_tick/st_probe，本函数只读它打好的 looked_at）：
#   1. 记录：寿命 >= 1 且被注视 → note_recorded_life = 0
#   2. 结算：寿命 <= 0 且（有记录 或 此刻被注视）→ 判大P

# 复制当前寿命
scoreboard players operation #life play_state = @s note_life

# ① 飞行期（寿命 >= 1）被注视 → 记录（检测窗上界由 st_probe 的 life <= 3x 天然限制）
execute if score #life play_state matches 1.. if entity @s[tag=looked_at] run scoreboard players set @s note_recorded_life 0
# ② 抵达判定位置及之后（寿命 <= 0）且有记录 → 判大P（不需仍被注视）
execute if score #life play_state matches ..0 if score @s note_recorded_life matches 0.. run scoreboard players set #judge_life play_state 0
execute if score #life play_state matches ..0 if score @s note_recorded_life matches 0.. run function rhythm_axe:play/judgement/judge
# ③ 抵达判定位置及之后、无记录但此刻被注视 → 判大P
execute if score #life play_state matches ..0 if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run scoreboard players set #judge_life play_state 0
execute if score #life play_state matches ..0 if score @s note_recorded_life matches ..-1 if entity @s[tag=looked_at] run function rhythm_axe:play/judgement/judge

# 视线标记统一由 active_note 每 tick 清理（此处不再清理）
