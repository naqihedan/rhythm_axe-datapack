# 批量删除选中音符（面板 10 的【批量删除】11307 / 面板 18 的【批量删除】11407）：点击即删，不弹二次确认
# 实现：删除原语 —— selection → prop.note_ids → editor/note/delete/delete_by_ids（收集下标 + 倒序删除）
# ★ 2026-09-12 重构：不再复用「剪切」链路。以前是「删除 = 剪切 - 复制」（借 cut_finish 外壳、还要备份/还原剪贴板），
#   导致收尾的 return 守卫失效并误报「已剪切 N 个音符」（玩家看到剪切消息却找不到剪切按钮）。
#   现在是「剪切 = 复制 + 删除」：两边共用 delete/remove_* 删除引擎，各自有自己的收尾
#   （delete_finish 还原剪贴板 + 提示「已删除」；cut_finish 保留剪贴板 + 提示「已剪切」）。
# 剪贴板：删除全程不动它（delete_by_ids 内部备份、delete_finish 还原）
# 面板：入口记下「从哪个面板点的」（prop.ret_panel），收尾按它回同一个列表（面板 10 活跃列表 / 面板 18 已选定列表）
# 一次快照，可撤销（op_label="批量删除音符"）
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[编辑器] 没有选中的音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
# ★ 2026-09-12 分刻 + 提示（处理音符数 > 50 时在聊天栏提示当前操作）：
#   同一条命令链里的 tellraw 会和重活一起被客户端渲染 ⇒ 玩家看不到「正在…」就先卡住了，所以 > 50 时：
#   本刻只发提示 + schedule 到下一刻；≤ 50 直接执行 <本文件>_go，不引入任何延迟。
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop op_label set value "批量删除音符"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/note/delete/batch_delete_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/note/delete/batch_delete_go