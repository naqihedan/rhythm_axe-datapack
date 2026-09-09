# 面板 17：回收站（1 返回；1380..1389 还原；1390..1399 彻底删除；1370/1371 覆盖还原确认；1372/1373 彻底删除确认）。
# trash_panel_open / trash_restore_confirm / trash_delete_confirm 设 current_panel=17。
# 入口白名单守卫
execute unless score #click_value editor matches 1 unless score #click_value editor matches 1370..1373 unless score #click_value editor matches 1380..1389 unless score #click_value editor matches 1390..1399 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 1370..1373 unless score #click_value editor matches 1380..1389 unless score #click_value editor matches 1390..1399 run return fail

# 1 返回主菜单
execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
# 1380..1389 还原（index=click-1380）
execute if score #click_value editor matches 1380..1389 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1380..1389 run scoreboard players remove #temp editor 1380
execute if score #click_value editor matches 1380..1389 run execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1380..1389 run function rhythm_axe:editor/menu/trash/trash_restore_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1380..1389 run data remove storage rhythm_axe:prop index
# 1390..1399 彻底删除（index=click-1390）
execute if score #click_value editor matches 1390..1399 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 1390..1399 run scoreboard players remove #temp editor 1390
execute if score #click_value editor matches 1390..1399 run execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 1390..1399 run function rhythm_axe:editor/menu/trash/trash_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 1390..1399 run data remove storage rhythm_axe:prop index
# 覆盖还原确认：1370 覆盖并还原 / 1371 取消回回收站
execute if score #click_value editor matches 1370 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor trash_pending.mapid
execute if score #click_value editor matches 1370 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor trash_pending.index
execute if score #click_value editor matches 1370 run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
execute if score #click_value editor matches 1370 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 1370 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 1371 run function rhythm_axe:editor/menu/trash/trash_panel_open
# 彻底删除确认：1372 确认 / 1373 取消回回收站
execute if score #click_value editor matches 1372 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor trash_pending.mapid
execute if score #click_value editor matches 1372 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor trash_pending.index
execute if score #click_value editor matches 1372 run function rhythm_axe:editor/menu/trash/trash_delete_go with storage rhythm_axe:prop
execute if score #click_value editor matches 1372 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 1372 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 1373 run function rhythm_axe:editor/menu/trash/trash_panel_open
