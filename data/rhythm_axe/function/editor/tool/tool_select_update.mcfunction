#arg:slot
# @s = 玩家；$(slot) = 目标槽位。站立 = 金斧头【选择工具】（绿名）+ 黄绿玻璃预览；蹲下 = 钻斧头【时间段选择】（淡蓝名）。
# 蹲下状态由 tool_regular_apply 统一写入 #tool_sneak；此处只在该槽状态与目标不符时重写。
# 前置：由 tool_regular_slot 确认该槽是编辑工具。

$execute if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_select_write {slot:"$(slot)",shown:"选择工具",model:"minecraft:golden_axe",hint:"蹲下为时间段选择",color:"green",state:0}
$execute if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_select_write {slot:"$(slot)",shown:"时间段选择",model:"minecraft:diamond_axe",hint:"站立为框选音符",color:"aqua",state:1}
