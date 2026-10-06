# 判定副手工具属于哪个选项栏分组（结果写 #tool_group editor；0 = 未知）
#   1 音符工具（音符盒/木板/唱片机/玻璃/混凝土，共 5 个）
#   2 时间轴工具（6 个快进快退方向工具 + 播放暂停，共 7 个，共用一栏）
#   3 回到开头/跳到结尾工具   4 播放速度工具   5 选择工具   6 事件点/时间点工具   7 协作工具
# 注：不能按 editor_tool_timeline 判时间轴组 —— 返回开头/播放速度也带该标记，必须按各自的专属标记分。
scoreboard players set #tool_group editor 0
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_note:true}] run scoreboard players set #tool_group editor 1
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_playpause:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_next_tick:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_next_beat:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_next_bar:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_prev_tick:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_prev_beat:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_prev_bar:true}] run scoreboard players set #tool_group editor 2
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_start:true}] run scoreboard players set #tool_group editor 3
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_speed:true}] run scoreboard players set #tool_group editor 4
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_select:true}] run scoreboard players set #tool_group editor 5
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timing:true}] run scoreboard players set #tool_group editor 6
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_coop:true}] run scoreboard players set #tool_group editor 7
