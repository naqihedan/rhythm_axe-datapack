# 音符列表下一页（page+1 后重开，越界由列表打开时钳制）
execute store result score #note_page editor run data get storage rhythm_axe:maps.editor notes_page
scoreboard players add #note_page editor 1
execute store result storage rhythm_axe:maps.editor notes_page int 1 run scoreboard players get #note_page editor
function rhythm_axe:editor/menu/note/list/note_list_open
