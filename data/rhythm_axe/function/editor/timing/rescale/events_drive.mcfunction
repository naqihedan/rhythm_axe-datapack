# ② 事件点遍历驱动（普通函数递归）；额度同 notes_drive；越界 → ③
#   ★ 事件数组可能不存在（无 events 键）→ events_leaf 首行即置 #rs_done=1，天然跳过
execute if score #rs_chunk editor matches 64.. run schedule function rhythm_axe:editor/timing/rescale/resume 1t
execute if score #rs_chunk editor matches 64.. run return 0
# ★ cursor / i 自愈（2026-10-29）：每次进入驱动器都从 prop.rescale.cursor 重建 prop.cursor。
#   调用方（timing_panel_confirm / create / open_prep）收尾会删 prop.cursor，若删发生在
#   本轮遍历结束之前，宏 `with storage` 就会实例化失败 → #rs_done 永远 0 → #rs_i 无限增长。
# ⚠️ 本文件**不能出现 return**（return 会终止整条调用栈，把递归一起砍掉）。
execute unless data storage rhythm_axe:prop cursor run data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:prop rescale.cursor
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #rs_i editor
scoreboard players set #rs_done editor 0
function rhythm_axe:editor/timing/rescale/events_leaf with storage rhythm_axe:prop
execute if score #rs_done editor matches 1 run scoreboard players set #rs_phase editor 2
execute if score #rs_done editor matches 1 run scoreboard players set #rs_i editor 0
execute if score #rs_done editor matches 1 run scoreboard players set #rs_chunk editor 0
execute if score #rs_done editor matches 1 run function rhythm_axe:editor/timing/rescale/tp_drive
execute if score #rs_done editor matches 1 run return 0
scoreboard players add #rs_i editor 1
scoreboard players add #rs_chunk editor 1
function rhythm_axe:editor/timing/rescale/events_drive
