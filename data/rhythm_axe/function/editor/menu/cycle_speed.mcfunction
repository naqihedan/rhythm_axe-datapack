# 播放速度循环：0.25 → 0.5 → 0.75 → 1.0 → 0.25；播放中重同步音乐
execute store result score #temp editor run data get storage rhythm_axe:maps.editor play_speed 100
execute if score #temp editor matches 100 run data modify storage rhythm_axe:maps.editor play_speed set value 0.25f
execute if score #temp editor matches 25 run data modify storage rhythm_axe:maps.editor play_speed set value 0.5f
execute if score #temp editor matches 50 run data modify storage rhythm_axe:maps.editor play_speed set value 0.75f
execute if score #temp editor matches 75 run data modify storage rhythm_axe:maps.editor play_speed set value 1.0f
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 1 run function rhythm_axe:editor/playback/play
# 任意面板可用：返回当前面板（resume）而非强制主菜单
function rhythm_axe:editor/menu/resume
