# 时间点列表「下一刻渲染」包装（跨刻安全调用 rhythm_axe:editor/menu/timing/list/timing_list_open）
# ★ 时间点列表渲染与前面的 refresh（整表重建视觉）不要挤在同一命令链里；
#   `schedule` 拉起时执行者是服务端（没有 @s），必须切回「正在用编辑器的玩家」。
# 用法：`schedule function rhythm_axe:editor/menu/timing/list/timing_list_open_next 1t`
# 协作：只作用于「本次操作者」。原来对所有 editor_active 各跑一遍 ⇒ 动作重复执行（翻转两次=没翻）、
#   面板重复渲染。其余成员的重绘由 clear_lines 的广播负责。
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/timing/list/timing_list_open
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/timing/list/timing_list_open
