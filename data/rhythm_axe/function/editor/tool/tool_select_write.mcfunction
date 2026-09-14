#arg:slot,shown,model,hint,color,state
# 选择工具重写（宏参数）：@s = 玩家，写 $(slot) 槽位。站立=金斧头【选择工具】（绿名）、蹲下=钻斧头【时间段选择】（淡蓝名）。
# custom_data 里写 editor_tool_model / editor_tool_state，供下次蹲下状态变化时识别并重写。
$item replace entity @s $(slot) with minecraft:stick[\
    item_model="$(model)",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[\
        {type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},\
        {type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}\
        ],\
    item_name={"text":"【$(shown)】","color":"$(color)","bold":true,"extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_select:true,editor_tool_model:"$(model)",editor_tool_state:$(state)}\
] 1

