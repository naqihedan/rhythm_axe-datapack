# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:amethyst_shard",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:amethyst_shard",item_name:"{\"text\":\"【播放速度】\",\"color\":\"light_purple\",\"extra\":[{\"text\":\" 蹲下以调整音符流速\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【播放速度】","color":"light_purple","extra":[{"text":" 蹲下以调整音符流速","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:0}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:amethyst_shard",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:amethyst_shard",item_name:"{\"text\":\"【播放速度】\",\"color\":\"light_purple\",\"extra\":[{\"text\":\" 蹲下以调整音符流速\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【播放速度】","color":"light_purple","extra":[{"text":" 蹲下以调整音符流速","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:0}\
    ] 1

# 站立：播放速度循环（25/50/75/100%）；下蹲：音符流速工具（2/4/8/16 循环，刷新世界音符）
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/cycle_note_speed
execute unless entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 27
