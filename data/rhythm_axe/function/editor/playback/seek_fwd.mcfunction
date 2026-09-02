# 前进 prop.ticks 刻
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playhead
execute store result score #step_ticks editor run data get storage rhythm_axe:prop ticks
scoreboard players operation #temp editor += #step_ticks editor
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #temp editor
scoreboard players operation #playhead editor = #temp editor
# 同步播放进度 bossbar value（播放时由 advance_ 每 tick 更新，暂停状态下的跳转需手动刷新）
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
function rhythm_axe:editor/refresh
execute if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/playback/resync
# 时间控件刷新一次播放进度 actionbar
function rhythm_axe:editor/visual/progress_actionbar
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 播放头 → ","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻","color":"green"}]
