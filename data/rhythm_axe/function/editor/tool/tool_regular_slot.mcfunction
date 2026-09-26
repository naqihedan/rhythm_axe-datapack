#arg:slot
# 处理 $(slot) 槽位的编辑工具：按 custom_data 标记分派到对应工具的 update（各 update 自带蹲下状态判断与防重复改写）。
# 前置：调用方已写入 #tool_sneak（0=站立 1=蹲下）。
$execute unless items entity @s $(slot) *[custom_data~{editor_tool:true}] run return fail

# 1) 方向工具（前进XX ↔ 快退XX）：★ editor_tool_fwd 存的是**名字字符串**（如 "前进一刻"）而非布尔，
#    不能写 custom_data~{editor_tool_fwd:true}（items 谓词要求键值类型全等）→ 改按 6 个 marker 布尔标记分派
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_next_tick:true}] run function rhythm_axe:editor/tool/tool_dir_update {slot:"$(slot)"}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_next_beat:true}] run function rhythm_axe:editor/tool/tool_dir_update {slot:"$(slot)"}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_next_bar:true}] run function rhythm_axe:editor/tool/tool_dir_update {slot:"$(slot)"}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_prev_tick:true}] run function rhythm_axe:editor/tool/tool_dir_update {slot:"$(slot)"}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_prev_beat:true}] run function rhythm_axe:editor/tool/tool_dir_update {slot:"$(slot)"}
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_prev_bar:true}] run function rhythm_axe:editor/tool/tool_dir_update {slot:"$(slot)"}
# 2) 事件点/时间点工具（命令方块矿车 ↔ 时钟）
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timing:true}] run function rhythm_axe:editor/tool/tool_timing_update {slot:"$(slot)"}
# 3) 返回开头工具（【返回开头】↔【跳到结尾】）
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_start:true}] run function rhythm_axe:editor/tool/tool_start_update {slot:"$(slot)"}
# 4) 播放速度工具（【播放速度】↔【音符流速】）
$execute if items entity @s $(slot) *[custom_data~{editor_tool_timeline_speed:true}] run function rhythm_axe:editor/tool/tool_speed_update {slot:"$(slot)"}
# 5) 选择工具（【选择工具】金斧头 ↔【时间段选择】钻斧头）
$execute if items entity @s $(slot) *[custom_data~{editor_tool_select:true}] run function rhythm_axe:editor/tool/tool_select_update {slot:"$(slot)"}
# 7) 协作工具（【协作·邀请】命名牌 ↔【协作·踢出】屏障）
$execute if items entity @s $(slot) *[custom_data~{editor_tool_coop:true}] run function rhythm_axe:editor/tool/tool_coop_update {slot:"$(slot)"}
# 6) 配对音符工具（音符盒 ↔ 木板、染色玻璃 ↔ 混凝土）
$execute if items entity @s $(slot) *[custom_data~{editor_tool_note_pair:true}] run function rhythm_axe:editor/tool/tool_note_update {slot:"$(slot)"}
