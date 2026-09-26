#arg:slot
# 协作工具（蹲下变体）：站立 = 命名牌【协作·邀请】（绿名）；蹲下 = 屏障【协作·踢出】（红名）。
# 前置：调用方（tool_regular_slot）已写入 #tool_sneak；此处只在该槽状态与目标不符时重写。
# 模式与 tool_select_update 完全一致（避免每次蹲下都重写物品）。
$execute if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_coop_write {slot:"$(slot)",shown:"协作·邀请",model:"minecraft:name_tag",hint:"右键玩家加入（蹲下为踢出）",color:"green",state:0}
$execute if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_coop_write {slot:"$(slot)",shown:"协作·踢出",model:"minecraft:barrier",hint:"右键玩家踢出（站立为邀请）",color:"red",state:1}
