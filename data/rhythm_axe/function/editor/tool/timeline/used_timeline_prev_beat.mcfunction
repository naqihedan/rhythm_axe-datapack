# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:iron_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:iron_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_beat:true,editor_tool_fwd:"快退一拍",editor_tool_bwd:"快进一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一拍】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_beat:true,editor_tool_fwd:"快退一拍",editor_tool_bwd:"快进一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:iron_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:iron_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_beat:true,editor_tool_fwd:"快退一拍",editor_tool_bwd:"快进一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一拍】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_beat:true,editor_tool_fwd:"快退一拍",editor_tool_bwd:"快进一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}\
    ] 1

# 直接执行：站立=快退一拍(step beat back)，蹲下=快进一拍(step beat fwd)；不再 set trigger 避免 consume 二次发声
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop kind set value "beat"
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "back"
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop kind set value "beat"
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "fwd"
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
