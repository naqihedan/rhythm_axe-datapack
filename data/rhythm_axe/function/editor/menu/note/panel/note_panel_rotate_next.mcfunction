# note_panel_rotate 的「下一刻执行」包装：schedule 拉起时执行者是服务端（没有 @s），先切回正在用编辑器的玩家再干活。
# 协作：只作用于「本次操作者」。原来对所有 editor_active 各跑一遍 ⇒ 动作重复执行（翻转两次=没翻）、
#   面板重复渲染。其余成员的重绘由 clear_lines 的广播负责。
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_go
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_go