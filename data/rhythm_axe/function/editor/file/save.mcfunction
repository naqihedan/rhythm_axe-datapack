#arg:mapid,cur
# 保存：备份 highest_score → 逐键清空 maps.<mapid> 根字段 → merge 工作副本 → 写回 highest_score（防字段残留）
# 保存不修改历史记录（保存后仍可撤销）；未保存判定 = history_cursor != saved_cursor
# 若谱面不存在，先写一个临时键确保 storage 被创建（后续逐键删除与 merge 都是无残留覆盖）
# ★ 2026-09-15 保存前自动整理音符顺序：notes 按 time 升序重排（修复批量改判定时间造成的局部逆序）
#   · order_repair 读 prop.cursor（缺省取 history_cursor）→ 这里显式写死成 history_cursor，防止残留值指向别的快照
#   · 只改数组顺序、不改任何音符字段；不建历史快照（保存本来就不进历史）
#   · 确有交换时在函数末尾统一提示 + refresh（重建按下标的缓存，见 #vis_next）
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/util/order_repair
data remove storage rhythm_axe:prop cursor
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
# ★ 强制键与内部 id 一致：工作副本里的 id 可能是旧名（改名后不同步）⇒ 不改会被 merge 写进正式存储（2026-09-10）
$data modify storage rhythm_axe:maps.$(mapid) id set value "$(mapid)"
# 保存时剔除音符的 selected（正式谱面不带选中状态；工作副本保留选中）
$function rhythm_axe:editor/file/save_strip_selected {mapid:"$(mapid)"}
$execute store result storage rhythm_axe:maps.$(mapid) highest_score int 1 run scoreboard players get #saved_highest editor
$data modify storage rhythm_axe:maps.$(mapid) editor_playhead set from storage rhythm_axe:maps.editor playhead
data modify storage rhythm_axe:maps.editor saved_cursor set from storage rhythm_axe:maps.editor history_cursor
$tellraw @s [{"text":"[编辑器] 谱面已保存 ","color":"green"},{"text":"$(mapid)","color":"aqua"}]
# ★ 保存前确实交换过（数组顺序变了）→ 提示 + 重建视觉（#vis_next 出生游标 / 选区等按下标的缓存必须按新顺序重算）
execute if score #ord_swaps editor matches 1.. run tellraw @s [{"text":"[编辑器] 保存前已自动整理音符顺序：交换 ","color":"yellow"},{"score":{"name":"#ord_swaps","objective":"editor"},"color":"aqua"},{"text":" 处","color":"yellow"}]
execute if score #ord_swaps editor matches 1.. run function rhythm_axe:editor/refresh
