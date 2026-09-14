#arg:cursor,i
# 遍历终止探测：notes[$(i)].id 是否存在 → #sel_has（1=存在，继续；0=越界，停止）
# ★ 2026-09-14 性能：原先用 sel_rebuild_len 的 `data get storage ... notes` 取数组长度，
#   但**取长度会把整个 notes 列表序列化**（976 音符 ≈ 260KB 文本）→ 每次 refresh 都要付一次。
#   改为逐个探测存在性（每步只要 1 条 data get，反馈极短）。
$execute store success score #sel_has editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
