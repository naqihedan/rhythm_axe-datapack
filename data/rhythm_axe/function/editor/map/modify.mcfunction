# 修改谱面根字段：前置 prop.map_fields（只 merge 传入的字段，如 title/author/music/preview/
# teleport/player_count/health/end_time/spawn_pos）；具体提示由调用方（菜单/对话框）给出
execute unless data storage rhythm_axe:prop map_fields run tellraw @s [{"text":"[编辑器] 缺少字段（prop.map_fields）","color":"red"}]
execute unless data storage rhythm_axe:prop map_fields run return fail

# 修改并提交
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/map/modify_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh

# 清理 prop
data remove storage rhythm_axe:prop map_fields
data remove storage rhythm_axe:prop cursor
