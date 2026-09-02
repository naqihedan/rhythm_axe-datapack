# 播放头回开头：playhead = min(0, 所有音符最早出生时刻) - 1（与游玩 init_game 一致）
# 保证最早音符出生时播放头刚好到出生点，能看到完整生命周期
scoreboard players set #earliest_birth editor 1000000
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/visual/scan_birth with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
# playhead = min(0, earliest) - 1（add 不接受负数，用 remove 1）
scoreboard players set #playhead editor 0
execute if score #earliest_birth editor matches ..0 run scoreboard players operation #playhead editor = #earliest_birth editor
scoreboard players remove #playhead editor 1
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #playhead editor
# 返回开头同步播放进度 bossbar value（与 seek_fwd/seek_back 一致）
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
# 时间控件刷新一次播放进度 actionbar
function rhythm_axe:editor/visual/progress_actionbar
