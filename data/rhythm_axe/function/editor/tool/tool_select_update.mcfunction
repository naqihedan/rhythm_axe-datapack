# @s = 编辑器激活玩家，手持选择工具（custom_data.editor_tool_select）。
# 站立 = 框选模式：金斧头【选择工具】（绿名）+ 黄绿玻璃预览；
# 蹲下 = 时间段选择模式：钻斧头【时间段选择】（淡蓝名）、不显示玻璃（只用 mod 时间轴上的入点/出点与范围色带）。
# 按蹲下状态与上次记录的 editor_tool_state 比对，不一致才重写（同 tool_dir_update / tool_timing_update）。
# 前置：已由 tool_regular_apply 确认手持该工具。

# 当前蹲下状态：0=站立 1=蹲下
scoreboard players set #tool_sneak editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #tool_sneak editor 1
# 上次记录状态（缺字段的旧工具 → -1，保证会重写一次把字段补上）
scoreboard players set #tool_state editor -1
execute store result score #tool_state editor run data get entity @s SelectedItem.components."minecraft:custom_data".editor_tool_state 1
execute if score #tool_sneak editor = #tool_state editor run return fail

# 状态变化 → 重写（站立：金斧头；蹲下：钻斧头）
execute if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_select_write {shown:"选择工具",model:"minecraft:golden_axe",hint:"蹲下为时间段选择",color:"green",state:0}
execute if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_select_write {shown:"时间段选择",model:"minecraft:diamond_axe",hint:"站立为框选音符",color:"aqua",state:1}
