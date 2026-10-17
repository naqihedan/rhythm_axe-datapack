# ========== letter2768 驱动器（每刻自调度，一次只排一刻）==========
# 时钟 #letter_wave letter2768_t：入口设 0 并先跑一次关键帧（= 第 1 刻），此后每刻 +1
# 时间轴：… 18/19/20 横线 B 收完 → 21 全部删除、停链、删计分项
# * 关键帧下发在 letter2768_frames；本文件只管推时钟与收尾

scoreboard players add #letter_wave letter2768_t 1

# 下发本刻关键帧（letter2768_frames 内按 #letter_wave 匹配）
function rhythm_axe:maps/goodworld/letter2768_frames

# 第 21 刻：整段结束 → 删实体、停链
execute if score #letter_wave letter2768_t matches 21.. run function rhythm_axe:maps/goodworld/letter2768_clear

# 继续条件：只排到第 20 刻（第 21 刻不再排）→ 链自然结束
execute if score #letter_wave letter2768_t matches ..20 run schedule function rhythm_axe:maps/goodworld/letter2768_tick 1t

# 收尾：删计分项（读 #letter_wave 的动作都在本行之前，顺序不能动）
execute if score #letter_wave letter2768_t matches 21.. run scoreboard objectives remove letter2768_t
