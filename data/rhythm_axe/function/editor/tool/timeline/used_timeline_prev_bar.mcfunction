# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:copper_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:copper_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_bar:true,editor_tool_fwd:"快退一小节",editor_tool_bwd:"快进一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一小节】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_bar:true,editor_tool_fwd:"快退一小节",editor_tool_bwd:"快进一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:copper_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:copper_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_bar:true,editor_tool_fwd:"快退一小节",editor_tool_bwd:"快进一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一小节】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_bar:true,editor_tool_fwd:"快退一小节",editor_tool_bwd:"快进一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}\
    ] 1

# 执行工具命令：站立=快退一小节(20)，蹲下=快进一小节(26)
execute unless entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 20
execute if entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 26
