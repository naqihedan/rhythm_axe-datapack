#arg:cursor
# 跳到结尾：读工作副本 end_time（未定义则提示）；跳转后暂停播放
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].end_time run tellraw @s [{"text":"[编辑器] 未定义谱面结束时间","color":"red"}]
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].end_time run return fail
$data modify storage rhythm_axe:maps.editor playhead set from storage rhythm_axe:maps.editor history[$(cursor)].end_time
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
function rhythm_axe:editor/playback/pause
function rhythm_axe:editor/refresh
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 已跳到结尾（","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻）","color":"green"}]
