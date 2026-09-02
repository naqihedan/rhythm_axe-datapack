# 音符列表页号钳制到最后一页
execute store result score #note_page editor run data get storage rhythm_axe:maps.editor notes_page
scoreboard players operation #note_page editor = #note_pages editor
scoreboard players remove #note_page editor 1
execute store result storage rhythm_axe:maps.editor notes_page int 1 run scoreboard players get #note_page editor
