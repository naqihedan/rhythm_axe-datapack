# 给一套选择工具（金斧头，container.9）：右键两次循环定两角选立方体音符
#   第一次右键 定第一角 | 第二次右键 定第二角（确认选区+判定选中+弹已选定音符列表）后回第一角
# 金斧头：可食用（consumable）+ use_remainder 返还 + custom_data.editor_tool_select
# 与音符工具/时间控件同款 consume_item 触发（editor/tool_use → use_ → use__ 分派）
# 武装工具使用进度（give 时 revoke+grant 一次即可，reward 顶部 revoke 可重复）
advancement revoke @s only rhythm_axe:editor/tool_use
advancement grant @s only rhythm_axe:editor/tool_use

# 重置选择工具状态（避免切换工具后残留上一轮选择）
data remove storage rhythm_axe:maps.editor select_tool
kill @e[tag=editor_tool_select_glow]
execute as @e[tag=editor_note,type=item_display] run data remove entity @s Glowing
execute as @e[tag=editor_note,type=item_display] run data remove entity @s glow_color_override
data modify storage rhythm_axe:maps.editor selection set value []

item replace entity @s container.9 with minecraft:stick[\
    item_model="minecraft:golden_axe",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",\
        components:{\
        item_model:"minecraft:golden_axe",\
        attack_range:{\
                max_reach:1.5f,\
                max_creative_reach:1.5f\
            },\
            attribute_modifiers:[\
                {type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},\
                {type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}\
                ],\
            item_name:"{\"text\":\"【选择工具】\",\"color\":\"green\",\"bold\":true}",\
            custom_data:{\
                editor_tool:true,\
                editor_tool_select:true\
            }\
        }\
    },\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=\
            [\
            {type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},\
            {type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}\
            ],\
    item_name={"text":"【选择工具】","color":"green","bold":true},\
    custom_data={editor_tool:true,editor_tool_select:true}\
] 1

tellraw @s [{"text":"[编辑器] 已给予选择工具（金斧头）","color":"yellow"}]
