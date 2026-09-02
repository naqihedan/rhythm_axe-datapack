# 给整套时间轴控件工具（9 个可食用锭/宝石，右键使用触发 editor_click 对应按钮值）
# 前进工具站立=前进、蹲下=后退；快退工具站立=快退、蹲下=快进（均用谓词 rhythm_axe:sneaking）
# 返回开头工具站立=返回开头、蹲下=跳到结尾（在 used_timeline_start 用谓词 rhythm_axe:sneaking 判定）
# 名/模型由 tool_regular_tick 按趴下状态动态改写
# 物品栏 0-8 按顺序：石英 铜锭 铁锭 金锭 绿宝石 金锭 铁锭 铜锭 紫水晶碎片
#   container.0 石英     返回开头(蹲下=跳到结尾) | container.1 铜锭    后退一小节 | container.2 铁锭    后退一拍
#   container.3 金锭     后退一刻   | container.4 绿宝石  播放/暂停  | container.5 金锭    前进一刻
#   container.6 铁锭     前进一拍   | container.7 铜锭    前进一小节 | container.8 紫水晶碎片 播放速度
# direction 工具 custom_data 带 editor_tool_fwd(站起名)/editor_tool_bwd(蹲下名)/editor_tool_model/editor_tool_state(0=站 1=蹲)
# 武装工具使用进度（consume_item 触发；give 时 revoke+grant 一次即可，reward 顶部 revoke 可重复）
advancement revoke @s only rhythm_axe:editor/tool_use
advancement grant @s only rhythm_axe:editor/tool_use

# 返回开头（石英外观；站立=返回开头、蹲下=跳到结尾）
item replace entity @s container.0 with minecraft:stick[\
        item_model="minecraft:quartz",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:quartz",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【返回开头】","color":"yellow","extra":[{"text":" 蹲下以跳到结尾","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_start:true,editor_tool_state:0}\
    ] 1
# 播放/暂停（绿宝石外观）
item replace entity @s container.4 with minecraft:stick[\
        item_model="minecraft:emerald",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:emerald",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【暂停/播放】","color":"green"},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_playpause:true}\
    ] 1
# 前进一刻（金锭外观；站立前进/蹲下后退；名由 tool_regular_tick 动态改写）
item replace entity @s container.5 with minecraft:stick[\
        item_model="minecraft:gold_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:gold_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_tick:true,editor_tool_fwd:"前进一刻",editor_tool_bwd:"快退一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【前进一刻】","color":"gold","extra":[{"text":" 蹲下以快退","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_tick:true,editor_tool_fwd:"前进一刻",editor_tool_bwd:"快退一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}\
    ] 1
# 前进一拍（铁锭外观；站立前进/蹲下后退；名由 tool_regular_tick 动态改写）
item replace entity @s container.6 with minecraft:stick[\
        item_model="minecraft:iron_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:iron_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_beat:true,editor_tool_fwd:"前进一拍",editor_tool_bwd:"快退一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【前进一拍】","color":"gold","extra":[{"text":" 蹲下以快退","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_beat:true,editor_tool_fwd:"前进一拍",editor_tool_bwd:"快退一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}\
    ] 1
# 前进一小节（铜锭外观；站立前进/蹲下后退；名由 tool_regular_tick 动态改写）
item replace entity @s container.7 with minecraft:stick[\
        item_model="minecraft:copper_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:copper_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_bar:true,editor_tool_fwd:"前进一小节",editor_tool_bwd:"快退一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【前进一小节】","color":"gold","extra":[{"text":" 蹲下以快退","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_next_bar:true,editor_tool_fwd:"前进一小节",editor_tool_bwd:"快退一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}\
    ] 1
# 播放速度（紫水晶碎片外观；站立=播放速度循环、蹲下=音符流速工具；名由 tool_regular_tick 动态改写）
item replace entity @s container.8 with minecraft:stick[\
        item_model="minecraft:amethyst_shard",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:amethyst_shard",item_name:"{\"text\":\"【播放速度】\",\"color\":\"light_purple\",\"extra\":[{\"text\":\" 蹲下以调整音符流速\",\"color\":\"gray\",\"italic\":true}]}",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"【播放速度】","color":"light_purple","extra":[{"text":" 蹲下以调整音符流速","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_speed:true,editor_tool_state:0}\
    ] 1
# 后退一刻（金锭外观；站立后退/蹲下前进；名由 tool_regular_tick 动态改写）
item replace entity @s container.3 with minecraft:stick[\
        item_model="minecraft:gold_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:gold_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_tick:true,editor_tool_fwd:"快退一刻",editor_tool_bwd:"快进一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一刻】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_tick:true,editor_tool_fwd:"快退一刻",editor_tool_bwd:"快进一刻",editor_tool_model:"minecraft:gold_ingot",editor_tool_state:0}\
    ] 1
# 后退一拍（铁锭外观；站立后退/蹲下前进；名由 tool_regular_tick 动态改写）
item replace entity @s container.2 with minecraft:stick[\
        item_model="minecraft:iron_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:iron_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_beat:true,editor_tool_fwd:"快退一拍",editor_tool_bwd:"快进一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一拍】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_beat:true,editor_tool_fwd:"快退一拍",editor_tool_bwd:"快进一拍",editor_tool_model:"minecraft:iron_ingot",editor_tool_state:0}\
    ] 1
# 后退一小节（铜锭外观；站立后退/蹲下前进；名由 tool_regular_tick 动态改写）
item replace entity @s container.1 with minecraft:stick[\
        item_model="minecraft:copper_ingot",\
        consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
        use_remainder={id:"minecraft:stick",components:{item_model:"minecraft:copper_ingot",custom_data:{editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_bar:true,editor_tool_fwd:"快退一小节",editor_tool_bwd:"快进一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}}},\
        enchantment_glint_override=true,\
        item_name={"text":"  【快退一小节】","color":"gold","extra":[{"text":" 蹲下以快进","color":"gray","italic":true}]},\
        custom_data={editor_tool:true,editor_tool_timeline:true,editor_tool_timeline_prev_bar:true,editor_tool_fwd:"快退一小节",editor_tool_bwd:"快进一小节",editor_tool_model:"minecraft:copper_ingot",editor_tool_state:0}\
    ] 1

tellraw @s [{"text":"[编辑器] 已将物品工具栏设为时间控件组","color":"yellow"}]