# @s = 编辑器激活玩家，手持返回开头工具（custom_data.editor_tool_timeline_start）。
# 站立=返回开头、蹲下=跳到结尾；按蹲下状态动态切换物品名。
# 前置：已由 tool_regular_apply 确认手持该工具。

# 当前蹲下状态：0=站立 1=蹲下
scoreboard players set #tool_sneak editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #tool_sneak editor 1
# 上次记录状态
execute store result score #tool_state editor run data get entity @s SelectedItem.components."minecraft:custom_data".editor_tool_state 1
execute if score #tool_sneak editor = #tool_state editor run return fail

# 状态变化 → 重写（站立：返回开头；蹲下：跳到结尾）
execute if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_start_write {shown:"返回开头",model:"minecraft:quartz",hint:"蹲下以跳到结尾",state:0}
execute if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_start_write {shown:"跳到结尾",model:"minecraft:quartz",hint:"站立以返回开头",state:1}
