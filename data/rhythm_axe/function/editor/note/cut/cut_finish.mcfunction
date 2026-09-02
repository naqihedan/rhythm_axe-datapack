# 剪切完成：提交快照、提示已剪切数量并清理
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
execute store result score #copy_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
tellraw @s [{"text":"[编辑器] 已剪切 ","color":"green"},{"score":{"name":"#copy_count","objective":"editor"},"color":"aqua"},{"text":" 个音符","color":"green"}]
data remove storage rhythm_axe:maps.editor clipboard.found_indices
function rhythm_axe:editor/note/copy/clip_cleanup
