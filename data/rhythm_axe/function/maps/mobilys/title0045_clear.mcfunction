# ========== title0045 清理 ==========
# 用途：① 驱动器第 108 刻自动调用 ② 手动 /function rhythm_axe:maps/mobilys/title0045_clear 立刻收掉
# * 清实体 + 停计时链；计分项 t0045_t 留给驱动器收尾删
#   （此处不删，否则驱动器后续 if score 会因「计分项不存在」报错中断）

scoreboard players reset @e[tag=t0045] t0045_t
kill @e[tag=t0045]
schedule clear rhythm_axe:maps/mobilys/title0045_tick
