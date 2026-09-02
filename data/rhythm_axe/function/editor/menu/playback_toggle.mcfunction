# 播放/暂停切换（按 playing 状态）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 1 run function rhythm_axe:editor/playback/pause
execute unless score #temp editor matches 1 run function rhythm_axe:editor/playback/play
# 任意面板可用：返回当前面板（resume）而非强制主菜单
function rhythm_axe:editor/menu/resume
