# @s = 编辑器激活玩家。蹲下状态**发生变化**时，检查「快捷栏 container.0-8 + 选择工具槽 container.9 + 副手」，
# 对其中每个编辑工具按新状态改写外观（这些槽里的工具一起切换，不只手持槽）。
# 每 tick 由 tool_regular_tick 调用（仅 editor_active 玩家）。
# ★ 性能（宏调用约 1ms/次，见开发笔记《性能铁律》）：① 非编辑工具的槽位不调宏；
#   ② 蹲下状态未变化时整轮跳过；③ give_* 给予工具时须 `tag @s remove editor_tool_was_sneak` 强制重算一次。

# 当前蹲下状态：0=站立 1=蹲下（供各槽位判断）
scoreboard players set #tool_sneak editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #tool_sneak editor 1

# 与上次记录（tag editor_tool_was_sneak）比对，未变化 → 整轮跳过
tag @s remove editor_tool_sneak_changed
execute if entity @s[predicate=rhythm_axe:sneaking] unless entity @s[tag=editor_tool_was_sneak] run tag @s add editor_tool_sneak_changed
execute unless entity @s[predicate=rhythm_axe:sneaking] if entity @s[tag=editor_tool_was_sneak] run tag @s add editor_tool_sneak_changed
tag @s remove editor_tool_was_sneak
execute if entity @s[predicate=rhythm_axe:sneaking] run tag @s add editor_tool_was_sneak
execute unless entity @s[tag=editor_tool_sneak_changed] run return fail
tag @s remove editor_tool_sneak_changed

# ===== 快捷栏 slot 0-8 =====
execute if items entity @s container.0 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.0"}
execute if items entity @s container.1 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.1"}
execute if items entity @s container.2 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.2"}
execute if items entity @s container.3 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.3"}
execute if items entity @s container.4 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.4"}
execute if items entity @s container.5 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.5"}
execute if items entity @s container.6 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.6"}
execute if items entity @s container.7 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.7"}
execute if items entity @s container.8 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.8"}
# ===== 选择工具槽（container.9 = 主背包第 1 格，give_select_tool 使用）=====
execute if items entity @s container.9 *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"container.9"}
# ===== 副手 =====
execute if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/tool_regular_slot {slot:"weapon.offhand"}
