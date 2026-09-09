# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:gold_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:gold_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_tick:true,editor_tool_fwd:"快退一刻",editor_tool_bwd:"快进一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一刻】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_tick:true,editor_tool_fwd:"快退一刻",editor_tool_bwd:"快进一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:gold_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:gold_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_tick:true,editor_tool_fwd:"快退一刻",editor_tool_bwd:"快进一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一刻】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_tick:true,editor_tool_fwd:"快退一刻",editor_tool_bwd:"快进一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}\
    ] 1

# 直接执行：站立=快退一刻(seek back 1t)，蹲下=快进一刻(seek fwd 1t)；不再 set trigger 避免 consume 二次发声
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "back"
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop ticks set value 1
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "fwd"
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop ticks set value 1
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
