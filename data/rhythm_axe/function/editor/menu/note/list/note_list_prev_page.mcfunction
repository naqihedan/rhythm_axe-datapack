# 音符列表上一页（page-1 后重开）
execute store result storage rhythm_axe:maps.editor notes_page int 1 run scoreboard players get #note_page editor
scoreboard players remove #note_page editor 1
execute if score #note_page editor matches 1.. run execute store result storage rhythm_axe:maps.editor notes_page int 1 run scoreboard players get #note_page editor
execute unless score #note_page editor matches 1.. run data modify storage rhythm_axe:maps.editor notes_page set value 0
function rhythm_axe:editor/menu/note/list/note_list_open
