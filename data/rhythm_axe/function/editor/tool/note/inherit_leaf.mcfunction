#arg:cursor,index
# 继承遍历宏叶子（只处理当前这一个音符；绝不递归 / 不 return）
# 检查 notes[$(index)] 是否为同类且 time 不晚于当前音符（往前找，含同拍）
# 候选：同类 && time <= #inh_time；选 time 最大者 = 往前最近
# 同 time 用 >= 选 index 更大者（最后创建的，属性可能刚改过，优先继承）
scoreboard players set #inh_total editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes run execute store result score #inh_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type run execute store result score #inh_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time run execute store result score #inh_n_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
# ★ 顺序必须"先记索引/标志，后更新 best_time"：三行条件相同，若先更新 best_time，
#   后两行再比较 #inh_n_time > #inh_best_time 会因 best_time 已变而恒 false（3 > 3 不成立）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type if score #inh_t editor = #inh_type editor if score #inh_n_time editor <= #inh_time editor if score #inh_n_time editor >= #inh_best_time editor run data modify storage rhythm_axe:prop inherit_idx set value $(index)
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type if score #inh_t editor = #inh_type editor if score #inh_n_time editor <= #inh_time editor if score #inh_n_time editor >= #inh_best_time editor run scoreboard players set #inh_found editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type if score #inh_t editor = #inh_type editor if score #inh_n_time editor <= #inh_time editor if score #inh_n_time editor >= #inh_best_time editor run scoreboard players operation #inh_best_time editor = #inh_n_time editor
