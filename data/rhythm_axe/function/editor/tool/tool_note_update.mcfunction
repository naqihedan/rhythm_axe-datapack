#arg:slot
# @s = 玩家；$(slot) = 目标槽位。配对音符工具（custom_data.editor_tool_note_pair）。
# 站立 = 显示并放置身份类型（editor_tool_note_<key> 标记）；蹲下 = 显示配对类型并灰字提示。
# 配对：音符盒↔木板、染色玻璃↔混凝土。物品的身份标记始终不变，只有外观（模型/名字/提示）与 state 随蹲下状态变；
# 实际放置类型由 use__ 按蹲下状态分派（故蹲下右键即放配对音符）。
# 蹲下状态由 tool_regular_apply 统一写入 #tool_sneak；此处只在该槽 state 与目标不符时重写。
# 前置：由 tool_regular_slot 确认该槽是编辑工具。

# 身份=noteblock：站立=音符盒、蹲下=木板
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_noteblock:true}] if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"noteblock",model:"minecraft:note_block",color:"gold",shown:"音符盒",hint:"  蹲下切换为木板",state:0}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_noteblock:true}] if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"noteblock",model:"minecraft:birch_planks",color:"gold",shown:"木板",hint:"  站立切换回音符盒",state:1}
# 身份=plank：站立=木板、蹲下=音符盒
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_plank:true}] if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"plank",model:"minecraft:birch_planks",color:"gold",shown:"木板",hint:"  蹲下切换为音符盒",state:0}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_plank:true}] if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"plank",model:"minecraft:note_block",color:"gold",shown:"音符盒",hint:"  站立切换回木板",state:1}
# 身份=glass：站立=染色玻璃、蹲下=混凝土
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_glass:true}] if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"glass",model:"minecraft:red_stained_glass",color:"red",shown:"染色玻璃",hint:"  蹲下切换为混凝土",state:0}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_glass:true}] if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"glass",model:"minecraft:lime_concrete",color:"green",shown:"混凝土",hint:"  站立切换回染色玻璃",state:1}
# 身份=concrete：站立=混凝土、蹲下=染色玻璃
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_concrete:true}] if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"concrete",model:"minecraft:lime_concrete",color:"green",shown:"混凝土",hint:"  蹲下切换为染色玻璃",state:0}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_concrete:true}] if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_note_write {slot:"$(slot)",key:"concrete",model:"minecraft:red_stained_glass",color:"red",shown:"染色玻璃",hint:"  站立切换回混凝土",state:1}
