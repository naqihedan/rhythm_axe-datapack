# @s = 编辑器激活玩家，手持事件点/时间点工具（custom_data.editor_tool_timing）。
# 站立=事件点工具（命令方块矿车）、蹲下=时间点工具（时钟）；按蹲下状态动态切换物品名/模型。
# 前置：已由 tool_regular_apply 确认手持该工具。

# 当前蹲下状态：0=站立 1=蹲下
scoreboard players set #tool_sneak editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #tool_sneak editor 1
# 上次记录状态
execute store result score #tool_state editor run data get entity @s SelectedItem.components."minecraft:custom_data".editor_tool_state 1
execute if score #tool_sneak editor = #tool_state editor run return fail

# 状态变化 → 重写（站立：事件点/命令方块矿车；蹲下：时间点/时钟）
execute if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_timing_write {shown:"事件点工具",model:"minecraft:command_block_minecart",hint:"蹲下为时间点工具",state:0}
execute if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_timing_write {shown:"时间点工具",model:"minecraft:clock",hint:"站立为事件点工具",state:1}
