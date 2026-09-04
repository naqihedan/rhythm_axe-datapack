# 已选定列表下一页（page+1 后重开，越界由列表打开时钳制）
execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players add #sel_page editor 1
execute store result storage rhythm_axe:maps.editor sel_page int 1 run scoreboard players get #sel_page editor
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
