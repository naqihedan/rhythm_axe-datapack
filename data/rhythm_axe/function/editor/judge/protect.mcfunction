# 编辑器真实判定：判定保护分支（@s = 编辑器音符展示实体，editor_n_protect = 1）
# 照搬游玩 protected（音符盒 0）/ protected_plank（木板 1），并按《判定保护情况下音符取得判定的几种情况》对齐：
#   「看着」= 视线与【音符】相交（@s editor_n_hit = judge/probe 的命中标记）
#             **或** 视线在【完美判定区域】内（editor_n_looked_perfect = raycast，判定位置为中心）
#     —— 完美判定区域固定在判定位置不动 ⇒「从出生一直盯着判定位置看」也算一直看着
#        （文档情况 2-A：直到取得大P准星一直在完美判定区域 ⇒ 大P）
#     ⚠ 只认 @s editor_n_hit 会漏掉这种打法：life>0 时音符还在飞行、不在判定位置，盯着判定位置也命中不到音符，
#       会导致“全程盯着判定位置”反而一条记录都没有 → life==0 不结算 → 落到 life<0 判成 PL
#     ⚠ 另一处时序：tick_one 是「先判定后 place」，life==0 那刻交互实体还停在上一刻位置，更难被命中；
#       而 raycast 判定的是展示实体 Pos（恒 = 判定位置，不受 place 时序影响）→ 由它兜住
#   保护期 [3x, 0] 内「看着」→ 记录寿命（editor_n_rec_life）；期间**暂不判定**
#   life == 0 → 结算：
#     音符盒：有记录 且 看着 → 大P；有记录 但 不看着 → 按记录寿命；无记录 且 看着 → 大P；
#             无记录 且 不看着 → 不判（等同无保护：life<0 后由 note_check 的 #ed_pblock 放行到分支 B）
#     木板  ：有记录 或 看着 → 恒大P（木板无 bad/miss）；都没有 → 不判（出窗静默清除）
# 前置：#ed_life（当前寿命）、#ed_p3（3x）、@s editor_n_hit（本刻是否命中音符，由 judge/probe 写入）
# ★ 保护中的音符不算候选、不占名额 ⇒ 其 life==0 的结算**不受《同一刻判定限制》约束**
#   （保护结算时刻固定为寿命 0，推迟就破坏保护语义；文档规则表「保护中音符」一行的推论）
# ★ '寿命 >= 0' 必须写 `matches 0..`，不能写 `>= 0`（if score 右侧不支持裸常量；曾因此整函数加载失败）
# ★ 保护期内每刻记录（含 life == 0 那次，与游玩一致）
scoreboard players set #ed_see editor 0
execute if score @s editor_n_hit matches 1 run scoreboard players set #ed_see editor 1
execute if entity @s[tag=editor_n_looked_perfect] run scoreboard players set #ed_see editor 1
execute if score #ed_life editor matches 0.. if score #ed_life editor <= #ed_p3 editor if score #ed_see editor matches 1 run scoreboard players operation @s editor_n_rec_life = #ed_life editor
# 只在 life == 0 结算
execute unless score #ed_life editor matches 0 run return 0
# ---- 音符盒（type 0）----
# 有记录 + 看着 → 大P（life 保持 0）
execute if score @s editor_n_type matches 0 if score @s editor_n_rec_life matches 0.. if score #ed_see editor matches 1 run function rhythm_axe:editor/judge/hit
# 有记录 + 不看着 → 按记录寿命
execute if score @s editor_n_type matches 0 if score @s editor_n_rec_life matches 0.. unless score #ed_see editor matches 1 run scoreboard players operation #ed_life editor = @s editor_n_rec_life
execute if score @s editor_n_type matches 0 if score @s editor_n_rec_life matches 0.. unless score #ed_see editor matches 1 run function rhythm_axe:editor/judge/hit
# 无记录 + 看着 → 大P
execute if score @s editor_n_type matches 0 if score @s editor_n_rec_life matches ..-1 if score #ed_see editor matches 1 run function rhythm_axe:editor/judge/hit
# ---- 木板（type 1）：恒大P（hit 内部会把 life 视 0）----
execute if score @s editor_n_type matches 1 if score @s editor_n_rec_life matches 0.. run function rhythm_axe:editor/judge/hit
execute if score @s editor_n_type matches 1 if score @s editor_n_rec_life matches ..-1 if score #ed_see editor matches 1 run function rhythm_axe:editor/judge/hit
