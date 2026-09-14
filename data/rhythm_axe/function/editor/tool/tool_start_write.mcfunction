#arg:slot,shown,model,hint,state
# 返回开头工具重写（宏参数）。@s = 玩家，写 $(slot) 槽位。按 shown（【返回开头】或【跳到结尾】）重写物品名，保留 custom_data 标记并更新 state。
$item replace entity @s $(slot) with minecraft:stick[\
    item_model="$(model)",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    item_name={"text":"【$(shown)】","color":"yellow","extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:$(state)}\
] 1

