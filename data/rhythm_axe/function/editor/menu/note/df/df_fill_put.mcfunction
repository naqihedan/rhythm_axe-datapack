#arg: cursor, src, t
# 在时刻 $(t) 放一颗新音符：复制模板 notes[$(src)] → 打新 id / 新 time / df_new / selected → 按 time 插回
#   ★ 本函数**不做任何判重**：该刻已有音符也照生成（头尾已由调用方排除；同刻问题交给
#     「允许一刻内填充多个音符」开关 + 后面的分布阶段处理）
# 计数：本次真正生成的新音符（df_fill_go 末尾汇报用）
scoreboard players add #fg_new editor 1
$data modify storage rhythm_axe:prop tmp_elem set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(src)]
data remove storage rhythm_axe:prop tmp_elem.selected
data modify storage rhythm_axe:prop tmp_elem.df_new set value 1b
data modify storage rhythm_axe:prop tmp_elem.selected set value 1b
execute store result storage rhythm_axe:prop tmp_elem.id int 1 run scoreboard players get #fill_id editor
scoreboard players add #fill_id editor 1
$data modify storage rhythm_axe:prop tmp_elem.time set value $(t)
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop tmp_elem.time
data modify storage rhythm_axe:prop list_name set value "notes"
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_at with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_append with storage rhythm_axe:prop
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
