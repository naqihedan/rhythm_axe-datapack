#arg:mapid,i
# 遍历终止探测（保存用）：maps.$(mapid).notes[$(i)].id 是否存在 → #strip_has（1=存在，继续；0=越界，停止）
# ★ 2026-09-14 性能：原先用 save_strip_selected 的 `data get storage ... notes` 取数组长度，
#   但**取长度会把整个列表序列化**（千音符 ≈260KB 文本）→ 每次保存都要付一次。改为逐个探测存在性。
$execute store success score #strip_has editor run data get storage rhythm_axe:maps.$(mapid).notes[$(i)].id
