# 编辑器工具常驻检测（每 tick，由 #minecraft:tick 调用的 function/tick 触发）
# 对每个激活编辑器玩家，按手持工具的 custom_data，根据蹲下状态动态改写物品名/模型。
# 仅在工具标记匹配、且状态发生变化时重写（避免每刻无谓重写）。
execute as @a[tag=editor_active] at @s run function rhythm_axe:editor/tool/tool_regular_apply
