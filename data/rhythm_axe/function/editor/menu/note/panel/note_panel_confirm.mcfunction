# 确认音符修改：把暂存 editing.temp 写回工作副本（移除原元素后按新 time 重插，一次历史快照）
# 先读来源面板（file/begin 会 consume 掉 editing.panel_from），确认后从哪来回哪去
# ★ 2026-09-16 安全守兵（防「确认按钮误删一个音符」）：本路径会按 editing.orig_index 去 remove 一个音符、
#   再用 editing.temp 顶替它。若会话已失效（缺 orig_index / 缺 temp.id，或当前其实是批量会话），
#   继续执行就会拿**残留的 prop.index** 去删别人的音符（且 tmp_elem 可能缺失 → 删了不补）。
#   任一前置不成立 → 一条数据都不动、不落快照，直接中止。
execute unless data storage rhythm_axe:maps.editor editing.orig_index run tellraw @s [{"text":"[编辑器] 音符面板已失效（缺少音符下标），已取消确认","color":"red"}]
execute unless data storage rhythm_axe:maps.editor editing.orig_index run return fail
execute unless data storage rhythm_axe:maps.editor editing.temp.id run tellraw @s [{"text":"[编辑器] 音符面板已失效（缺少音符 id），已取消确认","color":"red"}]
execute unless data storage rhythm_axe:maps.editor editing.temp.id run return fail
execute if data storage rhythm_axe:maps.editor editing.batch run tellraw @s [{"text":"[编辑器] 当前是批量编辑会话（请用批量确认），已取消","color":"red"}]
execute if data storage rhythm_axe:maps.editor editing.batch run return fail
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
# 持续时长（相对模式：temp = 原值 + 增量，下界 0）
scoreboard players set #rel_dur editor 0
execute store result score #rel_dur editor run data get storage rhythm_axe:maps.editor editing.rel.on.duration
execute if score #rel_dur editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.duration
execute if score #rel_dur editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.duration
execute if score #rel_dur editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_dur editor matches 1 if score #temp editor matches ..-1 run scoreboard players set #temp editor 0
execute if score #rel_dur editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.duration int 1 run scoreboard players get #temp editor
# 基础寿命（相对模式：temp = 原值 + 增量，下界 1）
scoreboard players set #rel_bl editor 0
execute store result score #rel_bl editor run data get storage rhythm_axe:maps.editor editing.rel.on.base_life
execute if score #rel_bl editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.note_base_life
execute if score #rel_bl editor matches 1 run execute store result score #rel_dt editor run data get storage rhythm_axe:maps.editor editing.rel.delta.base_life
execute if score #rel_bl editor matches 1 run scoreboard players operation #temp editor += #rel_dt editor
execute if score #rel_bl editor matches 1 if score #temp editor matches ..0 run scoreboard players set #temp editor 1
execute if score #rel_bl editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.note_base_life int 1 run scoreboard players get #temp editor
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
# ★ 2026-09-12：回面板改为「下一刻渲染」——本文件前面已有 refresh（整表重建视觉）+ 逐音符遍历，
#   再同刻渲染列表会超命令链被截断（尾部丢的是视觉/选区重建）。语义不变，面板晚 1 tick 出现。
schedule function rhythm_axe:editor/menu/note/panel/note_panel_return_next 1t
