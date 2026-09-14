# 音符工具主手返还（@s = 玩家）：按槽内物品现有身份标记重写主手物品（保留身份，state=-1 → 下一 tick 由 tool_note_update 按实际蹲下状态重绘外观）。
# 前置：调用方已确认主手是编辑工具。
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_noteblock run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"noteblock",model:"minecraft:note_block",color:"gold",shown:"音符盒",hint:"  蹲下切换为木板",state:-1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_plank run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"plank",model:"minecraft:birch_planks",color:"gold",shown:"木板",hint:"  蹲下切换为音符盒",state:-1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_glass run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"glass",model:"minecraft:red_stained_glass",color:"red",shown:"染色玻璃",hint:"  蹲下切换为混凝土",state:-1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note_concrete run function rhythm_axe:editor/tool/tool_note_write {slot:"weapon.mainhand",key:"concrete",model:"minecraft:lime_concrete",color:"green",shown:"混凝土",hint:"  蹲下切换为染色玻璃",state:-1}
# 立即按当前蹲下状态重绘（同一 tick 完成，避免返还瞬间闪现站立态外观）
function rhythm_axe:editor/tool/tool_note_update
