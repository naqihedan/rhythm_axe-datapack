# ========== title2800 驱动器（每刻自调度，一次只排一刻）==========
# 时钟 #t2800_wave t2800_t：入口设 0 并先跑一次关键帧（= 第 1 刻），此后每刻 +1
# 时间轴：1-5 G2 → 5-9 R2 → 9-13 018 → 12-16 CLIMAX → 16-20 左斜线 → 24-28 右斜线 → 29-32 退场（回到出生偏移）→ 32 删除
# * 关键帧下发在 title2800_frames；本文件只管推时钟与收尾

scoreboard players add #t2800_wave t2800_t 1

# 下发本刻关键帧（title2800_frames 内按 #t2800_wave 匹配）
function rhythm_axe:maps/goodworld/title2800_frames

# 第 32 刻：整段结束 → 删实体、停链
execute if score #t2800_wave t2800_t matches 32.. run function rhythm_axe:maps/goodworld/title2800_clear

# 继续条件：只排到第 31 刻（第 32 刻不再排）→ 链自然结束
execute if score #t2800_wave t2800_t matches ..31 run schedule function rhythm_axe:maps/goodworld/title2800_tick 1t

# 收尾：删计分项（读 #t2800_wave 的动作都在本行之前，顺序不能动）
execute if score #t2800_wave t2800_t matches 32.. run scoreboard objectives remove t2800_t
