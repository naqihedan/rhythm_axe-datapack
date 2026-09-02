# 初始化 maps.editor 状态 + 单人锁标记（@s = 玩家）
tag @s add editor_active
scoreboard players enable @s editor_click
advancement grant @s only rhythm_axe:editor/note_click
advancement grant @s only rhythm_axe:editor/note_deselect
# 清掉可能的残留状态（1.21.5+ 禁止根路径 data remove，逐键删除）
function rhythm_axe:editor/clear_state
# 打开编辑器即开启 mod 可视化时间轴覆盖层（必须在 clear_state 之后，否则会被其清 0 覆盖）
scoreboard players set editor_timeline_gui options 1
# 写入默认状态
data modify storage rhythm_axe:maps.editor mapid set value ""
data modify storage rhythm_axe:maps.editor active set value 1b
data modify storage rhythm_axe:maps.editor player set from entity @s UUID
data modify storage rhythm_axe:maps.editor history set value []
data modify storage rhythm_axe:maps.editor history_cursor set value 0
data modify storage rhythm_axe:maps.editor saved_cursor set value 0
data modify storage rhythm_axe:maps.editor clipboard set value []
data modify storage rhythm_axe:maps.editor selection set value []
data modify storage rhythm_axe:maps.editor playhead set value 0
data modify storage rhythm_axe:maps.editor next_note_id set value 0
data modify storage rhythm_axe:maps.editor playing set value 0b
data modify storage rhythm_axe:maps.editor play_speed set value 1.0f
data modify storage rhythm_axe:maps.editor metronome set value 0b
data modify storage rhythm_axe:maps.editor tool_group set value "note"
data modify storage rhythm_axe:maps.editor tool_page set value 0
data modify storage rhythm_axe:maps.editor tool_note_type set value 0
data modify storage rhythm_axe:maps.editor editing set value {}
data modify storage rhythm_axe:maps.editor delete_confirm set value {}
data modify storage rhythm_axe:maps.editor input set value {}
data modify storage rhythm_axe:maps.editor panel_temp set value {}

# editor 计分板镜像（逐刻数值；play_speed 为浮点，仅在 storage 保存）
scoreboard players set #playhead editor 0
scoreboard players set #metronome editor 0
scoreboard players set #history_cursor editor 0
execute store result score #hist_limit editor run scoreboard players get editor_history_limit options
