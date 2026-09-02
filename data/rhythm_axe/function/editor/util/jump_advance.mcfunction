# 记录候选 time（prev 跳转用），游标 +1 后继续查找
execute store result storage rhythm_axe:prop candidate_time int 1 run scoreboard players get #timing_time editor
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/util/jump_find with storage rhythm_axe:prop
