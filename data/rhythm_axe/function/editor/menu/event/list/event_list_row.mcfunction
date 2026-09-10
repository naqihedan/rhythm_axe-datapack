#arg:cursor,index,end,page
# 事件列表行遍历：每行 4 个按钮，规范v2 值 = (1000+页内行序)×100 + 列码(编辑3/复制5/粘贴6/删除7)
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
execute store result score #temp_cursor editor run data get storage rhythm_axe:prop page
scoreboard players set #index editor 5
scoreboard players operation #temp_cursor editor *= #index editor
scoreboard players operation #temp_playhead editor -= #temp_cursor editor
scoreboard players add #temp_playhead editor 1000
scoreboard players operation #temp_playhead editor *= 100 const
# 编辑(3)
scoreboard players operation #edit_val editor = #temp_playhead editor
scoreboard players add #edit_val editor 3
execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #edit_val editor
# 复制(5)
scoreboard players operation #copy_val editor = #temp_playhead editor
scoreboard players add #copy_val editor 5
execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #copy_val editor
# 粘贴(6)
scoreboard players operation #paste_val editor = #temp_playhead editor
scoreboard players add #paste_val editor 6
execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #paste_val editor
# 删除(7)
scoreboard players operation #delete_val editor = #temp_playhead editor
scoreboard players add #delete_val editor 7
execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #delete_val editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run function rhythm_axe:editor/menu/event/list/event_list_line with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run return 0
# 已到本页末尾则结束
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
$execute if score #temp_playhead editor matches $(end).. run return 0
# 行号 +1 后递归
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/event/list/event_list_row with storage rhythm_axe:prop
