# 节拍器开关：翻转 maps.editor.metronome（0b↔1b）并镜像计分板 #metronome，刷新主菜单
execute store result score #metronome editor run data get storage rhythm_axe:maps.editor metronome
scoreboard players set #temp editor 1
scoreboard players operation #temp editor -= #metronome editor
scoreboard players operation #metronome editor = #temp editor
data modify storage rhythm_axe:maps.editor metronome set value 0b
execute if score #metronome editor matches 1 run data modify storage rhythm_axe:maps.editor metronome set value 1b
function rhythm_axe:editor/menu/main
