#arg:cursor,note_index
# 游标 +1 后继续收集
execute store result score #note_index editor run data get storage rhythm_axe:prop note_index
scoreboard players add #note_index editor 1
execute store result storage rhythm_axe:prop note_index int 1 run scoreboard players get #note_index editor
function rhythm_axe:editor/note/copy/copy_one with storage rhythm_axe:prop
