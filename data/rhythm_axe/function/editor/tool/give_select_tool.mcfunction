# 给一套选择工具（金斧头，container.9）：右键两次循环定两角选立方体音符
# ⚠️ container.9 = **主背包第 1 格**（快捷栏 container.0-8 已被音符工具栏占满）；故蹲下切换工具的扫描范围必须含 container.9
#   第一次右键 定第一角 | 第二次右键 定第二角（确认选区+判定选中+弹已选定音符列表）后回第一角
# 金斧头：可食用（consumable，创造模式使用不消耗）+ custom_data.editor_tool_select
# 与音符工具/时间控件同款 consume_item 触发（editor/tool_use → use_ → use__ 分派）
# 武装工具使用进度（give 时 revoke+grant 一次即可，reward 顶部 revoke 可重复）
advancement revoke @s only rhythm_axe:editor/tool_use
advancement grant @s only rhythm_axe:editor/tool_use
# 清除蹲下状态记录，强制下一 tick 重算工具外观（蹲下时给予也能立即切到蹲下态）
tag @s remove editor_tool_was_sneak

# 重置选择工具状态（避免切换工具后残留上一轮选择）
data remove storage rhythm_axe:maps.editor select_tool
data remove storage rhythm_axe:maps.editor time_select
kill @e[tag=editor_tool_select_glow]
execute as @e[tag=editor_note,type=item_display] run data remove entity @s Glowing
execute as @e[tag=editor_note,type=item_display] run data remove entity @s glow_color_override
# ★ 2026-10-02 修复：原来只清 selection 数组，不清音符身上的 selected:1b 标记（也不清交互实体的 editor_note_selected）
#   ⇒ 之后一开「已选定音符列表」或一次 refresh 就会 sel_rebuild「复活」选区：列表里又冒出选中音符，
#   但【批量复制】读的 selection 数组是空的 → 报「没有可复制的音符」。
#   改调清选区的共用入口（selection + selected 标记 + 黄光 + 交互 tag + 锚点 + #sel_count，别再各写一遍）。
function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual

item replace entity @s container.9 with minecraft:stick[\
    item_model="minecraft:golden_axe",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    attack_range={max_reach:1.5f,max_creative_reach:1.5f},\
    attribute_modifiers=\
            [\
            {type:"minecraft:entity_interaction_range",amount:-4.0,operation:"add_value",id:"00000000-0000-0000-0000-000000000a01",slot:"mainhand"},\
            {type:"minecraft:block_interaction_range",amount:-2.5,operation:"add_value",id:"00000000-0000-0000-0000-000000000b02",slot:"mainhand"}\
            ],\
    item_name={"text":"【选择工具】","color":"green","bold":true,"extra":[{"text":"  蹲下为时间段选择","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_select:true,editor_tool_model:"minecraft:golden_axe",editor_tool_state:0}\
] 1

tellraw @s [{"text":"[编辑器] 已给予选择工具（金斧头）","color":"yellow"}]
