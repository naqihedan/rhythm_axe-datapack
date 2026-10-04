# 批量重排·插回驱动：把 prop.move_out 里的音符逐个按「判定时间升序」二分插回 notes
#   前置：prop.cursor、prop.move_out（音符副本表，元素带新 time）；与 move_out_drive 配套
#   ★ 复用现成的 editor/util/insert_find（指数上界 + 二分，O(log M)/次）+ insert_at / insert_append
#     （与 note_panel_confirm_ 同款约定：prop.tmp_elem + prop.new_time + prop.list_name）
#   ★ 任意插入顺序都正确：每次插入前数组都是升序的（初始已有序 + 每次都插到正确位置）
#   ★ 普通函数递归（深 = 移出的音符数）
execute unless data storage rhythm_axe:prop move_out[0] run return 0
data modify storage rhythm_axe:prop tmp_elem set from storage rhythm_axe:prop move_out[-1]
data remove storage rhythm_axe:prop move_out[-1]
execute store result storage rhythm_axe:prop new_time int 1 run data get storage rhythm_axe:prop tmp_elem.time
data modify storage rhythm_axe:prop list_name set value "notes"
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_at with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_append with storage rhythm_axe:prop
data remove storage rhythm_axe:prop tmp_elem
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
function rhythm_axe:editor/util/move_in_drive
