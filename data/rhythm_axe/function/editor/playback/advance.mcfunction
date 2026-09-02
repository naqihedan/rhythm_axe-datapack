# 编辑器播放推进（每 tick 由 tick.mcfunction 调用）：播放中播放头 +1、更新 bossbar、到尾自动停
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 1 run function rhythm_axe:editor/playback/advance_
