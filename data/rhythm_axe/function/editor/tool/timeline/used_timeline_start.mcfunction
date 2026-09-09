# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:quartz",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:quartz",item_name:"{\"text\":\"【返回开头】\",\"color\":\"yellow\",\"extra\":[{\"text\":\" 蹲下以跳到结尾\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【返回开头】","color":"yellow","extra":[{"text":" 蹲下以跳到结尾","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:0}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:quartz",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:quartz",item_name:"{\"text\":\"【返回开头】\",\"color\":\"yellow\",\"extra\":[{\"text\":\" 蹲下以跳到结尾\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【返回开头】","color":"yellow","extra":[{"text":" 蹲下以跳到结尾","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:0}\
    ] 1

# 直接执行：站立=返回开头，蹲下=跳到结尾；不再 set trigger 避免 consume 二次发声
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/jump/jump_start
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/jump/jump_end
