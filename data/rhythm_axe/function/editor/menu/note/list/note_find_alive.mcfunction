#arg:cursor,index,target
# 按存活序找目标音符的数组索引（宏"叶子"函数）：只处理当前这一个音符，内部不调用 advance / return。
# ★ 2026-08-25 重构（同 note_list_row 幽灵修复）：26.x 宏函数在递归栈中段会从中间点重跑剩余代码，
#   故所有遍历递归由普通函数 note_find_alive_advance 驱动；本函数用 #is_alive / #note_found 标志。
scoreboard players set #is_alive editor 1
scoreboard players set #note_total editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes run execute store result score #note_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
# 无效音符（缺 id）→ 不算存活
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id run scoreboard players set #is_alive editor 0
# 存活判定：出生刻 = time - note_base_life×16/note_speed（ignore_note_speed→time-base_life），线性再提前4刻；playhead < 出生刻 → 未出生
# ★ 2026-09-01 出生刻改用流速缩放（与 scan_birth_one 一致）
scoreboard players set #temp_playhead editor 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor playhead
scoreboard players set #temp_cursor editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life run execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life
scoreboard players set #temp_ig editor 0
$execute store result score #temp_ig editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
execute if score #temp_ig editor matches 1 run scoreboard players operation #temp editor -= #temp_cursor editor
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp_cursor editor *= 16 const
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp_cursor editor /= note_speed options
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp editor -= #temp_cursor editor
# 线性提前4刻：普通0/1/2 power=1；玻璃4 power=1 dur>=1（与 scan_birth_one 一致）
scoreboard players set #temp_type editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type run execute store result score #temp_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
scoreboard players set #temp_pow editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].anim_power run execute store result score #temp_pow editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].anim_power
execute if score #temp_type editor matches 0..2 if score #temp_pow editor matches 1 run scoreboard players remove #temp editor 4
scoreboard players set #temp_dur editor 3
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration run execute store result score #temp_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration
execute if score #temp_type editor matches 4 if score #temp_pow editor matches 1 if score #temp_dur editor matches 1.. run scoreboard players remove #temp editor 4
execute if score #temp_playhead editor < #temp editor run scoreboard players set #is_alive editor 0
# 消失刻 = 实体 editor_n_end（playhead > 消失刻 → 已消失）：
#   普通 0/1/2：time；混凝土 3：time+dur-1；玻璃 4：time+dur+1（与 spawn_one_ 的 #n_end 一致）
scoreboard players set #temp_cursor editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration run execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration
scoreboard players set #temp_type editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type run execute store result score #temp_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
execute if score #temp_type editor matches 3 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #temp_type editor matches 3 run scoreboard players remove #temp editor 1
execute if score #temp_type editor matches 4 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #temp_type editor matches 4 run scoreboard players add #temp editor 1
execute if score #temp_playhead editor > #temp editor run scoreboard players set #is_alive editor 0
# 存活：count（0-based）作为存活序号；等于 target → 命中（写 found_index、置 #note_found）
execute if score #is_alive editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:prop count
execute if score #is_alive editor matches 1 run execute store result score #temp_playhead editor run data get storage rhythm_axe:prop target
execute if score #is_alive editor matches 1 if score #temp editor = #temp_playhead editor run data modify storage rhythm_axe:prop found_index set from storage rhythm_axe:prop index
execute if score #is_alive editor matches 1 if score #temp editor = #temp_playhead editor run scoreboard players set #note_found editor 1
execute if score #is_alive editor matches 1 run scoreboard players add #temp editor 1
execute if score #is_alive editor matches 1 run execute store result storage rhythm_axe:prop count int 1 run scoreboard players get #temp editor
# 结束（叶子：不调用 advance；是否停止由驱动器判断 #note_found）
