# 发放【协作工具】（container.9 = 主背包第 1 格：不占快捷栏、不与「音符工具组 / 时间控件组」的 0-8 冲突）
# 用途：站立右键玩家 = 邀请加入协作；蹲下右键玩家 = 踢出协作（@s = 接收者）
# 外观随蹲下状态由 tool_regular_slot → tool_coop_update 动态改写（站=命名牌【协作·邀请】/蹲=屏障【协作·踢出】）
# ★ 工具本体是 stick + consumable（0.05s）⇒ 右键由 advancement tool_use（consume_item）触发，与其它编辑工具同一条链。
#   原版已确认：右键「玩家」时客户端不消耗交互（Player.interact 返回 PASS）→ 仍会走 useItem ⇒ consume_item 会触发。
advancement revoke @s only rhythm_axe:editor/tool_use
advancement grant @s only rhythm_axe:editor/tool_use
# 清蹲下状态记录，强制下一 tick 重算外观（蹲下时发放也能立即切成蹲下态）
tag @s remove editor_tool_was_sneak
item replace entity @s container.9 with minecraft:stick[\
    item_model="minecraft:name_tag",\
    consumable={animation:none,consume_seconds:0.05f,has_consume_particles:false,sound:"minecraft:intentionally_empty"},\
    enchantment_glint_override=true,\
    item_name={"text":"【协作·邀请】","color":"green","bold":true,"extra":[{"text":"  右键玩家加入（蹲下为踢出）","color":"gray","italic":true}]},\
    custom_data={editor_tool:true,editor_tool_coop:true,editor_tool_model:"minecraft:name_tag",editor_tool_state:0}\
] 1
tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"协作工具已放入背包第 1 格：","color":"green"},{"text":"右键玩家=邀请，蹲下右键=踢出","color":"aqua"}]
