# 同一刻判定限制（★ 2026-09-21 实装；规则见 音符.md《同一刻判定限制》）
# 动机：判定系统逐音符独立检测，同刻可以命中多个；原版「一次操作只作用一个目标」在这里不复用
#       ⇒ 需要自己的一条限制来定手感。
# 规则：同一刻内【某玩家】命中的音符里，只放行 note_life 最小（= time 最小、最靠前）的那一批；
#       time 相同的整批放行（多押）；每人每刻各限一批；保护中音符不算候选、不占名额。
# 范围：音符盒(0)/木板(1) 的视线判定。
#       唱片机(2) 原版每刻每玩家只能与一个交互实体交互 ⇒ 天然单目标，加不加结果相同
#       （实现上保持规则一致，不做额外门控）；混凝土(3)/玻璃(4) 不适用（分段/碰撞扣血，不进 combo）。
# 实现：每个玩家两遍（见 st_player）——
#       ① 扫全部交互实体：命中者打 looked_at（判定 + 保护记录共用）+ st_hit，并求本玩家最小寿命 #st_min
#       ② 只扫带 st_hit 的音符：重新确认「本玩家命中」后，life == #st_min 的打 st_pass
#       判定侧（judgement / main_plank 的分支 B）只放行带 st_pass 的音符；保护分支不受限。
# 调用：由 active_note 每刻在 move_self 之后、interact_judge 之前调用一次
#       （命中检测必须与配额来自同一份快照；交互实体位置已由 move_self 更新到当前刻）。
# ★ auto 模式下玩家不参与判定（走 judgement/auto_note）⇒ 整段跳过
execute if score auto play_state matches 1 run return 0
execute as @a[tag=playing] run function rhythm_axe:play/judgement/st_player
