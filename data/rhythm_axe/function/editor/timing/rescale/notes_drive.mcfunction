# ① 音符遍历驱动（普通函数递归，非宏）
#   前置：#rs_i、#rs_chunk、prop.rescale（含 cursor 备份）
#   ★ 每刻额度 64（**字面量**：未赋值计分板做上界会让判断恒真 → 死循环）
#   扫完（下标越界 #rs_done=1）→ ②事件点阶段
#   阶段结束时**必须 return**（此时确实要停止递归）—— 这是唯一允许 return 的位置。
execute if score #rs_chunk editor matches 64.. run schedule function rhythm_axe:editor/timing/rescale/resume 1t
execute if score #rs_chunk editor matches 64.. run return 0
# ★ cursor / i 自愈（2026-10-29）：每次进入驱动器都从 prop.rescale.cursor 重建 prop.cursor。
#   调用方（timing_panel_confirm / create / open_prep）收尾会删 prop.cursor，若删发生在
#   本轮遍历结束之前，宏 `with storage` 就会实例化失败 → #rs_done 永远 0 → #rs_i 无限增长。
# ⚠️ 本文件**不能出现 return**（return 会终止整条调用栈，把递归一起砍掉）。
execute unless data storage rhythm_axe:prop cursor run data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:prop rescale.cursor
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #rs_i editor
scoreboard players set #rs_done editor 0
function rhythm_axe:editor/timing/rescale/notes_leaf with storage rhythm_axe:prop
execute if score #rs_done editor matches 1 run scoreboard players set #rs_phase editor 1
execute if score #rs_done editor matches 1 run scoreboard players set #rs_i editor 0
execute if score #rs_done editor matches 1 run scoreboard players set #rs_chunk editor 0
execute if score #rs_done editor matches 1 run function rhythm_axe:editor/timing/rescale/events_drive
execute if score #rs_done editor matches 1 run return 0
scoreboard players add #rs_i editor 1
scoreboard players add #rs_chunk editor 1
function rhythm_axe:editor/timing/rescale/notes_drive
