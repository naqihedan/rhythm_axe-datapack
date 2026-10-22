# 查找音符·分刻扫描驱动器（普通函数，防 26.x 宏递归幽灵重跑）：
#   每刻最多处理 CHUNK=64 个音符（#fn_chunk 计数），处理满 → schedule 下一刻继续（find_note_scan_next 切回玩家）。
#   扫完（#fn_i >= #fn_hi）→ find_note_finish（收尾：sel_rebuild + 反馈 + 弹列表 + 清状态）。
# 前置：#fn_i（当前下标）、#fn_hi（开区间上界）、prop.cursor、find_scan.active 已置、全部 #fn_* 条件分数。
# ★ 分刻原因：宏叶子每次新展开 ≈ 1ms（全属性判定后单音符成本更高），2000 音符单刻 = 2 秒冻结；
#   64 个/刻 ≈ 数十 ms/刻（轻微卡顿不掉帧）。同 (cursor,i) 参数空间命中宏缓存后接近瞬完成。
# ★ 选区无上限（2026-10-22 纠正）：命中多少选多少，无 40 截断。
scoreboard players set #fn_chunk editor 0
function rhythm_axe:editor/menu/find/find_note_scan_step
# 本刻额度用完且还没扫完 → 下一刻继续
execute if score #fn_chunk editor matches 64 if score #fn_i editor < #fn_hi editor run schedule function rhythm_axe:editor/menu/find/find_note_scan_next 1t
# 扫完 → 收尾（同刻直接进，finish 很轻：sel_rebuild 是普通函数驱动 + 两条 tellraw + 列表渲染 schedule）
execute if score #fn_i editor >= #fn_hi editor run function rhythm_axe:editor/menu/find/find_note_finish
