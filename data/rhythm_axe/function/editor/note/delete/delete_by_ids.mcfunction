# 删除音符（通用原语，按列表删）：前置 prop.note_ids（缺省 = maps.editor.selection）
# 与 [删除单个音符] editor/note/delete/delete.mcfunction 的分工：那个按单个 prop.note_id 删，这个按列表删。
# 与【剪切】的区别：删除**不修改剪贴板**（收集链路会重写 maps.editor.clipboard，所以这里先备份、delete_finish 再还原）。
execute unless data storage rhythm_axe:prop note_ids[0] run tellraw @s [{"text":"[编辑器] 没有可删除的音符","color":"red"}]
execute unless data storage rhythm_axe:prop note_ids[0] run return fail
execute if data storage rhythm_axe:maps.editor clipboard run data modify storage rhythm_axe:prop clip_bak set from storage rhythm_axe:maps.editor clipboard
execute unless data storage rhythm_axe:maps.editor clipboard run data remove storage rhythm_axe:prop clip_bak
data modify storage rhythm_axe:prop clip_action set value "delete"
function rhythm_axe:editor/note/copy/copy
