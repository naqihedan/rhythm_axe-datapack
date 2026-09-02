# 给整套编辑器物品工具栏（container.0-8）：选择工具 + 时间控件 + 音符工具 + 事件/时间点工具
#   container.0 金斧头 选择工具 | container.1 时钟/命令方块矿车 事件点/时间点工具(站=事件点、蹲=时间点)
#   container.2 绿宝石 暂停/播放 | container.3 金锭 前进一刻(蹲下快退) | container.4 音符盒 | container.5 木板
#   container.6 唱片机 | container.7 红染色玻璃 | container.8 黄绿混凝土
# 可食用 + use_remainder 返还 + custom_data；右键由 use__ 分派（editor_tool_*）
# 音符类型 type：0=音符盒 1=木板 2=唱片机 3=混凝土(黄绿) 4=玻璃(红)
# 事件/时间点工具：站立=事件点工具(命令方块矿车)、蹲下=时间点工具(时钟)；右键添加对应点并打开设置面板
#   custom_data 统一 editor_tool_timing 标记；站立/蹲下行为在 used_timeline_add 用谓词 rhythm_axe:sneaking 判定
# 武装工具使用进度（consume_item 触发；give 时 revoke+grant 一次即可，reward 顶部 revoke 可重复）
advancement revoke @s only rhythm_axe:editor/tool_use
advancement grant @s only rhythm_axe:editor/tool_use

# 重置选择工具状态（避免切换工具后残留上一轮选择）
data remove storage rhythm_axe:maps.editor select_tool
kill @e[tag=editor_tool_select_glow]
execute as @e[tag=editor_note,type=item_display] run data remove entity @s Glowing
execute as @e[tag=editor_note,type=item_display] run data remove entity @s glow_color_override
data modify storage rhythm_axe:maps.editor selection set value []

# 选择工具（金斧头外观；持有时实体交互距离 1.5）
item replace entity @s container.0 with minecraft:stick[\
    item_model="minecraft:golden_axe",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:golden_axe",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【选择工具】\",\"color\":\"green\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_select:true}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    item_name={"text":"【选择工具】","color":"green","bold":true},\
    custom_data={editor_tool:true,editor_tool_select:true}\
] 1
# 事件点/时间点工具（站立=事件点-命令方块矿车外观，蹲下=时间点-时钟外观）
# 可食用 + use_remainder 返还；custom_data 标记 editor_tool_timing；name/model 由 tool_regular_tick 按趴下状态动态改写
item replace entity @s container.1 with minecraft:stick[\
    item_model="minecraft:command_block_minecart",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:command_block_minecart",item_name:"{\"text\":\"【事件点工具】\",\"color\":\"yellow\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_timing:true}}},\
    enchantment_glint_override=true,\
    item_name={"text":"【事件点工具】","color":"yellow","bold":true},\
    custom_data={editor_tool:true,editor_tool_timing:true}\
] 1
# 暂停/播放（绿宝石外观）
item replace entity @s container.2 with minecraft:stick[\
    item_model="minecraft:emerald",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:emerald",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}}},\
    enchantment_glint_override=true,\
    item_name={"text":"【暂停/播放】","color":"green"},\
    custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}\
] 1
# 前进一刻（金锭外观；站立前进/蹲下快退；名由 tool_regular_tick 动态改写）
item replace entity @s container.3 with minecraft:stick[\
    item_model="minecraft:gold_ingot",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:gold_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_tick:true,editor_tool_fwd:"前进一刻",editor_tool_bwd:"快退一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}}},\
    enchantment_glint_override=true,\
    item_name={"text":"  【前进一刻】","color":"gold","extra":[{"text":" 蹲下以快退","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_tick:true,editor_tool_fwd:"前进一刻",editor_tool_bwd:"快退一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}\
] 1
# 音符盒（type 0；持有时实体交互距离 1.5）
item replace entity @s container.4 with minecraft:stick[\
    item_model="minecraft:note_block",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:note_block",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【音符盒】\",\"color\":\"gold\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_noteblock:true}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    item_name={"text":"【音符盒】","color":"gold","bold":true},\
    custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_noteblock:true}\
] 1
# 木板（type 1；持有时实体交互距离 1.5）
item replace entity @s container.5 with minecraft:stick[\
    item_model="minecraft:birch_planks",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:birch_planks",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【木板】\",\"color\":\"gold\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_plank:true}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    item_name={"text":"【木板】","color":"gold","bold":true},\
    custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_plank:true}\
] 1
# 唱片机（type 2；持有时实体交互距离 1.5）
item replace entity @s container.6 with minecraft:stick[\
    item_model="minecraft:jukebox",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:jukebox",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【唱片机】\",\"color\":\"gold\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_jukebox:true}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    item_name={"text":"【唱片机】","color":"gold","bold":true},\
    custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_jukebox:true}\
] 1
# 红染色玻璃（type 4；持有时实体交互距离 1.5）
item replace entity @s container.7 with minecraft:stick[\
    item_model="minecraft:red_stained_glass",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:red_stained_glass",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【染色玻璃】\",\"color\":\"red\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_glass:true}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    item_name={"text":"【染色玻璃】","color":"red","bold":true},\
    custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_glass:true}\
] 1
# 黄绿混凝土（type 3；持有时实体交互距离 1.5）
item replace entity @s container.8 with minecraft:stick[\
    item_model="minecraft:lime_concrete",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:lime_concrete",attack_range:{max_reach:1.5f,max_creative_reach:1.5f},attribute_modifiers:[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],item_name:"{\"text\":\"【混凝土】\",\"color\":\"green\",\"bold\":true}",custom_data:{editor_tool:true,editor_tool_note:true,editor_tool_note_concrete:true}}},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=[{type:"minecraft:entity_interaction_range",amount:-1.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},{type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}],\
    custom_data={editor_tool:true,editor_tool_note:true,editor_tool_note_concrete:true}\
] 1

tellraw @s [{"text":"[编辑器] 已将物品工具栏设为编辑工具组","color":"yellow"}]