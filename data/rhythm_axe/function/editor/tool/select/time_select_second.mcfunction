# 定出点：当前播放头 → time_select.out；选中判定时间落在 [min(in,out), max(in,out)] 内的音符（含两端）
data modify storage rhythm_axe:maps.editor time_select.out set from storage rhythm_axe:maps.editor playhead
execute store result score #ts_in editor run data get storage rhythm_axe:maps.editor time_select.in
execute store result score #ts_out editor run data get storage rhythm_axe:maps.editor time_select.out
# 区间规范化：出点在入点之前也能正常用（取 min/max）
scoreboard players operation #ts_min editor = #ts_in editor
execute if score #ts_out editor < #ts_min editor run scoreboard players operation #ts_min editor = #ts_out editor
scoreboard players operation #ts_max editor = #ts_in editor
execute if score #ts_out editor > #ts_max editor run scoreboard players operation #ts_max editor = #ts_out editor
# 清旧选中（与面板 10【取消选中】11305 共用同一函数）
function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
# ★ 区间扫描只看「可能相交的一小段」，不再整表扫（整表扫描每音符一次宏展开 ≈ 1 ms：
#   411 音符实测单次 ~400 ms，谱面越大越糟，上千音符直接撞 200000 指令上限 → 卡死
#   ① 二分找到第一个 time ≥ min 的下标 #ts_lo
#   ② 正向：#ts_i 从 #ts_lo 起向后扫，time > max 即停（宏叶子置 #ts_stop）
#   ③ 反向：#ts_j 从 #ts_lo-1 起向前扫，只可能选到「头在区间外、混凝土尾巴伸进区间」的音符，
#      用「已见最大时长」做上界早退（#ts_stop）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/tool/select/time_select_len with storage rhythm_axe:prop
scoreboard players set #ts_lo editor 0
scoreboard players operation #ts_hi editor = #ts_len editor
scoreboard players set #ts_two editor 2
function rhythm_axe:editor/tool/select/time_select_find
scoreboard players operation #ts_i editor = #ts_lo editor
scoreboard players operation #ts_j editor = #ts_lo editor
scoreboard players remove #ts_j editor 1
scoreboard players set #ts_maxdur editor 0
function rhythm_axe:editor/tool/select/time_select_back_drive
function rhythm_axe:editor/tool/select/time_select_drive
# （selection 不在此处重建：下面弹「已选定音符列表」时 sel_note_list_open 内部会 rebuild 一次；
#   命中 0 个时 selection 本来就是空的）
# 清宏参
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop idx
# 入/出点保留（mod 时间轴继续显示范围色带与标记）；state 回 0 → 下次蹲右键开启新一轮
data modify storage rhythm_axe:maps.editor time_select.state set value 0
tellraw @s [{"text":"[编辑器] 出点已设为第 ","color":"yellow"},{"nbt":"time_select.out","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":" 刻；区间 ","color":"yellow"},{"score":{"name":"#ts_min","objective":"editor"},"color":"aqua"},{"text":" ~ ","color":"yellow"},{"score":{"name":"#ts_max","objective":"editor"},"color":"aqua"},{"text":" 刻内选中 ","color":"yellow"},{"score":{"name":"#sel_count","objective":"editor"},"color":"aqua"},{"text":" 个音符","color":"yellow"}]
execute if score #sel_count editor matches 0 run tellraw @s [{"text":"[编辑器] 该区间内没有音符（已清空选中，不打开面板）","color":"red"}]
execute unless score #sel_count editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
