# @s = 编辑器激活玩家。仅处理手持编辑工具（自定义数据标记）时进行动态名/模型改写。
# 已由调用方保证 @s 是 editor_active 玩家；此处只需判断手持工具即可提前返回。
execute unless data entity @s SelectedItem.components."minecraft:custom_data".editor_tool run return fail

# 1) 方向工具（前进XX ↔ 快退XX）：标记 editor_tool_fwd 存在
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_fwd run function rhythm_axe:editor/tool/tool_dir_update

# 2) 事件点/时间点工具（命令方块矿车 ↔ 时钟）：标记 editor_tool_timing 存在
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timing run function rhythm_axe:editor/tool/tool_timing_update

# 3) 返回开头工具（【返回开头】↔【跳到结尾】）：标记 editor_tool_timeline_start 存在
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_start run function rhythm_axe:editor/tool/tool_start_update

# 4) 播放速度工具（【播放速度】↔【音符流速】）：标记 editor_tool_timeline_speed 存在
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_speed run function rhythm_axe:editor/tool/tool_speed_update

# 5) 选择工具（【选择工具】金斧头 ↔【时间段选择】钻斧头）：标记 editor_tool_select 存在
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_select run function rhythm_axe:editor/tool/tool_select_update
