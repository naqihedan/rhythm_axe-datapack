# 已选定列表上一页（page-1，>=0 后重开）
execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players remove #sel_page editor 1
execute if score #sel_page editor matches ..0 run scoreboard players set #sel_page editor 0
execute store result storage rhythm_axe:maps.editor sel_page int 1 run scoreboard players get #sel_page editor
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
