# 桶排序完成后的主循环启动入口（普通函数）
# ★ 2026-09-05 新增：排序改为跨多刻 schedule，完成后（sort_bucket_finish 或 ≤1 音符）调用本函数。
#   替代 start.mcfunction 里直接 schedule main_loop（排序未完成时不能开玩）。
# 说明：start 已把 is_running=1、time/游标等初始化好（init_game 同步完成），排序只重排 notes。
schedule function rhythm_axe:play/main_loop 5t
