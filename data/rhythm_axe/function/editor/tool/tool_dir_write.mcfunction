#arg:marker,model,fwd,bwd,shown,hint,state
# 方向工具重写（宏参数）：@s = 玩家。按当前蹲下状态用 shown（【前进XX】或【快退XX】）重写主手物品名，并保留 custom_data 全部标记。
# fwd/bwd/state 供下次状态切换时识别；shown 为本次要显示的名字；hint 为提示文本。
$item replace entity @s weapon.mainhand with minecraft:stick[\
    item_model="$(model)",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"$(model)",item_name:"{\"text\":\"  【$(shown)】\",\"color\":\"gold\",\"extra\":[{\"text\":\"  $(hint)\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,$(marker):true,editor_tool_fwd:"$(fwd)",editor_tool_bwd:"$(bwd)",editor_tool_model:"$(model)",editor_tool_state:$(state)}}},\
    enchantment_glint_override=true,\
    item_name={"text":"  【$(shown)】","color":"gold","extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_timeline:true,$(marker):true,editor_tool_fwd:"$(fwd)",editor_tool_bwd:"$(bwd)",editor_tool_model:"$(model)",editor_tool_state:$(state)}\
] 1
