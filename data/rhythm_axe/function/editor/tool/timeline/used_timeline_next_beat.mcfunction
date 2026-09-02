# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:iron_ingot[\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:iron_ingot",components:{custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_beat:true}}},\
        enchantment_glint_override=true,\
        custom_name={text:"【前进一拍】 蹲下以快退",color:"gray",italic:true},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_beat:true}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:iron_ingot[\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:iron_ingot",components:{custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_beat:true}}},\
        enchantment_glint_override=true,\
        custom_name={text:"【前进一拍】 蹲下以快退",color:"gray",italic:true},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_beat:true}\
    ] 1

# 执行工具命令：站立=前进一拍(25)，蹲下=后退一拍(21)
execute unless entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 25
execute if entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 21
