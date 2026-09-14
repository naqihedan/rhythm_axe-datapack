#arg:slot
# @s = 玩家；$(slot) = 目标槽位。站立=事件点工具（命令方块矿车）、蹲下=时间点工具（时钟）。
# 蹲下状态由 tool_regular_apply 统一写入 #tool_sneak；此处只在该槽状态与目标不符时重写。
# 前置：由 tool_regular_slot 确认该槽是编辑工具。

$execute if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_timing_write {slot:"$(slot)",shown:"事件点工具",model:"minecraft:command_block_minecart",hint:"蹲下为时间点工具",state:0}
$execute if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_timing_write {slot:"$(slot)",shown:"时间点工具",model:"minecraft:clock",hint:"站立为事件点工具",state:1}
