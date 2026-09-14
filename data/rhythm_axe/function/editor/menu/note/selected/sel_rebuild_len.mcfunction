# [已废弃 2026-09-14 性能重构] 「取数组长度」会把整表序列化（≈260KB）→ 已改用逐元素存在性探测
#   （sel_rebuild_probe / save_strip_probe）。无调用者；保留仅为便于回滚。
#arg:cursor
# 读工作副本 notes 长度（供 sel_rebuild_drive / sel_clear_drive 遍历终止）
$execute store result score #notes_len editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
