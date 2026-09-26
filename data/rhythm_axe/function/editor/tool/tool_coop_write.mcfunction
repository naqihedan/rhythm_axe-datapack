#arg:slot,shown,model,hint,color,state
# 协作工具重写（宏参数）：@s = 玩家，写 $(slot) 槽位。站立 = 命名牌【协作·邀请】、蹲下 = 屏障【协作·踢出】。
# custom_data 里写 editor_tool_model / editor_tool_state，供下次蹲下状态变化时识别并重写。
# ★ 带 consumable ⇒ 右键走 advancement tool_use（consume_item）→ use__ 分派到 editor/tool/coop/used_coop。
$item replace entity @s $(slot) with minecraft:stick[\
    item_model="$(model)",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    item_name={"text":"【$(shown)】","color":"$(color)","bold":true,"extra":[{"text":"  $(hint)","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_coop:true,editor_tool_model:"$(model)",editor_tool_state:$(state)}\
] 1
