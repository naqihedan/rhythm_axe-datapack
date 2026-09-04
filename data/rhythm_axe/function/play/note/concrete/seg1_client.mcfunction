# 混凝土段①：拉伸（客户端插值，仅线性 easing=1 power=1，2026-08-10 替换）
# @s = 混凝土展示实体（summon 出生时调用）
# 起点 = 出生局部状态（translation.z=-dist+size/2、scale.z=0，summon 已设）
# 段①终点（按模型）：
#   短 hold（m<=lt）：z1 = -dist×(2lt-m)/(2lt) + size/2；scale.z = len1 = dist×m/lt；时长 = m
#   长 hold（m>lt）：center = -dist/2 + size/2；scale.z = dist（满长）；时长 = lt
# ★ 2026-08-14：本函数只打 armed→pending 两阶段延迟，不再预置插值参数——参数（duration + start=0）
#   改由 seg1_merge 与段①终点【同一刻】下发（wiki：同刻多次变更计为单个变更；时钟从终点到达时开始 → 无起步前跳）
# ★ 2026-09-05：打 note_concrete_seg1_pending + note_c_seg1_ticks=0，concrete/tick 每 tick +1，>=2 才 merge 段①终点
#   （出生→merge 隔 2-tick：#ct 2→4，seg1_s=4；曾试 4-tick 使 seg1_s=6，反而让头端晚 2 刻不到位、段③截断，故回退 2-tick）
# ★ 显式清 anim_status：段①不再由 display_animation 逐帧驱动

# 段①插值时长（★ 2026-08-14：短 = m（原 m-3）；长 = lt）
#   ★ m-3 是旧"参数出生刻预置"方案的补偿；现在参数与终点同刻下发、时钟从终点到达时开始，
#     段①应以模型时长/速度完成（头端速率 = d/lt），否则 1.6× 加速 + 段间停顿（用户实测"两次卡顿"之一）
#   ★ 记录到 note_c_seg1_dur 供段②触发阈值/交互进度用
#   ★ 2026-09-05：延迟 2-tick（seg1_s=4）下，段①时长再 -2 补偿（min 1）→ seg1_s+seg1_dur = m+2
#     → 段②到位 = 判定时刻（头端到位 s/2），段①实际以略快速度完成，但段②触发点/落点保持不变
scoreboard players operation #seg1_dur display_calc = @s note_c_m
execute if score #seg1_dur display_calc matches ..0 run scoreboard players set #seg1_dur display_calc 1
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #seg1_dur display_calc = @s note_c_lt
execute if score #seg1_dur display_calc matches 3.. run scoreboard players operation #seg1_dur display_calc -= 2 const
execute if score #seg1_dur display_calc matches ..0 run scoreboard players set #seg1_dur display_calc 1
execute store result score @s note_c_seg1_dur run scoreboard players get #seg1_dur display_calc
# 停止 display_animation 逐帧驱动（防残留 step 覆盖插值）
scoreboard players set @s anim_status 0
# 记录当前段 + 打"待 merge"标记 + 插值延迟计数（2026-09-05：4-tick 计数链，counter>=4 才 merge 段①终点）
scoreboard players set @s note_c_seg 1
scoreboard players set @s note_active 0
scoreboard players set @s note_c_seg1_ticks 0
tag @s add note_concrete_seg1_pending