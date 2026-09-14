# @s = 编辑器激活玩家，手持配对音符工具（custom_data.editor_tool_note_pair）。
# 站立 = 显示并放置身份类型（editor_tool_note_<key> 标记）；蹲下 = 显示配对类型并灰字提示。
# 配对：音符盒↔木板、染色玻璃↔混凝土。物品的身份标记始终不变，只有外观（模型/名字/提示）与 state 随蹲下状态变；
# 实际放置类型由 use__ 按蹲下状态分派（故蹲下右键即放配对音符）。
# 与上次记录的 editor_tool_state 比对，不一致才改写（同 tool_dir_update / tool_select_update）。
# 前置：已由 tool_regular_apply 确认手持该工具。

# 当前蹲下状态：0=站立 1=蹲下
scoreboard players set #tool_sneak editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #tool_sneak editor 1
# 上次记录状态（缺字段的旧工具 → -1，保证重写一次把字段补上）
scoreboard players set #tool_state editor -1
execute store result score #tool_state editor run data get entity @s SelectedItem.components."minecraft:custom_data".editor_tool_state 1
execute if score #tool_sneak editor = #tool_state editor run return fail

# 身份=noteblock：站立=音符盒、蹲下=木板
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_noteblock if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"noteblock",model:"minecraft:note_block",color:"gold",shown:"音符盒",hint:"  蹲下切换为木板",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_noteblock if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"noteblock",model:"minecraft:birch_planks",color:"gold",shown:"木板",hint:"  站立切换回音符盒",state:1}
# 身份=plank：站立=木板、蹲下=音符盒
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_plank if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"plank",model:"minecraft:birch_planks",color:"gold",shown:"木板",hint:"  蹲下切换为音符盒",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_plank if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"plank",model:"minecraft:note_block",color:"gold",shown:"音符盒",hint:"  站立切换回木板",state:1}
# 身份=glass：站立=染色玻璃、蹲下=混凝土
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_glass if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"glass",model:"minecraft:red_stained_glass",color:"red",shown:"染色玻璃",hint:"  蹲下切换为混凝土",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_glass if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"glass",model:"minecraft:lime_concrete",color:"green",shown:"混凝土",hint:"  站立切换回染色玻璃",state:1}
# 身份=concrete：站立=混凝土、蹲下=染色玻璃
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_concrete if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"concrete",model:"minecraft:lime_concrete",color:"green",shown:"混凝土",hint:"  蹲下切换为染色玻璃",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_concrete if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"concrete",model:"minecraft:red_stained_glass",color:"red",shown:"染色玻璃",hint:"  站立切换回混凝土",state:1}
