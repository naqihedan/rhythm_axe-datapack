#arg:cursor
# 初始化暂存副本 panel_temp：从当前工作副本复制根字段（剔除 id/notes/timing_points/events/highest_score，
# 以及旧版残留字段 spawn_pos/author，防止保存时覆盖其他操作的数据）
data modify storage rhythm_axe:maps.editor panel_temp set value {}
$data modify storage rhythm_axe:maps.editor panel_temp set from storage rhythm_axe:maps.editor history[$(cursor)]
data remove storage rhythm_axe:maps.editor panel_temp.id
data remove storage rhythm_axe:maps.editor panel_temp.notes
data remove storage rhythm_axe:maps.editor panel_temp.timing_points
data remove storage rhythm_axe:maps.editor panel_temp.events
data remove storage rhythm_axe:maps.editor panel_temp.highest_score
data remove storage rhythm_axe:maps.editor panel_temp.spawn_pos
data remove storage rhythm_axe:maps.editor panel_temp.author
# 旧谱面可能缺新字段，补缺省值（保证面板显示与保存字段完整）
execute unless data storage rhythm_axe:maps.editor panel_temp.spawn_x run data modify storage rhythm_axe:maps.editor panel_temp.spawn_x set value 0.0d
execute unless data storage rhythm_axe:maps.editor panel_temp.spawn_y run data modify storage rhythm_axe:maps.editor panel_temp.spawn_y set value 0.0d
execute unless data storage rhythm_axe:maps.editor panel_temp.spawn_z run data modify storage rhythm_axe:maps.editor panel_temp.spawn_z set value 0.0d
execute unless data storage rhythm_axe:maps.editor panel_temp.spawn_yaw run data modify storage rhythm_axe:maps.editor panel_temp.spawn_yaw set value 0.0d
execute unless data storage rhythm_axe:maps.editor panel_temp.spawn_pitch run data modify storage rhythm_axe:maps.editor panel_temp.spawn_pitch set value 0.0d
execute unless data storage rhythm_axe:maps.editor panel_temp.title run data modify storage rhythm_axe:maps.editor panel_temp.title set value "{\"text\":\"\"}"
# ★ title 必须存字符串（JSON 组件）；宏 $(title) 传不了复合，复合会导致标题行不显示 → 清洗为字符串
execute if data storage rhythm_axe:maps.editor panel_temp.title.text run data modify storage rhythm_axe:maps.editor panel_temp.title set from storage rhythm_axe:maps.editor panel_temp.title.text
execute unless data storage rhythm_axe:maps.editor panel_temp.artist run data modify storage rhythm_axe:maps.editor panel_temp.artist set value ""
execute unless data storage rhythm_axe:maps.editor panel_temp.music run data modify storage rhythm_axe:maps.editor panel_temp.music set value ""
execute unless data storage rhythm_axe:maps.editor panel_temp.preview run data modify storage rhythm_axe:maps.editor panel_temp.preview set value ""
execute unless data storage rhythm_axe:maps.editor panel_temp.teleport run data modify storage rhythm_axe:maps.editor panel_temp.teleport set value 0b
execute unless data storage rhythm_axe:maps.editor panel_temp.player_count run data modify storage rhythm_axe:maps.editor panel_temp.player_count set value 1
execute unless data storage rhythm_axe:maps.editor panel_temp.health run data modify storage rhythm_axe:maps.editor panel_temp.health set value 10
execute unless data storage rhythm_axe:maps.editor panel_temp.end_time run data modify storage rhythm_axe:maps.editor panel_temp.end_time set value -1
execute unless data storage rhythm_axe:maps.editor panel_temp.progress_color run data modify storage rhythm_axe:maps.editor panel_temp.progress_color set value 0
