#arg:cursor,i,st_time
# 第二趟叶子：notes[i].time 在 prop.same_times 集合内 且 未选中 → 打 selected + 实体黄光/标记（★ 无上限）
# ★ st_time 由**驱动器**先读进 prop.st_time 再作为宏参数传入 ⇒ $(st_time) 在实例化时已知，
#   可直接做复合键存在性探测 same_times.$(st_time)（键 = time 字符串；time 缺失按不命中）。
#   参数空间 (cursor,i,st_time) 有界（time 值域有限）⇒ 宏缓存可控。
#   selnote 复制 + .selected 判定沿用 sel_rebuild_judge 手法（运行时值不进宏参数）。
data remove storage rhythm_axe:prop selnote
$data modify storage rhythm_axe:prop selnote set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)]
# 已选中的跳过（只加新的）
execute if data storage rhythm_axe:prop selnote.selected run scoreboard players set #st_ok editor 0
execute unless data storage rhythm_axe:prop selnote.selected run scoreboard players set #st_ok editor 1
# time 在集合内？（same_times 是复合：键 = time 的字符串形式，收集趟用 same_times.<time>=1b 写入）
$execute if score #st_ok editor matches 1 run data modify storage rhythm_axe:prop st_probe set from storage rhythm_axe:prop same_times.$(st_time)
execute if score #st_ok editor matches 1 unless data storage rhythm_axe:prop st_probe run scoreboard players set #st_ok editor 0
data remove storage rhythm_axe:prop st_probe
# 命中：计数 + 打 selected + 实体黄光/标记（★ 无上限：命中多少选多少）
execute if score #st_ok editor matches 1 run scoreboard players add #st_hit editor 1
execute if score #st_ok editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #st_j editor
$execute if score #st_ok editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
execute if score #st_ok editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #st_ok editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #st_ok editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
execute if score #st_ok editor matches 1 run function rhythm_axe:editor/tool/select/time_select_tag with storage rhythm_axe:prop
