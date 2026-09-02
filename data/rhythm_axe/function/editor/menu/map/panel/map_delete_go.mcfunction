# 确认删除谱面（宏 #arg: mapid）：已保存 → 调 file/delete 移入回收站；未保存 → 提示后丢弃编辑内容
# 两种情况删除确认后都退出编辑器
#arg: mapid
# ★ 2026-08-25 用 #map_saved 先记录状态：file/delete 会把正式存储的 id 删掉，之后再判断 maps.$(mapid).id 会失效（误报"尚未保存"）
scoreboard players set #map_saved editor 0
$execute if data storage rhythm_axe:maps.$(mapid) id run scoreboard players set #map_saved editor 1
$execute if data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/file/delete with storage rhythm_axe:prop
execute if score #map_saved editor matches 1 run function rhythm_axe:editor/exit_do
execute if score #map_saved editor matches 0 run tellraw @s [{"text":"[编辑器] 谱面尚未保存（仅有未保存的编辑内容），删除即丢弃","color":"yellow"}]
execute if score #map_saved editor matches 0 run function rhythm_axe:editor/exit_do
