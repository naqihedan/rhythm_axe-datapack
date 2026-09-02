# 跳到候选（上一个时间点/事件点）：无候选 → 提示已在第一个；播放中重同步
execute store result score #candidate editor run data get storage rhythm_axe:prop candidate_time
execute if score #candidate editor matches -1 run tellraw @s [{"text":"[编辑器] 已在第一个","color":"yellow"}]
execute if score #candidate editor matches -1 run function rhythm_axe:editor/util/jump_cleanup
execute if score #candidate editor matches -1 run return fail
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #candidate editor
scoreboard players operation #playhead editor = #candidate editor
data modify storage rhythm_axe:prop playhead set from storage rhythm_axe:maps.editor playhead
execute if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/playback/resync
tellraw @s [{"text":"[编辑器] 播放头 → ","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻","color":"green"}]
function rhythm_axe:editor/util/jump_cleanup
