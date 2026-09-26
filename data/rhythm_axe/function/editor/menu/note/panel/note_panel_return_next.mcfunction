# 下一刻再回来源面板（由 schedule 调用，独立命令链）：只做面板列表渲染 + 反馈
# 前置：#from editor 已设置；★ schedule 调用时执行者是服务端 → 必须重新 as 玩家（否则 @s 不存在、tellraw 全丢）
# 协作：只作用于「本次操作者」。原来对所有 editor_active 各跑一遍 ⇒ 动作重复执行（翻转两次=没翻）、
#   面板重复渲染。其余成员的重绘由 clear_lines 的广播负责。
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/note/panel/note_panel_return
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/note/panel/note_panel_return
