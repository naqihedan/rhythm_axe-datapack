# 下一刻重绘面板 20（schedule 调用，执行者是服务端 → 必须重新 as 玩家）
#   分布/填充的收尾已经跑过 refresh（整表重建视觉）+ 逐音符遍历，同刻再渲染面板会超命令链被截断
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/note/df/df_render
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/note/df/df_render
# ★ 操作反馈就发在这一刻（面板渲染之后）：黄字「[编辑器] 已分布/已插值填充 N 个音符」+【撤销】【重做】
#   放在 df_render 之后，才不会被 clear_lines 的 10 行空行冲掉；feedback 由 show_feedback 自行消费
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/show_feedback
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/show_feedback
