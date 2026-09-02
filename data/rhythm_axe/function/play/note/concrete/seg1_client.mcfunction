# 混凝土段①：拉伸（客户端插值，仅线性 easing=1 power=1，2026-08-10 替换）
# @s = 混凝土展示实体（summon 出生时调用）
# 起点 = 出生局部状态（translation.z=-dist+size/2、scale.z=0，summon 已设）
# 段①终点（按模型）：
#   短 hold（m<=lt）：z1 = -dist×(2lt-m)/(2lt) + size/2；scale.z = len1 = dist×m/lt；时长 = m
#   长 hold（m>lt）：center = -dist/2 + size/2；scale.z = dist（满长）；时长 = lt
# ★ 2026-08-14：本函数只打 armed→pending 两阶段延迟（出生→终点隔 2 tick，见 active_note 根因注释），
#   不再预置插值参数——参数（duration + start=0）改由 seg1_merge 与段①终点【同一刻】下发
#   （wiki：同刻多次变更计为单个变更；时钟从终点到达时开始 → 无起步前跳）
# ★ 显式清 anim_status：段①不再由 display_animation 逐帧驱动

# 段①插值时长（★ 2026-08-14：短 = m（原 m-3）；长 = lt）
#   ★ m-3 是旧"参数出生刻预置"方案的补偿；现在参数与终点同刻下发、时钟从终点到达时开始，
#     段①应以模型时长/速度完成（头端速率 = d/lt），否则 1.6× 加速 + 段间停顿（用户实测"两次卡顿"之一）
#   ★ 记录到 note_c_seg1_dur 供段②触发阈值/交互进度用
scoreboard players operation #seg1_dur display_calc = @s note_c_m
execute if score #seg1_dur display_calc matches ..0 run scoreboard players set #seg1_dur display_calc 1
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #seg1_dur display_calc = @s note_c_lt
execute store result score @s note_c_seg1_dur run scoreboard players get #seg1_dur display_calc
# 停止 display_animation 逐帧驱动（防残留 step 覆盖插值）
scoreboard players set @s anim_status 0
# 记录当前段 + 打"待 promote"标记（active=0 → 下一 tick active_note 翻 1 → promote）
scoreboard players set @s note_c_seg 1
scoreboard players set @s note_active 0
tag @s add note_concrete_seg1_armed