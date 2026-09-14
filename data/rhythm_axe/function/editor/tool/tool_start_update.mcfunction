#arg:slot
# @s = 玩家；$(slot) = 目标槽位。站立=返回开头、蹲下=跳到结尾。
# 蹲下状态由 tool_regular_apply 统一写入 #tool_sneak；此处只在该槽状态与目标不符时重写。
# 前置：由 tool_regular_slot 确认该槽是编辑工具。

$execute if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_start_write {slot:"$(slot)",shown:"返回开头",model:"minecraft:quartz",hint:"蹲下以跳到结尾",state:0}
$execute if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_start_write {slot:"$(slot)",shown:"跳到结尾",model:"minecraft:quartz",hint:"站立以返回开头",state:1}
