# 全部粘贴完成：提示已粘贴数量并清理
execute store result score #paste_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
tellraw @s [{"text":"[编辑器] 已粘贴 ","color":"green"},{"score":{"name":"#paste_count","objective":"editor"},"color":"aqua"},{"text":" 个音符","color":"green"}]
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop time_offset
data remove storage rhythm_axe:prop paste_index
data remove storage rhythm_axe:prop new_id
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop cursor
