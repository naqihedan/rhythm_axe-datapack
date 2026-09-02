#arg:shown,hint,state
# 播放速度工具重写（宏参数）。@s = 玩家。按 shown（【播放速度】或【音符流速】）重写主手物品名，保留 custom_data 标记并更新 state。
$item replace entity @s weapon.mainhand with minecraft:stick[\
    item_model="minecraft:amethyst_shard",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:amethyst_shard",item_name:"{\"text\":\"【$(shown)】\",\"color\":\"light_purple\",\"extra\":[{\"text\":\"  $(hint)\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:$(state)}}},\
    enchantment_glint_override=true,\
    item_name={"text":"【$(shown)】","color":"light_purple","extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:$(state)}\
] 1
