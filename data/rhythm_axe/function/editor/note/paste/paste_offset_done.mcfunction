# 时间偏移 = 基准 time - 最小 time（可为负，即整体提前）
execute store result score #temp editor run data get storage rhythm_axe:prop time
scoreboard players operation #temp editor -= #min_time editor
execute store result storage rhythm_axe:prop time_offset int 1 run scoreboard players get #temp editor
