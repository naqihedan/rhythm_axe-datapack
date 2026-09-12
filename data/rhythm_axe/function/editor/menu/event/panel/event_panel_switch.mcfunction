#arg:cursor,index
# 面板切换到 index 处的事件（重载暂存 temp 并刷新）
data remove storage rhythm_axe:maps.editor editing.is_new
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
# ★ 切换到该事件点后，播放头也挪到该事件点位置（播放中自动重同步音乐与 tick rate）
$execute store result score #candidate editor run data get storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)].time
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #candidate editor
scoreboard players operation #playhead editor = #candidate editor
data modify storage rhythm_axe:prop playhead set from storage rhythm_axe:maps.editor playhead
execute if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/playback/resync
function rhythm_axe:editor/menu/event/panel/event_panel
