#arg:mapid,cur
# 保存：备份 highest_score → 逐键清空 maps.<mapid> 根字段 → merge 工作副本 → 写回 highest_score（防字段残留）
# 保存不修改历史记录（保存后仍可撤销）；未保存判定 = history_cursor != saved_cursor
# 若谱面不存在，先写一个临时键确保 storage 被创建（后续逐键删除与 merge 都是无残留覆盖）
$execute unless data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.$(mapid) id set value "tmp"
scoreboard players set #saved_highest editor 0
$execute store result score #saved_highest editor run data get storage rhythm_axe:maps.$(mapid) highest_score
$data remove storage rhythm_axe:maps.$(mapid) id
$data remove storage rhythm_axe:maps.$(mapid) title
$data remove storage rhythm_axe:maps.$(mapid) artist
$data remove storage rhythm_axe:maps.$(mapid) author
$data remove storage rhythm_axe:maps.$(mapid) music
$data remove storage rhythm_axe:maps.$(mapid) preview
$data remove storage rhythm_axe:maps.$(mapid) teleport
$data remove storage rhythm_axe:maps.$(mapid) spawn_pos
$data remove storage rhythm_axe:maps.$(mapid) spawn_x
$data remove storage rhythm_axe:maps.$(mapid) spawn_y
$data remove storage rhythm_axe:maps.$(mapid) spawn_z
$data remove storage rhythm_axe:maps.$(mapid) spawn_yaw
$data remove storage rhythm_axe:maps.$(mapid) spawn_pitch
$data remove storage rhythm_axe:maps.$(mapid) player_count
$data remove storage rhythm_axe:maps.$(mapid) health
$data remove storage rhythm_axe:maps.$(mapid) end_time
$data remove storage rhythm_axe:maps.$(mapid) highest_score
$data remove storage rhythm_axe:maps.$(mapid) notes
$data remove storage rhythm_axe:maps.$(mapid) timing_points
$data remove storage rhythm_axe:maps.$(mapid) events
$data remove storage rhythm_axe:maps.$(mapid) editor_playhead
$data modify storage rhythm_axe:maps.$(mapid) {} merge from storage rhythm_axe:maps.editor history[$(cur)]
# 保存时剔除音符的 selected（正式谱面不带选中状态；工作副本保留选中）
$function rhythm_axe:editor/file/save_strip_selected {mapid:"$(mapid)"}
$execute store result storage rhythm_axe:maps.$(mapid) highest_score int 1 run scoreboard players get #saved_highest editor
$data modify storage rhythm_axe:maps.$(mapid) editor_playhead set from storage rhythm_axe:maps.editor playhead
data modify storage rhythm_axe:maps.editor saved_cursor set from storage rhythm_axe:maps.editor history_cursor
$tellraw @s [{"text":"[编辑器] 谱面已保存 ","color":"green"},{"text":"$(mapid)","color":"aqua"}]
