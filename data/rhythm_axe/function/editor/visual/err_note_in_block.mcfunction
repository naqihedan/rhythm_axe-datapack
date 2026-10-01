# 判定时刻报错：音符盒/木板（0/1）的【配对交互实体】自身处于方块中（= 音符判定箱底部埋进方块里）
# ★ 2026-09-30：由 visual/tick_one 在 place 之后调用（@s = 编辑器音符展示实体，执行上下文已 at @s）
#   ⚠ 位置必须取交互实体自己：它的 Pos 在方块底部（Y = 判定位置 − size/2），和展示实体（判定位置中心）不是一个点；
#     用判定位置中心去测会漏掉最常见的情况「音符下半埋进地板」（判定位置那格是空气）
#   ⚠ 计分板运算放这里而不是 tick_one：tick_one 是每刻 × 每个在场音符，只有门控命中那一刻才该花这点开销
# 坐标 = 交互实体所在方块（= 判定位置 ÷ 1000 向下取整；Y 先减 size/2）
scoreboard players operation #eib_nid editor = @s note_id
scoreboard players operation #eib_time editor = @s editor_n_time
scoreboard players operation #eib_x editor = @s editor_n_px
scoreboard players operation #eib_x editor /= 1000 const
scoreboard players operation #eib_h editor = @s editor_n_size
scoreboard players operation #eib_h editor /= 2 const
scoreboard players operation #eib_y editor = @s editor_n_py
scoreboard players operation #eib_y editor -= #eib_h editor
scoreboard players operation #eib_y editor /= 1000 const
scoreboard players operation #eib_z editor = @s editor_n_pz
scoreboard players operation #eib_z editor /= 1000 const
# 配对交互实体（同 note_id）→ 用【它自己】的位置测方块（after place 才是本刻位置）；命中才输出
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #eib_nid editor at @s unless block ~ ~ ~ air run \
tellraw @a[tag=editor_active] [\
{"text":"[编辑器] ","color":"red"},\
{"text":"音符位于方块中：","color":"red"},\
{"text":"id：","color":"gray"},{"score":{"name":"@s","objective":"note_id"},"color":"white"},\
{"text":"，time：","color":"gray"},{"score":{"name":"#eib_time","objective":"editor"},"color":"white"},\
{"text":"，x：","color":"red"},{"score":{"name":"#eib_x","objective":"editor"},"color":"red"},\
{"text":"，y：","color":"green"},{"score":{"name":"#eib_y","objective":"editor"},"color":"green"},\
{"text":"，z：","color":"blue"},{"score":{"name":"#eib_z","objective":"editor"},"color":"blue"}\
]
