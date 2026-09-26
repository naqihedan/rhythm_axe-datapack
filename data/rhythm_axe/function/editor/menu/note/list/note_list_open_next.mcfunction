# 下一刻再打开「活跃音符列表」（由 schedule 调用）
#   ★ 粘贴（里头 refresh 会重建全部视觉实体）和列表渲染（两遍遍历 notes + 40 行）挤在同一个 tick 里，
#     会把命令链顶到 maxCommandChainLength = 200000 → 后半段（第二行翻转/镜像/旋转按钮等）被静默丢弃
#   ★ schedule 调用时执行者是服务端、不是玩家 → 必须重新 as 玩家（否则 @s 不存在，所有 tellraw 全丢）
# 协作：只作用于「本次操作者」。原来对所有 editor_active 各跑一遍 ⇒ 动作重复执行（翻转两次=没翻）、
#   面板重复渲染。其余成员的重绘由 clear_lines 的广播负责。
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/note/list/note_list_open
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/note/list/note_list_open
