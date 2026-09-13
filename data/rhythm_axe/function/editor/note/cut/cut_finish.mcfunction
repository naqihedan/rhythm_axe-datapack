# 剪切收尾（由 remove_finish 按 clip_action="cut" 分派）：commit + refresh → 提示「已剪切 N 个音符」→ 清理
# ★ 剪切 = 复制 + 删除：剪贴板**保留**被剪的音符（与「删除」的区别就在这里，删完还能直接【批量粘贴】）
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
execute store result score #copy_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
tellraw @s [{"text":"[编辑器] 已剪切 ","color":"green"},{"score":{"name":"#copy_count","objective":"editor"},"color":"aqua"},{"text":" 个音符","color":"green"}]
function rhythm_axe:editor/note/copy/clip_cleanup
