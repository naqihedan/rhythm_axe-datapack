#arg:slot,shown,hint,state
# 播放速度工具重写（宏参数）。@s = 玩家，写 $(slot) 槽位。按 shown（【播放速度】或【音符流速】）重写物品名，保留 custom_data 标记并更新 state。
$item replace entity @s $(slot) with minecraft:stick[\
    item_model="minecraft:amethyst_shard",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    item_name={"text":"【$(shown)】","color":"light_purple","extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:$(state)}\
] 1

