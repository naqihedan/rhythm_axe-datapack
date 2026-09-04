# 全部粘贴完成：提示已粘贴数量（走反馈系统，附撤销按钮）并清理
execute store result score #paste_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
data modify storage rhythm_axe:maps.editor feedback set value "已粘贴"
scoreboard players operation #fb_count editor = #paste_count editor
data modify storage rhythm_axe:prop fb_count set value 1b
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
data remove storage rhythm_axe:prop paste_find
