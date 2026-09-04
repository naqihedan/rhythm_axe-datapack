# 音符列表上一页（page-1，>=0 后重开）
execute store result score #note_page editor run data get storage rhythm_axe:maps.editor notes_page
scoreboard players remove #note_page editor 1
execute if score #note_page editor matches ..0 run scoreboard players set #note_page editor 0
execute store result storage rhythm_axe:maps.editor notes_page int 1 run scoreboard players get #note_page editor
function rhythm_axe:editor/menu/note/list/note_list_open
