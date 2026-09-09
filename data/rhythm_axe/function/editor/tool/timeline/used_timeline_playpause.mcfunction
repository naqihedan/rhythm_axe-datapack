# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 主手返还物品
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.mainhand with minecraft:stick[\
        item_model="minecraft:emerald",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:emerald",custom_data:{editor_tool:true,editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【暂停/播放】","color":"green"},\
        custom_data={editor_tool:false,editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}\
    ] 1

# 副手返还物品
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run \
    item replace entity @s weapon.offhand with minecraft:stick[\
        item_model="minecraft:emerald",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:emerald",custom_data:{editor_tool:true,editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【暂停/播放】","color":"green"},\
        custom_data={editor_tool:false,editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}\
    ] 1

# 直接执行：播放/暂停（不再 set trigger，避免 consume 二次发声）
function rhythm_axe:editor/menu/playback_toggle