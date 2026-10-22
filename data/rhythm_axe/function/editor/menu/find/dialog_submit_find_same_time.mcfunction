# 【选中同刻】（查找音符对话框第二个按钮，2026-10-21）：把与当前选中音符**同判定时间**的音符
#   全部加进选区（不清空原选中）→ 弹已选定列表。★ 选区无上限（2026-10-22 纠正）：命中多少选多少。
# 无对话框输入 ⇒ 不需要外层安全转发，直接干活。
# 实现：先收集当前选中音符的 time 集合（selection → find_by_id → time → prop.same_times[]），
#   再全表扫一遍 notes，time 在集合内且未选中 → 打 selected + 实体黄光/标记。
# 前置：selection 非空（空则提示并退出）
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"先选中至少一个音符，再点【选中同刻】","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
# ── 第一趟：收集选中音符的 time 集合（selection → find_by_id → time → prop.same_times 复合，键=time）──
data modify storage rhythm_axe:prop same_times set value {}
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #st_total editor 0
execute if data storage rhythm_axe:maps.editor selection run execute store result score #st_total editor run data get storage rhythm_axe:maps.editor selection
scoreboard players set #st_i editor 0
function rhythm_axe:editor/menu/find/find_same_time_collect_drive
# ── 第二趟：全表扫，time 命中集合且未选中 → 选中（★ 无上限：命中多少选多少）──
# ★ #sel_count 必须先按当前 selection 实长初始化（judge 的计数行读它）
scoreboard players set #sel_count editor 0
execute if data storage rhythm_axe:maps.editor selection run execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
scoreboard players set #st_j editor 0
function rhythm_axe:editor/menu/find/find_same_time_scan_drive
# ── 收尾：重建 selection → 反馈 → 弹已选定列表 ──
function rhythm_axe:editor/menu/note/selected/sel_rebuild
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"同刻音符已并入选中，共选中 ","color":"yellow"},{"score":{"name":"#sel_count","objective":"editor"},"color":"aqua"},{"text":" 个","color":"yellow"}]
execute if score #st_hit editor matches 1.. run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"新增 ","color":"yellow"},{"score":{"name":"#st_hit","objective":"editor"},"color":"aqua"},{"text":" 个同刻音符","color":"yellow"}]
execute unless score #st_hit editor matches 1.. run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"没有找到新的同刻音符","color":"red"}]
execute if score #sel_count editor matches 1.. run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
# 清理临时
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop same_times
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop selnote
scoreboard players reset #st_i editor
scoreboard players reset #st_j editor
scoreboard players reset #st_total editor
scoreboard players reset #st_hit editor
scoreboard players reset #st_has editor
