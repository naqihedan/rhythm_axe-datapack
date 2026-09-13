# 批量剪切选中音符（面板 10 的【批量剪切】11308 / 面板 18 的【批量剪切】11408）
# 剪切 = 复制 + 删除：选中音符进剪贴板，同时删除原音符（剪贴板保留 → 接着可以【批量粘贴】）
# ★ 2026-09-12 分刻 + 提示（处理音符数 > 50 时在聊天栏提示当前操作）：
#   同一条命令链里的 tellraw 会和重活一起被客户端渲染 ⇒ 玩家看不到「正在…」就先卡住了，所以 > 50 时：
#   本刻只发提示 + schedule 到下一刻；≤ 50 直接执行 <本文件>_go，不引入任何延迟。
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[编辑器] 没有选中的音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop op_label set value "批量剪切音符"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/note/cut/batch_cut_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/note/cut/batch_cut_go
