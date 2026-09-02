#arg:cursor,index
# 粘贴时间点信息到该时间点（保留原 time，其余字段用剪贴板；一次历史快照）
execute unless data storage rhythm_axe:maps.editor timing_clip run tellraw @s [{"text":"[编辑器] 剪贴板为空，先复制一个时间点","color":"red"}]
execute unless data storage rhythm_axe:maps.editor timing_clip run return fail
$execute store result score #new_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].time
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改时间点"
$data modify storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] merge from storage rhythm_axe:maps.editor timing_clip
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].time int 1 run scoreboard players get #new_time editor
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已粘贴时间点信息"
function rhythm_axe:editor/menu/timing/list/timing_list_open
