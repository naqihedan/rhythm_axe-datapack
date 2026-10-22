# 查找音符·分刻扫描入口（2026-10-22 全属性版，替代旧 find_note_filter 单刻实现）：
#   前置（由 dialog_submit_find_note_core 解析好）：#fn_type/#fn_color/#fn_easing/#fn_power/#fn_hs/#fn_pt
#   （-1=不限）、#fn_igsp/#fn_fwp/#fn_insel（-1=不限/0=关/1=开）、
#   #fn_t_lo/#fn_t_hi 等范围对（配 #fn_has_*_lo/#fn_has_*_hi 哨兵：2=有值/1=空）、#fn_px..#fn_sz2（×10 定点）。
# 流程：① 「查找选区内」模式守卫（勾了但没选中 → 报错退出）② 非选区模式清选中 ③ 二分定位时间窗
#   ④ 置 find_scan.active（consume 顶部守卫：扫描期间锁编辑器点击）⑤ 提示 + 本刻先扫第一块。
# ★ 选区无上限（2026-10-22 纠正）：命中多少选多少；「查找选区内」= 宇宙 = 已选中音符（保留命中、移出不命中）。
# ★ 分刻：每刻 CHUNK=64 个（find_note_scan_drive 自限），2000 音符 ≈ 31 刻 ≈ 1.5 秒；
#   宏叶子只 3 个 $ 行（复制元素 / 命中写回 / 选区内移除），条件判定全走 prop.selnote 普通命令 → 宏缓存可控。
# 「查找选区内」模式：时间窗仍用（先粗筛时间），但宇宙是「已选中」——叶子只对已选中音符判定，不命中移出。
execute if score #fn_insel editor matches 1 unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"勾了「查找选区内」但当前没有选中音符","color":"red"}]
execute if score #fn_insel editor matches 1 unless data storage rhythm_axe:maps.editor selection[0] run return fail
# ② 非选区模式：清旧选中（与【取消选中】11305 / 时间范围选择共用；含锚点清除）
execute if score #fn_insel editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
scoreboard players set #sel_count editor 0
execute if score #fn_insel editor matches 1 run execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
# 选区内模式：记录原选中数（收尾算「移除数」用）
scoreboard players set #fn_kept editor 0
execute if score #fn_insel editor matches 1 run execute store result score #fn_kept editor run data get storage rhythm_axe:maps.editor selection
# ③ 时间窗 [#fn_lo, #fn_hi)（notes 按 time 升序 ⇒ insert_find 二分；无时间条件 = 全表）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #fn_lo editor 0
execute if score #fn_has_t_lo editor matches 1 if score #fn_has_t_hi editor matches 1 run function rhythm_axe:editor/menu/find/find_note_len with storage rhythm_axe:prop
execute if score #fn_has_t_lo editor matches 1 if score #fn_has_t_hi editor matches 1 run scoreboard players operation #fn_hi editor = #fn_len editor
# 有下界（哨兵 2）→ 二分「首个 time ≥ from」（insert_find 语义是「首个 time > new_time」⇒ 减 1 纳入相等）
# ★★ insert_find 的输出是 **prop.index（storage）**，不是计分板 #index（2026-10-22 踩坑：
#   误用 scoreboard operation #fn_lo = #index 读到的是无关残留值，窗口被缩成 [0,残留) 导致命中数骤减）
execute if score #fn_has_t_lo editor matches 2 run execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #fn_t_lo editor
execute if score #fn_has_t_lo editor matches 2 run data modify storage rhythm_axe:prop list_name set value "notes"
execute if score #fn_has_t_lo editor matches 2 run function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if score #fn_has_t_lo editor matches 2 run execute store result score #fn_lo editor run data get storage rhythm_axe:prop index 1
execute if score #fn_has_t_lo editor matches 2 run scoreboard players remove #fn_lo editor 1
execute if score #fn_has_t_lo editor matches 2 if score #fn_lo editor matches ..-1 run scoreboard players set #fn_lo editor 0
# 有上界（哨兵 2）→ 二分「首个 time > to」（开区间即上界）
execute if score #fn_has_t_hi editor matches 2 run execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #fn_t_hi editor
execute if score #fn_has_t_hi editor matches 2 run data modify storage rhythm_axe:prop list_name set value "notes"
execute if score #fn_has_t_hi editor matches 2 run function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if score #fn_has_t_hi editor matches 2 run execute store result score #fn_hi editor run data get storage rhythm_axe:prop index 1
# 只写下界时上界 = 数组长度
execute if score #fn_has_t_lo editor matches 2 if score #fn_has_t_hi editor matches 1 run function rhythm_axe:editor/menu/find/find_note_len with storage rhythm_axe:prop
execute if score #fn_has_t_lo editor matches 2 if score #fn_has_t_hi editor matches 1 run scoreboard players operation #fn_hi editor = #fn_len editor
# ④ 置 active（consume 顶部守卫读它；扫描结束由 find_note_finish 清）
data modify storage rhythm_axe:maps.editor find_scan set value {active:1b}
# ⑤ 计数清零 + 提示 + 本刻先扫第一块（后续块由 scan_drive 自行 schedule）
scoreboard players set #fn_hit editor 0
scoreboard players set #fn_i editor 0
scoreboard players operation #fn_i editor = #fn_lo editor
tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"正在查找…（大谱面约 1~2 秒，期间编辑器按钮暂时锁定）","color":"yellow"}]
function rhythm_axe:editor/menu/find/find_note_scan_drive
