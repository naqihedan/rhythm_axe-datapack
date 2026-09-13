# 时间轴翻转（批量面板【时间轴翻转】按钮 909）：对选中音符把判定时间在 [min,max] 区间做镜像反转
#   new_time = min + max - old_time；只改 time，其余字段不变；翻转后按新 time 升序重排（一次历史快照可撤销）
# 前置：current_panel（=10 活跃列表 / 18 已选定列表）；处理对象 = selection（当前选中音符 id 列表）
# 流程：① file/begin ② 算选中音符 time 的 min/max ③ 逐个音符 find→改 time→remove→按新 time 重插 ④ commit+refresh+反馈
# ★ 2026-09-07 按钮移到活跃/已选定列表底部行，翻转对象改为 selection（不再用 editing.batch_ids）
# ★ 2026-09-12 加固：
#   ① 无选中直接返回。否则 selection 为空时 `#flip_total` 的 store 失败会保留上一轮的旧值，
#      而 prop.note_id 也是旧的 ⇒ 扫描"找到"同一个旧音符 ⇒ min=max ⇒ 对称轴跑到 max（用户实测到的现象）。
#   ② 清掉上一轮可能残留的扫描/插入游标，保证从干净状态开始。
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[编辑器] 没有选中的音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
# ★ 2026-09-12 分刻 + 提示（处理音符数 > 50 时在聊天栏提示当前操作）：
#   同一条命令链里的 tellraw 会和重活一起被客户端渲染 ⇒ 玩家看不到「正在…」就先卡住了，所以 > 50 时：
#   本刻只发提示 + schedule 到下一刻；≤ 50 直接执行 <本文件>_go，不引入任何延迟。
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop op_label set value "翻转时间轴"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/panel/note_panel_flip_time_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time_go