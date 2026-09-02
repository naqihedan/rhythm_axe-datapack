# 重进存档提示（仅在编辑器确实开过且 history_cursor 保留时调用）
# 先清 0 再读，防止键被 clear_state 删除后残留计分板误判
scoreboard players set #temp editor 0
scoreboard players set #temp_cursor editor 0
execute store result score #temp editor run data get storage rhythm_axe:maps.editor history_cursor
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor saved_cursor
execute unless score #temp editor = #temp_cursor editor run tellraw @a [{"text":"[编辑器] 编辑器未关闭且有未保存的内容","color":"yellow"},{"text":"  【返回编辑器】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 903"},"hover_event":{"action":"show_text","value":"返回编辑器主菜单"}}]
execute if score #temp editor = #temp_cursor editor run tellraw @a [{"text":"[编辑器] 编辑器未关闭","color":"yellow"},{"text":"  【返回编辑器】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 903"},"hover_event":{"action":"show_text","value":"返回编辑器主菜单"}}]
