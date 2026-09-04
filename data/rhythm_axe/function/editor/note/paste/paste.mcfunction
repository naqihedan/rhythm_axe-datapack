# 粘贴剪贴板：可选 prop.time（粘贴基准时间：剪贴板中最小 time 的音符放到 time，其余保持相对偏移）
# 剪贴板为空时拒绝；每个音符重新分配 id 并按 time 升序插入；操作快照由 begin/commit 管理
execute unless data storage rhythm_axe:maps.editor clipboard.notes[0] run tellraw @s [{"text":"[编辑器] 剪贴板为空","color":"red"}]
execute unless data storage rhythm_axe:maps.editor clipboard.notes[0] run return fail

# 计算时间偏移（有 time 才计算；无则保持原时间）
data modify storage rhythm_axe:prop time_offset set value 0
execute if data storage rhythm_axe:prop time run function rhythm_axe:editor/note/paste/paste_offset

# 开始操作快照并逐个粘贴
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "粘贴音符"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop paste_index set value 0
# ★ 顺序游标初始化：insert_find 从 0 开始找第一个插入点
data modify storage rhythm_axe:prop paste_find set value 0
function rhythm_axe:editor/note/paste/paste_one with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
