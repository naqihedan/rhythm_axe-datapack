# 复选框 toggle 前置：点击值 1600+存活序 → 按存活序找数组索引 → toggle 选中（效果同左键点选/右键取消）
# 与 note_list_copy_prep 同款：prop.target = click-1600（0 基存活序），note_find_alive_advance 找 found_index
execute store result score #temp editor run data get storage rhythm_axe:maps.editor notes_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
scoreboard players operation #temp_cursor editor = #click_value editor
scoreboard players remove #temp_cursor editor 100000
scoreboard players operation #temp_cursor editor /= 100 const
scoreboard players operation #temp editor += #temp_cursor editor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop count set value 0
data remove storage rhythm_axe:prop found_index
execute store result storage rhythm_axe:prop target int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/note/list/note_find_alive_advance
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 该音符不存在","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
function rhythm_axe:editor/menu/note/list/note_list_toggle_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop count
data remove storage rhythm_axe:prop target
data remove storage rhythm_axe:prop found_index
# 刷新活跃列表（更新复选框状态）
function rhythm_axe:editor/menu/note/list/note_list_open
