# 大厅（谱面总表）入口
# 用法：/function rhythm_axe:map_list/open   （@s = 打开者，必须是玩家）
#
# 设计：大厅**不依赖编辑器会话**（不写 maps.editor），自带状态 rhythm_axe:map_list。
#   **没有单人锁**：谁点开谁能用；多人同时打开共享页号（各自点击各自生效，不做互斥）。
#   点击值走**菜单系统自己的** trigger menu_click → tick 检测后交给 rhythm_axe:menu/consume 分发
execute unless entity @s[type=player] run return fail
# 编辑中 → 拒绝（编辑器会话与大厅是两套面板，且编辑中不允许开局）
execute if entity @s[tag=editor_active] run tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"请先退出编辑器，再来打开谱面总表","color":"gray"}]
execute if entity @s[tag=editor_active] run return fail
# trigger 需对本人启用（reload 时 load 已 enable @a，这里兜底：后进服的玩家也能点）
scoreboard players enable @s menu_click
data modify storage rhythm_axe:map_list open set value 1b
data modify storage rhythm_axe:map_list panel set value 19
execute unless data storage rhythm_axe:map_list page run data modify storage rhythm_axe:map_list page set value 0
# 索引表不存在时先建空表（data get 失败会保留旧值，先建可少一个坑）
execute unless data storage rhythm_axe:maps index run data modify storage rhythm_axe:maps index set value []
# 打开前自检索引（剔除已被外部删掉的谱面）
function rhythm_axe:maps/index/index_sync
function rhythm_axe:map_list/maps/list_open
