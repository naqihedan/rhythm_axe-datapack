#arg: cursor
# 点击进度条第 i 格（值 115001..115051）：跳到该格左端时刻 = (i−1) × end_time ÷ 50
#   ★ 第 51 格恰好使 (51−1)×end÷50 = end → 直跳结尾，无需特判
# 调用方式：先设 prop.cursor = history_cursor，再 function .../click with storage rhythm_axe:prop
scoreboard players operation #prog_i editor = #click_value editor
scoreboard players remove #prog_i editor 115000
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].end_time run tellraw @s [{"text":"[编辑器] 未定义谱面结束时间","color":"red"}]
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].end_time run return fail
$execute store result score #prog_end editor run data get storage rhythm_axe:maps.editor history[$(cursor)].end_time
data remove storage rhythm_axe:prop cursor
scoreboard players remove #prog_i editor 1
scoreboard players operation #prog_i editor *= #prog_end editor
scoreboard players set #prog_tmp editor 50
scoreboard players operation #prog_i editor /= #prog_tmp editor
data modify storage rhythm_axe:maps.editor playhead set value 0
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #prog_i editor
scoreboard players operation #playhead editor = #prog_i editor
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
function rhythm_axe:editor/playback/pause
# ★ 只移动播放头，不改音符 → 跳过 refresh 里的 selection 重建（省一整趟遍历）
data modify storage rhythm_axe:prop refresh_skip_sel set value 1b
function rhythm_axe:editor/refresh
schedule function rhythm_axe:editor/menu/main_next 1t
