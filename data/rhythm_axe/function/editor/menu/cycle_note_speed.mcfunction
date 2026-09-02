# 音符流速循环：2 → 4 → 8 → 16 → 2（播放速度工具下蹲使用）；当前值非预设（如 −/＋ 调出的 5）时归到 2；调整后刷新世界音符显示
execute store result score #temp editor run scoreboard players get note_speed options
execute if score #temp editor matches 2 run scoreboard players set note_speed options 4
execute if score #temp editor matches 4 run scoreboard players set note_speed options 8
execute if score #temp editor matches 8 run scoreboard players set note_speed options 16
execute if score #temp editor matches 16 run scoreboard players set note_speed options 2
execute unless score #temp editor matches 2 unless score #temp editor matches 4 unless score #temp editor matches 8 unless score #temp editor matches 16 run scoreboard players set note_speed options 2
function rhythm_axe:editor/refresh
function rhythm_axe:editor/menu/resume
