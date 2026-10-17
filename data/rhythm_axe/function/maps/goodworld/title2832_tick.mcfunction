# ========== title2832 驱动器（每刻自调度，一次只排一刻）==========
# 时钟 #t2832_wave t2832_t：入口设 0 并先跑一次关键帧（= 出生当刻），此后每刻 +1
# 时间轴：1-52 静止 → 52 刻起下移 2 格（8 刻插值，60 刻到位）→ 60 全部删除
# * 关键帧下发在 title2832_frames；本文件只管推时钟与收尾
# ★ 2026-10-17：整条时间轴后移 32 刻（动画 20-28 → 52-60）——「没动画的空挡」加长 32 刻

scoreboard players add #t2832_wave t2832_t 1

# 下发本刻关键帧（title2832_frames 内按 #t2832_wave 匹配）
function rhythm_axe:maps/goodworld/title2832_frames

# 第 60 刻：整段结束 → 删实体、停链
execute if score #t2832_wave t2832_t matches 60.. run function rhythm_axe:maps/goodworld/title2832_clear

# 继续条件：只排到第 59 刻（第 60 刻不再排）→ 链自然结束
execute if score #t2832_wave t2832_t matches ..59 run schedule function rhythm_axe:maps/goodworld/title2832_tick 1t

# 收尾：删计分项（读 #t2832_wave 的动作都在本行之前，顺序不能动）
execute if score #t2832_wave t2832_t matches 60.. run scoreboard objectives remove t2832_t