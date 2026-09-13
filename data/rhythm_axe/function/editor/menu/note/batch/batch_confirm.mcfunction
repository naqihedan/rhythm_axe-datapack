# ★ 2026-09-12 分刻 + 提示（处理音符数 > 50 时在聊天栏提示当前操作）：
#   同一条命令链里的 tellraw 会和重活一起被客户端渲染 ⇒ 玩家看不到「正在…」就先卡住了，所以 > 50 时：
#   本刻只发提示 + schedule 到下一刻；≤ 50 直接执行 <本文件>_go，不引入任何延迟。
execute unless data storage rhythm_axe:maps.editor editing.batch_ids run return fail
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor editing.batch_ids
data modify storage rhythm_axe:prop op_label set value "批量修改音符"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/batch/batch_confirm_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/batch/batch_confirm_go