#arg:cursor
# 组装播放参数并开始（prop：music/tick/speed/bpm/tpb 已就绪）
# 清延迟音乐标记残留
data remove storage rhythm_axe:editor.runtime music_wait
data remove storage rhythm_axe:editor.runtime music_wait_music
data remove storage rhythm_axe:editor.runtime music_wait_speed
$data modify storage rhythm_axe:prop music set from storage rhythm_axe:maps.editor history[$(cursor)].music
# ★ 预热解码：后台解码整首 OGG（约 0.1s），playhead 到达 0 时 playmusic 缓存命中零延迟
function rhythm_axe:editor/playback/preload_ with storage rhythm_axe:prop
data modify storage rhythm_axe:prop tick set from storage rhythm_axe:maps.editor playhead
# ★ 播放头为负（返回开头）：音乐不立即播，存标记等 playhead==0 再从头播（对齐音符 time=0，与游玩 time==0 一致）
#   否则音乐提前负播放头的刻数播放，比音符/游玩早很多
# playmusic 起始 tick 不能为负 → clamp 到 0（音乐从头播）
execute store result score #tick editor run data get storage rhythm_axe:maps.editor playhead
execute if score #tick editor matches ..-1 run data modify storage rhythm_axe:prop tick set value 0
execute if score #tick editor matches ..-1 run data modify storage rhythm_axe:editor.runtime music_wait set value 1b
execute if score #tick editor matches ..-1 run data modify storage rhythm_axe:editor.runtime music_wait_music set from storage rhythm_axe:prop music
execute if score #tick editor matches ..-1 run data modify storage rhythm_axe:editor.runtime music_wait_speed set from storage rhythm_axe:maps.editor play_speed
data modify storage rhythm_axe:prop speed set from storage rhythm_axe:maps.editor play_speed
data modify storage rhythm_axe:maps.editor playing set value 1b
# 记录当前段 bpm/tpb（×1000 取整）供 advance_ 检测时间点变化（播放经过红线随之更新 tick rate）
execute store result score #rate_bpm editor run data get storage rhythm_axe:prop bpm 1000
execute store result score #rate_tpb editor run data get storage rhythm_axe:prop tpb
function rhythm_axe:editor/playback/tickrate_ with storage rhythm_axe:prop
# 播放头 >=0：立即从播放头处播；负：等 advance_ 里 playhead==0 再播
execute unless score #tick editor matches ..-1 run function rhythm_axe:editor/playback/playmusic_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop music
data remove storage rhythm_axe:prop tick
data remove storage rhythm_axe:prop speed
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop bpm
data remove storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop bpb
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop playhead
data remove storage rhythm_axe:prop direction
data remove storage rhythm_axe:prop ticks
data remove storage rhythm_axe:prop kind
# 播放进度 bossbar（end_time 未定义则不显示）
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].end_time
execute if score #temp editor matches 1.. run bossbar set rhythm_axe:editor_progress players @a
execute if score #temp editor matches 1.. run execute store result bossbar rhythm_axe:editor_progress max run scoreboard players get #temp editor
execute if score #temp editor matches 1.. run bossbar set rhythm_axe:editor_progress visible true
execute if score #temp editor matches ..0 run bossbar set rhythm_axe:editor_progress visible false
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 播放中（","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻）","color":"green"}]
