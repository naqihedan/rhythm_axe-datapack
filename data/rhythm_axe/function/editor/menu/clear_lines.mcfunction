# 清屏：输出十行换行（聊天栏面板打开/刷新前调用）
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
tellraw @s [{"text":""}]
# ========== 协作：把本次渲染同步给其他成员 ==========
# 面板/列表渲染全是 `tellraw @s`（只发给本次的 @s）⇒ 协作时其余成员的面板会停在上一次，
# 导致他们点到的按钮值属于「旧面板」而提示「该按钮不属于当前面板」。这里让其他成员各自按
# current_panel 重绘一遍（等价于原代码 `execute as @a[tag=editor_active] run function` 的广播写法）。
#   ① 非编辑器渲染（大厅 map_list 也复用本函数）直接跳过；
#   ② coop_in_broadcast = 「这次渲染本身就是广播出来的」→ 不再向外扩散（防无限递归）。
execute unless entity @s[tag=editor_active] run return 0
execute if entity @s[tag=coop_in_broadcast] run return 0
tag @s add coop_render_src
execute as @a[tag=editor_active] unless entity @s[tag=coop_render_src] run tag @s add coop_in_broadcast
execute as @a[tag=editor_active] unless entity @s[tag=coop_render_src] run function rhythm_axe:editor/menu/resume
tag @a[tag=coop_in_broadcast] remove coop_in_broadcast
tag @s remove coop_render_src
