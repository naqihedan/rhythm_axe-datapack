# 跳到目标（下一个时间点/事件点）：播放头 = 当前元素 time；播放中重同步
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #timing_time editor
scoreboard players operation #playhead editor = #timing_time editor
data modify storage rhythm_axe:prop playhead set from storage rhythm_axe:maps.editor playhead
execute if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/playback/resync
tellraw @s [{"text":"[编辑器] 播放头 → ","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻","color":"green"}]
function rhythm_axe:editor/util/jump_cleanup
