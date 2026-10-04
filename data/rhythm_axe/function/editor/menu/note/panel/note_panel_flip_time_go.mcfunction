# 时间轴翻转（selection 的 time 绕 [min,max] 镜像） —— 真正干活的实现
# 由 note_panel_flip_time.mcfunction 分发进来：处理音符数 ≤ 50 → 本刻直调；> 50 → 由 note_panel_flip_time_next.mcfunction 跨刻调用。
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop flip_cursor
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "时间轴翻转"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# ① 计算 min/max（#flip_min 大数起，#flip_max 0 起；time 恒 >=0）
scoreboard players set #flip_min editor 2147483647
scoreboard players set #flip_max editor 0
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/panel/note_panel_flip_scan_drive
# ② 收集：逐个选中音符把判定时间**原地**改成镜像值 + 登记下标（顺序游标 O(M)，数组下标不变）
#    ★ 2026-10-03 性能重构（两次实测教训）：
#      旧版（全扫 find + remove + 重插）= O(N×M)：1139 音符 × 104 选中 ≈ 77 万条 → 撞链。
#      中间版（原地改 time + 一遍 order_repair）= O(M) + O(逆序数)：但 order_repair 是相邻交换冒泡，
#        逆序数 ≈ N²/2，实测**每步 ≈80 条命令**（一条链上限 100 万 ⇒ 最多 ≈1.2 万步）；
#        208 个音符 ≈ 2.2 万步 → 又在 `#ord_swaps=11068` 处爆链（日志 `executed 1000000 commands`）。
#      现版（原地改 + 登记 → 移出 → 二分插回）= O(M + N log M)，**无 N² 项**，
#        与「批量改判定时间」共用 editor/util/move_out_drive + move_in_drive；
#        208 选中 / 1243 音符实测只需 ≈5 万条，一趟完成。
#    ⚠️ 两个表必须先进清空，flip_cursor 必须归 0（它会从上一趟扫描的尾部继续）。
data modify storage rhythm_axe:prop move_idx set value []
data modify storage rhythm_axe:prop move_out set value []
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
function rhythm_axe:editor/menu/note/panel/note_panel_flip_apply_drive
# ③ 移出（按下标降序删，前面下标始终有效）+ 按新时间二分插回
function rhythm_axe:editor/util/move_out_drive
function rhythm_axe:editor/util/move_in_drive
data remove storage rhythm_axe:prop move_idx
data remove storage rhythm_axe:prop move_out
# ④ 收尾（本刻只 commit 快照；视觉刷新 + 反馈 + 回面板 全部推迟到下一刻）
# ★ 2026-09-12 修复（用户实测：连点第偶数次对称轴跑到 max / 世界里音符消失）：
#   翻转本身（扫描 + 逐个 find_by_id + 移出/二分插回）+ refresh（kill 全部实体后重建视觉、末尾还含 sel_rebuild 重建选区）
#   + 面板列表渲染，全挤在同一条命令链里会顶到 maxCommandChainLength。被截断的是**尾部**：
#     · 视觉重建被砍 → 世界里的音符消失（但 notes[].time 已经翻转正确）
#     · 末尾的 sel_rebuild 被砍 → selection 停留在「按旧下标升序」，而音符已被翻转搬走 ⇒ 下一次点击时
#       顺序游标找不到音符 ⇒ min/max 退化 ⇒ 对称轴跑到 max。这就是「奇数次正常、偶数次跑偏」的成因。
#   现在把 refresh 及其后全部 schedule 到下一刻（独立命令链），既不会截断、选区也一定会重建。
function rhythm_axe:editor/file/commit
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop flip_cursor
schedule function rhythm_axe:editor/menu/note/panel/note_panel_flip_finish_next 1t
