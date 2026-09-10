# 面板 17：回收站（规范v2：1 返回；11280..11289 还原；11290..11299 彻底删除；11270/11271 覆盖还原确认；11272/11273 彻底删除确认）。
# trash_panel_open / trash_restore_confirm / trash_delete_confirm 设 current_panel=17。
# 入口白名单守卫
execute unless score #click_value editor matches 1 unless score #click_value editor matches 11270..11299 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 11270..11299 run return fail

# 1 返回主菜单
execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
# 11280..11289 还原（index=click-11280）
execute if score #click_value editor matches 11280..11289 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 11280..11289 run scoreboard players remove #temp editor 11280
execute if score #click_value editor matches 11280..11289 run execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 11280..11289 run function rhythm_axe:editor/menu/trash/trash_restore_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 11280..11289 run data remove storage rhythm_axe:prop index
# 11290..11299 彻底删除（index=click-11290）
execute if score #click_value editor matches 11290..11299 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 11290..11299 run scoreboard players remove #temp editor 11290
execute if score #click_value editor matches 11290..11299 run execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 11290..11299 run function rhythm_axe:editor/menu/trash/trash_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 11290..11299 run data remove storage rhythm_axe:prop index
# 覆盖还原确认：11270 覆盖并还原 / 11271 取消回回收站
execute if score #click_value editor matches 11270 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor trash_pending.mapid
execute if score #click_value editor matches 11270 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor trash_pending.index
execute if score #click_value editor matches 11270 run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
execute if score #click_value editor matches 11270 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 11270 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 11271 run function rhythm_axe:editor/menu/trash/trash_panel_open
# 彻底删除确认：11272 确认 / 11273 取消回回收站
execute if score #click_value editor matches 11272 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor trash_pending.mapid
execute if score #click_value editor matches 11272 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor trash_pending.index
execute if score #click_value editor matches 11272 run function rhythm_axe:editor/menu/trash/trash_delete_go with storage rhythm_axe:prop
execute if score #click_value editor matches 11272 run data remove storage rhythm_axe:prop mapid
execute if score #click_value editor matches 11272 run data remove storage rhythm_axe:prop index
execute if score #click_value editor matches 11273 run function rhythm_axe:editor/menu/trash/trash_panel_open
