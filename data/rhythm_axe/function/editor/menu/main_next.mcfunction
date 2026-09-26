# 主菜单「下一刻渲染」包装（跨刻安全调用 rhythm_axe:editor/menu/main）
# ★ 为什么需要它：`schedule` 拉起时执行者是**服务端**（没有 @s），而菜单里全是 tellraw @s；
#   任何被 schedule 的渲染函数都必须先用本包装切回「正在用编辑器的玩家」。
# 用法：把调用点里的 `function rhythm_axe:editor/menu/main` 换成
#       `schedule function rhythm_axe:editor/menu/main_next 1t`
# 协作：只作用于「本次操作者」。原来对所有 editor_active 各跑一遍 ⇒ 动作重复执行（翻转两次=没翻）、
#   面板重复渲染。其余成员的重绘由 clear_lines 的广播负责。
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/main
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/main
