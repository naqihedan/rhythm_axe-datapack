# ========== title0045 驱动器（每刻自调度，一次只排一刻）==========
# 时钟 #t0045_wave t0045_t：入口设 0 并先跑一次 frames（= 出生当刻，无匹配），此后每刻 +1
# 时间轴：1-12 缓动拉开(k 1→1.5) → 13-107 线性拉开(k 1.5→2.0) → 108 全部清理
#   · 开头闪烁 1-10 / 结尾闪烁 98-107（各 3 次闪烁 = 5 刻）与位移并行，互不干扰（改 text vs 改 transformation）
# * 关键帧下发在 title0045_frames；本文件只管推时钟与收尾

scoreboard players add #t0045_wave t0045_t 1

# 下发本刻关键帧（title0045_frames 内按 #t0045_wave 匹配）
function rhythm_axe:maps/mobilys/title0045_frames

# 第 108 刻：整段结束 → 删实体、停链
execute if score #t0045_wave t0045_t matches 108.. run function rhythm_axe:maps/mobilys/title0045_clear

# 继续条件：只排到第 107 刻（第 108 刻不再排）→ 链自然结束
execute if score #t0045_wave t0045_t matches ..107 run schedule function rhythm_axe:maps/mobilys/title0045_tick 1t

# 收尾：删计分项（读 #t0045_wave 的动作都在本行之前，顺序不能动）
execute if score #t0045_wave t0045_t matches 108.. run scoreboard objectives remove t0045_t
