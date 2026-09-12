tag @s remove editor_used_tool

# 主手优先（避免主副手都有工具时误分派副手）
# 时间轴控件工具
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_playpause:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_playpause
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_next_tick:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_step_tick
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_next_beat:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_step_beat
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_next_bar:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_step_bar
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_speed:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_speed
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_start:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_start
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_prev_tick:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_prev_tick
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_prev_beat:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_prev_beat
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timeline_prev_bar:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_prev_bar
# 事件点/时间点工具（站立=事件点、蹲下=时间点）
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_timing:true}] run return run function rhythm_axe:editor/tool/used_timeline_add
# 音符工具
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_note_noteblock:true}] run return run function rhythm_axe:editor/tool/note/used_note_noteblock
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_note_plank:true}] run return run function rhythm_axe:editor/tool/note/used_note_plank
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_note_jukebox:true}] run return run function rhythm_axe:editor/tool/note/used_note_jukebox
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_note_glass:true}] run return run function rhythm_axe:editor/tool/note/used_note_glass
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_note_concrete:true}] run return run function rhythm_axe:editor/tool/note/used_note_concrete
# 选择工具（金斧头）：站立=立方体框选两点；蹲下=时间轴入点/出点范围选择
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_select:true}] if entity @s[predicate=rhythm_axe:sneaking] run return run function rhythm_axe:editor/tool/select/used_time_select
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool_select:true}] run return run function rhythm_axe:editor/tool/select/used_select

# 副手（主手无工具时命中）
# 时间轴控件工具
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_playpause:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_playpause
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_next_tick:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_step_tick
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_next_beat:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_step_beat
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_next_bar:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_step_bar
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_speed:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_speed
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_start:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_start
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_prev_tick:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_prev_tick
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_prev_beat:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_prev_beat
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timeline_prev_bar:true}] run return run function rhythm_axe:editor/tool/timeline/used_timeline_prev_bar
# 事件点/时间点工具
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_timing:true}] run return run function rhythm_axe:editor/tool/used_timeline_add
# 音符工具
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_note_noteblock:true}] run return run function rhythm_axe:editor/tool/note/used_note_noteblock
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_note_plank:true}] run return run function rhythm_axe:editor/tool/note/used_note_plank
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_note_jukebox:true}] run return run function rhythm_axe:editor/tool/note/used_note_jukebox
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_note_glass:true}] run return run function rhythm_axe:editor/tool/note/used_note_glass
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_note_concrete:true}] run return run function rhythm_axe:editor/tool/note/used_note_concrete
# 选择工具（金斧头）：站立=立方体框选两点；蹲下=时间轴入点/出点范围选择
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_select:true}] if entity @s[predicate=rhythm_axe:sneaking] run return run function rhythm_axe:editor/tool/select/used_time_select
execute if items entity @s weapon.offhand *[custom_data~{editor_tool_select:true}] run return run function rhythm_axe:editor/tool/select/used_select
