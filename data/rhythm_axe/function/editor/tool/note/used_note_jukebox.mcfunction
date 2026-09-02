# 唱片机工具右键：返还物品（主手/副手）+ 设音符类型(2) + 放置音符（@s=玩家）
# 主手返还
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:jukebox",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:jukebox",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【唱片机】\",\"color\":\"gold\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_jukebox:true}}},\
        enchantment_glint_override=true,\
        attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
        attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
        item_name={"text":"【唱片机】","color":"gold","bold":true},\
        custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_jukebox:true}\
    ] 1
# 副手返还
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:jukebox",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:jukebox",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【唱片机】\",\"color\":\"gold\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_jukebox:true}}},\
        enchantment_glint_override=true,\
        attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
        attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
        item_name={"text":"【唱片机】","color":"gold","bold":true},\
        custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_jukebox:true}\
    ] 1
# 设置音符类型并放置
function rhythm_axe:editor/tool/note/place {note_type:2}
