#arg:slot,hint,state,name
# 播放/暂停工具重写（宏参数）。@s = 玩家，写 $(slot) 槽位。
# 名字与灰字提示都随蹲下状态变（由 tool_pp_update 传入）：
#   站立 =【播放/暂停】+「蹲下播放以添加记录点」；蹲下 =【添加/删除记录点】+「下次暂停会回到记录点，在记录点处蹲下右键删除记录点」
# 绿宝石造型，靠 editor_tool_state 区分两态。
$item replace entity @s $(slot) with minecraft:stick[\
    item_model="minecraft:emerald",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    item_name={"text":"$(name)","color":"green","extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true,editor_tool_state:$(state)}\
] 1
