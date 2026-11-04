# 分刻续跑：由 *_drive 在额度用满时 schedule 1t 拉起
# ★ schedule 拉起时执行者是服务端（没有 @s）⇒ 切回「本次操作者」（与 find_note_scan_next 同款）
# ★ 必须先重置 #rs_chunk，否则下一刻一进来又「额度已满」→ 无限空转
# ★★ cursor 自愈（2026-10-29 根治）：
#   notes_leaf / events_leaf / tp_leaf 都是 `with storage rhythm_axe:prop` 宏，
#   依赖 prop.cursor / prop.i 存在。而调用方（timing_panel_confirm、create、open_prep…）
#   在收尾时会 `data remove prop cursor`。一旦它们在本轮遍历结束**之前**执行，
#   宏就实例化失败 → #rs_done 永远为 0 → #rs_i 无限增长（实测涨到 30 万+）。
#   ⇒ 把 cursor 冗余存进 prop.rescale.cursor（收尾才删），每轮续跑都从这里重建。
execute unless data storage rhythm_axe:prop rescale run return 0
# ★ 不能加 $ 前缀（本行没有 $(...) 宏参数；带 $ 却不含宏参数 = 非法 ⇒ 整个文件加载失败）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:prop rescale.cursor
scoreboard players set #rs_chunk editor 0
# 失控保护：遍历下标超过硬上限 → 中止
execute if score #rs_i editor matches 1000000.. run function rhythm_axe:editor/timing/rescale/abort
execute if score #rs_i editor matches 1000000.. run return 0
execute if score #rs_phase editor matches 0 as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/timing/rescale/notes_drive
execute if score #rs_phase editor matches 0 unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/timing/rescale/notes_drive
execute if score #rs_phase editor matches 1 as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/timing/rescale/events_drive
execute if score #rs_phase editor matches 1 unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/timing/rescale/events_drive
execute if score #rs_phase editor matches 2 as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/timing/rescale/tp_drive
execute if score #rs_phase editor matches 2 unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/timing/rescale/tp_drive
