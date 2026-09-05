# 确认音符修改：把暂存 editing.temp 写回工作副本（移除原元素后按新 time 重插，一次历史快照）
# 先读来源面板（file/begin 会 consume 掉 editing.panel_from），确认后从哪来回哪去
execute store result score #from editor run data get storage rhythm_axe:maps.editor editing.panel_from
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改音符"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor editing.orig_index
# 相对模式：temp = 原值 + 增量（钳下界），使写回的是最终值
scoreboard players set #rel_time editor 0
execute store result score #rel_time editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
scoreboard players set #rel_size editor 0
execute store result score #rel_size editor run data get storage rhythm_axe:maps.editor editing.rel.on.size
execute if score #rel_time editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #rel_time editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.time
execute if score #rel_time editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_time editor matches 1 if score #temp editor matches ..-1 run scoreboard players set #temp editor 0
execute if score #rel_time editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run scoreboard players get #temp editor
execute if score #rel_size editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.size 1000
execute if score #rel_size editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_size editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_size editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.size
execute if score #rel_size editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_size editor matches 1 if score #temp editor matches ..10 run scoreboard players set #temp editor 10
execute if score #rel_size editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.size float 0.01 run scoreboard players get #temp editor
# 位置/起始位置（相对模式：temp = 原值 + delta[i]，无下界钳制）
scoreboard players set #rel_pos editor 0
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
scoreboard players set #rel_sp editor 0
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute if score #rel_pos editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.position[0] 1000
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_pos editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[0]
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_pos editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.position[0] double 0.01 run scoreboard players get #temp editor
execute if score #rel_pos editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.position[1] 1000
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_pos editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[1]
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_pos editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.position[1] double 0.01 run scoreboard players get #temp editor
execute if score #rel_pos editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.position[2] 1000
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_pos editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[2]
execute if score #rel_pos editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_pos editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.position[2] double 0.01 run scoreboard players get #temp editor
execute if score #rel_sp editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[0] 1000
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_sp editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[0]
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_sp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.start_pos[0] double 0.01 run scoreboard players get #temp editor
execute if score #rel_sp editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[1] 1000
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_sp editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[1]
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_sp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.start_pos[1] double 0.01 run scoreboard players get #temp editor
execute if score #rel_sp editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.start_pos[2] 1000
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor += 5 const
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_sp editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[2]
execute if score #rel_sp editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_sp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.start_pos[2] double 0.01 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/note/panel/note_panel_confirm_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
# ★ 音符属性保存后让时间轴同步刷新：bump content_ver，供 TimelineSync 变化检测强制重推
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已修改音符"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop tmp_elem
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
function rhythm_axe:editor/menu/note/panel/note_panel_return
