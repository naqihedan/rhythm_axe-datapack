# ========== 确认并生成时间轴 ==========
execute if score is_editing editor matches 0 run tellraw @s [{"text":"当前不在时间轴编辑状态","color":"red","bold":true}]
execute if score is_editing editor matches 0 run return 0
execute if score length editor matches 0..512 run function rhythm_axe:editor/set_up/set_up

# 长度合法 → 先传送回去（需要 player_origin），再清除编辑状态和标记
execute if score length editor matches 0..512 run function rhythm_axe:editor/preview/mount/return
execute if score length editor matches 0..512 run scoreboard players set is_editing editor 0
execute if score length editor matches 0..512 run kill @e[type=block_display,tag=timeline_preview]
execute if score length editor matches 0..512 run kill @e[type=marker,tag=player_origin]
execute if score length editor matches 0..512 run kill @e[type=marker,tag=timeline_start]
execute if score length editor matches 0..512 run tellraw @s [{"text":"时间轴已生成！","color":"green","bold":true}]

# 长度非法 → 报错提示
execute if score length editor matches 513.. run tellraw @s [{"text":"【错误】长度超过512！请调整参数后重新确认","color":"red","bold":true}]
