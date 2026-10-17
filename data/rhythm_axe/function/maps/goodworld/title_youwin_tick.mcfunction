# ========== title_youwin 驱动器（每刻自调度，一次只排一刻）==========
# 时钟 #youwin_wave youwin_t：入口设 0 并先跑一次关键帧（= 第 1 刻），此后每刻 +1
# 时间轴：1-4 边框生长(3刻) → 4-6 文字放大(2刻) → 6-12 静止 → 12-16 边框缩回(4刻)/文字缩回(2刻) → 21 全部删除
# * 关键帧下发在 title_youwin_frames；本文件只管推时钟与收尾

scoreboard players add #youwin_wave youwin_t 1

# 下发本刻关键帧（title_youwin_frames 内按 #youwin_wave 匹配）
function rhythm_axe:maps/goodworld/title_youwin_frames

# 第 21 刻：整段结束 → 删实体、停链
execute if score #youwin_wave youwin_t matches 21.. run function rhythm_axe:maps/goodworld/title_youwin_clear

# 继续条件：只排到第 20 刻（第 21 刻不再排）→ 链自然结束
execute if score #youwin_wave youwin_t matches ..20 run schedule function rhythm_axe:maps/goodworld/title_youwin_tick 1t

# 收尾：删计分项（读 #youwin_wave 的动作都在本行之前，顺序不能动）
execute if score #youwin_wave youwin_t matches 21.. run scoreboard objectives remove youwin_t
