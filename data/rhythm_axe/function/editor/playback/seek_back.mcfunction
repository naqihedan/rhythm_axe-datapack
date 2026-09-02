# 后退 prop.ticks 刻（clamp ≥ min(0, 最早出生)-1，与 seek_start/jump_start 一致）
# 最早出生前一刻可见完整生命周期；钳制下限 = min(0, earliest_birth) - 1
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playhead
execute store result score #step_ticks editor run data get storage rhythm_axe:prop ticks
scoreboard players operation #temp editor -= #step_ticks editor
# 算最早出生（scan_birth 递归遍历全部音符 → #earliest_birth）
scoreboard players set #earliest_birth editor 1000000
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/visual/scan_birth with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
# 下限 = min(0, earliest) - 1（add 不接受负数，用 remove 1）
scoreboard players set #floor editor 0
execute if score #earliest_birth editor matches ..0 run scoreboard players operation #floor editor = #earliest_birth editor
scoreboard players remove #floor editor 1
execute if score #temp editor < #floor editor run scoreboard players operation #temp editor = #floor editor
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #temp editor
scoreboard players operation #playhead editor = #temp editor
# 同步播放进度 bossbar value（播放时由 advance_ 每 tick 更新，暂停状态下的跳转需手动刷新）
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
function rhythm_axe:editor/refresh
execute if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/playback/resync
# 时间控件刷新一次播放进度 actionbar
function rhythm_axe:editor/visual/progress_actionbar
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 播放头 → ","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻","color":"green"}]
