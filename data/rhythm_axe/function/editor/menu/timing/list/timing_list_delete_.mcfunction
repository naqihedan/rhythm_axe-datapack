#arg:cursor,index
# 删除该时间点（index 0 不可删；一次历史快照）
execute store result score #temp editor run data get storage rhythm_axe:prop index
execute if score #temp editor matches 0 run tellraw @s [{"text":"[编辑器] 不能删除曲目起始时间点","color":"red"}]
execute if score #temp editor matches 0 run return fail
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "删除时间点"
$data remove storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)]
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已删除时间点"
function rhythm_axe:editor/menu/timing/list/timing_list_open
