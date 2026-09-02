#arg:old_mapid,new_mapid,cursor
# 谱面改名：正式存储整体搬移（未保存谱面无正式存储 → 从工作副本创建）+ 更新 id 字段 + 更新编辑状态
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data modify storage rhythm_axe:maps.$(new_mapid) {} merge from storage rhythm_axe:maps.$(old_mapid)
# ★ 2026-08-25 源无正式存储（未保存谱面）→ 从工作副本 history[$(cursor)] 创建新谱正式存储，否则改名后 data get maps.$(new_mapid) 为空
$execute unless data storage rhythm_axe:maps.$(old_mapid) id run data modify storage rhythm_axe:maps.$(new_mapid) {} merge from storage rhythm_axe:maps.editor history[$(cursor)]
# 逐键删除旧谱面 storage（26.x data remove 不能删根，只能逐键；删完旧键成空复合=视为不存在）
# ★ 2026-08-25 修复：id 必须最后删——此前第一个删 id 导致后续所有 if data ...id 判断失效，旧谱 title/notes 等全部残留
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) title
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) artist
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) author
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) music
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) preview
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) teleport
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) spawn_pos
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) spawn_x
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) spawn_y
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) spawn_z
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) spawn_yaw
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) spawn_pitch
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) player_count
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) health
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) end_time
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) highest_score
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) notes
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) timing_points
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) events
$execute if data storage rhythm_axe:maps.$(old_mapid) id run data remove storage rhythm_axe:maps.$(old_mapid) id
# 更新谱面内 id 字段为新 mapid（storage 键与 id 保持一致；改名时游戏未在玩，无 map_$(mapid) 实体/计分板需重建——objective 均全局）
$execute if data storage rhythm_axe:maps.$(new_mapid) id run data modify storage rhythm_axe:maps.$(new_mapid) id set value "$(new_mapid)"
$data modify storage rhythm_axe:maps.editor mapid set value "$(new_mapid)"
$tellraw @s [{"text":"[编辑器] 已修改谱面 id 为 ","color":"green"},{"text":"$(new_mapid)","color":"aqua"}]
tellraw @s [{"text":"（改名不进撤销历史；如需改回原名，请再次修改谱面 id）","color":"gray","italic":true}]
function rhythm_axe:editor/menu/map/panel/map_panel_open
