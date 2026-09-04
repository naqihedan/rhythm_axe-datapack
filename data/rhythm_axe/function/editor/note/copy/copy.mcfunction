# 复制音符到剪贴板：前置 prop.note_ids（音符 id 列表）；缺省用 maps.editor.selection
# 剪贴板结构 maps.editor.clipboard = {note_ids:[...], notes:[...]}；复制不产生快照
# 收集结束按 prop.clip_action 分流（copy=提示；cut=删除原音符并产生快照）
execute unless data storage rhythm_axe:prop note_ids run data modify storage rhythm_axe:prop note_ids set from storage rhythm_axe:maps.editor selection
execute unless data storage rhythm_axe:prop note_ids[0] run tellraw @s [{"text":"[编辑器] 没有可复制的音符","color":"red"}]
execute unless data storage rhythm_axe:prop note_ids[0] run return fail

# 重置剪贴板并准备收集状态
execute if data storage rhythm_axe:maps.editor clipboard run data remove storage rhythm_axe:maps.editor clipboard
data modify storage rhythm_axe:maps.editor clipboard set value {}
execute unless data storage rhythm_axe:prop clip_action run data modify storage rhythm_axe:prop clip_action set value "copy"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop note_index set value 0
# ★ 顺序游标：copy_cursor=上次命中下标+1，find_by_id 从这里继续，避免对每个 id 全扫 O(n²)
data modify storage rhythm_axe:prop copy_cursor set value 0
function rhythm_axe:editor/note/copy/copy_one with storage rhythm_axe:prop
