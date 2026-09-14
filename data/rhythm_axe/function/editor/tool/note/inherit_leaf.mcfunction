#arg:cursor,index
# 继承遍历宏叶子（只处理当前这一个音符；绝不递归 / 不 return）
# 检查 notes[$(index)] 是否为同类且 time 不晚于当前音符（往前找，含同拍）
# 候选：同类 && time <= #inh_time；选 time 最大者 = 往前最近
# 同 time 用 >= 选 index 更大者（最后创建的，属性可能刚改过，优先继承）
# ★★ 2026-09-14 性能修复：这里原本每轮都 `data get ... notes` 取数组长度，
#   而 data get 一个「列表」会把整个列表**序列化成反馈文本**（972 音符 ≈ 260 KB/次），
#   循环 972 次 ⇒ 每次放置音符要生成 ~250 MB 临时字符串 ⇒ 单击到落音符卡 20 秒。
#   **绝对不要在循环体里 data get 列表长度**；改用「元素是否存在」判断遍历结束
#   （与 find_by_id_leaf / timing_inherit_leaf 同款）。
# ★ 2026-09-14 性能：每轮 6 行宏命令压到 4 行（去掉 #inh_done/#inh_found，改由 #inh_ex + prop.inherit_idx 判定）
# #inh_ex：1=元素存在（#inh_t 已读到 type） 0=元素缺失（遍历结束，由驱动 inherit_drive 判定）
$execute store success score #inh_ex editor run execute store result score #inh_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
$execute if score #inh_ex editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time run execute store result score #inh_n_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
$execute if score #inh_ex editor matches 1 if score #inh_t editor = #inh_type editor if score #inh_n_time editor <= #inh_time editor if score #inh_n_time editor >= #inh_best_time editor run data modify storage rhythm_axe:prop inherit_idx set value $(index)
execute if score #inh_ex editor matches 1 if score #inh_t editor = #inh_type editor if score #inh_n_time editor <= #inh_time editor if score #inh_n_time editor >= #inh_best_time editor run scoreboard players operation #inh_best_time editor = #inh_n_time editor