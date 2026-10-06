# 音符放置反馈（面板 23 坐标锁定）：按被锁定的轴给 feedback 加注
#   前置：无（自己读 tool_opt）
scoreboard players set #lf_mask editor 0
execute if score note_lock_x tool_opt matches 1 run scoreboard players add #lf_mask editor 1
execute if score note_lock_y tool_opt matches 1 run scoreboard players add #lf_mask editor 2
execute if score note_lock_z tool_opt matches 1 run scoreboard players add #lf_mask editor 4
data modify storage rhythm_axe:maps.editor feedback set value "已创建音符"
execute if score #lf_mask editor matches 1 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（X 已锁定）"
execute if score #lf_mask editor matches 2 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（Y 已锁定）"
execute if score #lf_mask editor matches 3 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（X+Y 已锁定）"
execute if score #lf_mask editor matches 4 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（Z 已锁定）"
execute if score #lf_mask editor matches 5 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（X+Z 已锁定）"
execute if score #lf_mask editor matches 6 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（Y+Z 已锁定）"
execute if score #lf_mask editor matches 7 run data modify storage rhythm_axe:maps.editor feedback set value "已创建音符（X+Y+Z 已锁定）"
