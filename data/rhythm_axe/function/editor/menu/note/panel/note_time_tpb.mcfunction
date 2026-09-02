# @s = 玩家；把播放头所在时间点的 tpb 写入 #time_step（供 判定时间 tpb 步长）
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
execute store result storage rhythm_axe:prop playhead int 1 run scoreboard players get #playhead editor
function rhythm_axe:editor/playback/current_timing
execute store result score #time_step editor run data get storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop playhead
