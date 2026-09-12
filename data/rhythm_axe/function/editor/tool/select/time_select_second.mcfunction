# 定出点：当前播放头 → time_select.out；选中判定时间落在 [min(in,out), max(in,out)] 内的音符（含两端）
data modify storage rhythm_axe:maps.editor time_select.out set from storage rhythm_axe:maps.editor playhead
execute store result score #ts_in editor run data get storage rhythm_axe:maps.editor time_select.in
execute store result score #ts_out editor run data get storage rhythm_axe:maps.editor time_select.out
# 区间规范化：出点在入点之前也能正常用（取 min/max）
scoreboard players operation #ts_min editor = #ts_in editor
execute if score #ts_out editor < #ts_min editor run scoreboard players operation #ts_min editor = #ts_out editor
scoreboard players operation #ts_max editor = #ts_in editor
execute if score #ts_out editor > #ts_max editor run scoreboard players operation #ts_max editor = #ts_out editor
# 清旧选中（selected 标记 + selection + 黄光 + 交互实体标记）
function rhythm_axe:editor/menu/note/selected/sel_clear_all
scoreboard players set #sel_count editor 0
execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
# ★ 区间判定遍历**工作副本 notes 数组**（不依赖音符交互实体）：交互实体只在播放头附近存活
#   （播放中出生→过后清理），若按实体判定，播放头后方/前方的时间段会“选中 0 个”
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop min int 1 run scoreboard players get #ts_min editor
execute store result storage rhythm_axe:prop max int 1 run scoreboard players get #ts_max editor
function rhythm_axe:editor/tool/select/time_select_len with storage rhythm_axe:prop
scoreboard players set #ts_i editor 0
function rhythm_axe:editor/tool/select/time_select_drive
# 重建 selection（按 notes 顺序收集 selected 标记，天然时间升序）
function rhythm_axe:editor/menu/note/selected/sel_rebuild
# 清宏参
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop min
data remove storage rhythm_axe:prop max
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop idx
# 入/出点保留（mod 时间轴继续显示范围色带与标记）；state 回 0 → 下次蹲右键开启新一轮
data modify storage rhythm_axe:maps.editor time_select.state set value 0
tellraw @s [{"text":"[编辑器] 出点已设为第 ","color":"yellow"},{"nbt":"time_select.out","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":" 刻；区间 ","color":"yellow"},{"score":{"name":"#ts_min","objective":"editor"},"color":"aqua"},{"text":" ~ ","color":"yellow"},{"score":{"name":"#ts_max","objective":"editor"},"color":"aqua"},{"text":" 刻内选中 ","color":"yellow"},{"score":{"name":"#sel_count","objective":"editor"},"color":"aqua"},{"text":" 个音符","color":"yellow"}]
execute if score #sel_count editor matches 0 run tellraw @s [{"text":"[编辑器] 该区间内没有音符","color":"red"}]
execute if score #sel_count editor matches 0 run function rhythm_axe:editor/menu/main
execute unless score #sel_count editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
