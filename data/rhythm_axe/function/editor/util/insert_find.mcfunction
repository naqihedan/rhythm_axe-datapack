# 插入点查找（指数查找上界 + 二分）—— 2026-09-14 D1b 重写
# 前置：prop.cursor（工作副本下标）、prop.list_name（"notes"/"events"/"timing_points"）、prop.new_time
# 输出：prop.insert_mode（"insert" / "append"）
#       + prop.insert_index（insert 模式）
#       + prop.index（insert 模式 = insert_index；append 模式 = 数组长度）
#         （paste_one / create 依赖 prop.index：append 时它必须等于旧数组长度）
#
# ★ 为什么重写：旧实现是「从 prop.index 起逐元素线性扫描」（insert_compare → insert_advance 递归），
#   每个元素一次宏展开 ≈ 20~40 ms/千元素；而且曾经每轮 data get 整表（更炸）。
#   现在 ≈ 2·log2(n) 次宏探测（千音符 ≈ 30 次 ≈ 1 ms）。
# ★ 正确性前提：数组**按 time 升序**——由 editor/util/order_repair 维护（批量改判定时间后 batch_confirm_go
#   会自动重排，谱面设置面板也有【整理音符顺序】按钮）。升序下二分找到的「首个 time > 新 time 的下标」
#   与旧线性扫描结果完全一致。
#   插入点约定（与旧实现相同）：time 相等视为「不大于」→ 插到与其相等的那些元素**之后**。
#
# 实现：驱动器为普通函数（递归可靠），探测用宏叶子 insert_find_probe（1 条命令/次）
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
scoreboard players set #ins_two editor 2
execute store result score #ins_new editor run data get storage rhythm_axe:prop new_time
# ── 特判 1：空数组（下标 0 不存在）→ append 到 0
data modify storage rhythm_axe:prop i set value 0
function rhythm_axe:editor/util/insert_find_probe with storage rhythm_axe:prop
scoreboard players set #ins_lo editor -1
scoreboard players set #ins_hi editor 0
execute if score #ins_ex editor matches 0 run scoreboard players set #ins_lo editor -1
execute if score #ins_ex editor matches 0 run scoreboard players set #ins_hi editor 0
execute if score #ins_ex editor matches 0 run function rhythm_axe:editor/util/insert_find_done with storage rhythm_axe:prop
execute if score #ins_ex editor matches 0 run return 0
# ── 特判 2：首元素 time > 新 time → 插到 0
execute if score #ins_t editor > #ins_new editor run scoreboard players set #ins_lo editor -1
execute if score #ins_t editor > #ins_new editor run scoreboard players set #ins_hi editor 0
execute if score #ins_t editor > #ins_new editor run function rhythm_axe:editor/util/insert_find_done with storage rhythm_axe:prop
execute if score #ins_t editor > #ins_new editor run return 0
# ── 正常路径：下标 0 已确认「存在且 time <= 新 time」→ lo=0，指数扩展上界
scoreboard players set #ins_lo editor 0
scoreboard players set #ins_hi editor 1
function rhythm_axe:editor/util/insert_find_exp with storage rhythm_axe:prop
