# ⑤ 总入口：写进谱面事件点就用这个
#   4 波（0 / 32 / 64 / 96 刻，间隔 32 刻），每波组数 3 / 5 / 8 / 13
#   ★ 每波整波同刻直接调用、一次性冒出（WAVE_SPREAD=0）
#   ★ 第 1 波直接调用（schedule 时间最小 1 刻，0t 会报错）；其余 3 条都带 append
#     （schedule 默认 replace，同一函数名只留一个待执行任务）
#   ★ 第 256 刻清场
function rhythm_axe:maps/goodworld/goodfx/init
function rhythm_axe:maps/goodworld/goodfx/waves/w1
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w2 32t append
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w3 64t append
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w4 96t append
schedule function rhythm_axe:maps/goodworld/goodfx/total_cleanup 256t
