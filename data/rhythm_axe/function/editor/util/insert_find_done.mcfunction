# 插入点确定（#ins_hi）：探测一次判断 insert / append，并写出 insert_mode / insert_index / index
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ins_hi editor
function rhythm_axe:editor/util/insert_find_probe with storage rhythm_axe:prop
# 元素存在 → 插到该下标；不存在（= 数组末尾）→ 追加
execute if score #ins_ex editor matches 1 run data modify storage rhythm_axe:prop insert_index set from storage rhythm_axe:prop i
execute if score #ins_ex editor matches 1 run data modify storage rhythm_axe:prop insert_mode set value "insert"
execute if score #ins_ex editor matches 0 run data modify storage rhythm_axe:prop insert_mode set value "append"
# prop.index：insert 模式 = 插入点；append 模式 = 数组长度（paste_one / create 依赖）
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #ins_hi editor
