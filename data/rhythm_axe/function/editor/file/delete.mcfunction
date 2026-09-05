#arg:mapid
# 删除谱面（回收站）：maps.<mapid> → maps.trash.<mapid>（同名覆盖），再删正式存储
# ★ 2026-08-25 去掉"编辑中拒绝"：单人锁下只有当前编辑者，编辑器内删除当前谱面是确认后的明确操作（删除后退出编辑器）；未保存内容随退出丢弃
$execute unless data storage rhythm_axe:maps.$(mapid) id run tellraw @s [{"text":"[编辑器] 谱面不存在：","color":"red"},{"text":"$(mapid)","color":"aqua"}]
$execute unless data storage rhythm_axe:maps.$(mapid) id run return fail
# 清理旧复合结构（旧版本 trash.<mapid> 会让列表 append 失败）
function rhythm_axe:editor/file/trash_migrate
# 移入回收站（列表 trash[]，元素含 mapid + 完整谱面）：先去重同 mapid 旧元素（同名覆盖），再 append
# ★ 2026-08-25 从复合键 trash.<mapid> 改为列表，供回收站面板遍历（还原/彻底删除）
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/file/trash_dedupe with storage rhythm_axe:prop
data remove storage rhythm_axe:prop index
$data modify storage rhythm_axe:maps trash append value {mapid:"$(mapid)"}
$data modify storage rhythm_axe:maps trash[-1] merge from storage rhythm_axe:maps.$(mapid)
# ★ 逐键删除正式存储（26.x data remove 不能删根；id 最后删，否则后续 if data ...id 失效）
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) title
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) artist
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) author
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) music
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) preview
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) teleport
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) spawn_pos
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) spawn_x
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) spawn_y
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) spawn_z
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) spawn_yaw
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) spawn_pitch
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) player_count
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) health
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) end_time
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) highest_score
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) notes
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) timing_points
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) events
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) editor_playhead
$execute if data storage rhythm_axe:maps.$(mapid) id run data remove storage rhythm_axe:maps.$(mapid) id
$tellraw @s [{"text":"[编辑器] 谱面已移入回收站：","color":"green"},{"text":"$(mapid)","color":"aqua"}]
