# 复制完成：提示已复制数量并清理
execute store result score #copy_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
tellraw @s [{"text":"[编辑器] 已复制 ","color":"green"},{"score":{"name":"#copy_count","objective":"editor"},"color":"aqua"},{"text":" 个音符","color":"green"}]
function rhythm_axe:editor/note/copy/clip_cleanup
