#arg:cursor,idx,st_found,st_time
# 第一趟叶子：selection[idx] → find_by_id → 该音符 time 追加进 prop.same_times（去重：已存在则跳过）
# ★ find_by_id 是普通函数驱动（前置 prop.cursor/prop.index/prop.note_id，命中写 prop.found_index）
# ★ found_index/st_time 是**运行时值**（find_by_id 写的）⇒ 不能直接 $(found_index)（实例化时还是旧值）。
#   正解：find_by_id 命中后把 found_index 拷到固定路径 prop.st_found，**本叶子分两段**——
#   段 1（普通命令）：跑 find_by_id + 拷 st_found + 读 time 进 prop.st_time；
#   段 2（宏行）：用 $(st_found)/$(st_time) —— 但同一实例里宏变量在实例化时就固定了，段 2 拿不到段 1 写的值！
#   ⇒ 真正可行的做法：**驱动器分两跳**。本叶子只做段 1（跑 find_by_id + 拷贝），
#     驱动器随后以 (cursor,idx,st_found,st_time) 调第二跳叶子 find_same_time_collect_append。
data modify storage rhythm_axe:prop index set value 0
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(idx)]
function rhythm_axe:editor/util/find_by_id
# 命中 → 拷 found_index 到固定路径 + 读 time 到固定路径（供第二跳叶子作宏参数）
# ★ $(st_found) 在**本实例**里是进入时的旧值（未命中时可能不存在）⇒ 不能用它做 notes 下标；
#   改用「先拷 found_index → 再用固定路径 prop.st_found 作**普通命令**的路径」——
#   但下标必须是数字字面量或宏变量……⇒ 干脆把「读 time」也挪到第二跳叶子（它拿到的 st_found 是新值）。
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop st_found set from storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop found_index
