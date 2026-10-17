# ========== title2832 清理 ==========
# 用途：① 驱动器第 28 刻自动调用 ② 手动 /function rhythm_axe:maps/goodworld/title2832_clear 立刻收掉
# * 清实体 + 停计时链；计分项 t2832_t 留给驱动器收尾删
#   （此处不删，否则驱动器后续 if score 会因「计分项不存在」报错中断）
# * 父实体与 3 个乘客都带 tag t2832，一条 kill 全清（父实体先死时乘客会脱骑，所以必须一次性全杀）

scoreboard players reset @e[tag=t2832] t2832_t
kill @e[tag=t2832]
schedule clear rhythm_axe:maps/goodworld/title2832_tick