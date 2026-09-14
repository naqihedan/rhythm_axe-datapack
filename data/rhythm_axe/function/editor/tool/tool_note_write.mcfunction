#arg:slot,key,model,color,shown,hint,state
# 音符工具写回（宏参数）：@s = 玩家，写 $(slot) 槽位（weapon.mainhand / weapon.offhand）的编辑工具物品。
# key  = 身份类型标记（noteblock/plank/glass/concrete，不随蹲下改变），决定 use__ 分派与下次切换方向；
# model/color/shown/hint = 当前生效外观（站立=身份本身、蹲下=配对类型）；
# state = 本次蹲下状态（0=站立 1=蹲下；-1 = 强制下一 tick 按实际状态重绘）。
$item replace entity @s $(slot) with minecraft:stick[\
    item_model="$(model)",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"$(model)",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【$(shown)】\",\"color\":\"$(color)\",\"bold\":true,\"extra\":[{\"text\":\"$(hint)\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_$(key):true,editor_tool_note_pair:true,editor_tool_state:$(state)}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    item_name={"text":"【$(shown)】","color":"$(color)","bold":true,"extra":[{"text":"$(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_$(key):true,editor_tool_note_pair:true,editor_tool_state:$(state)}\
] 1
