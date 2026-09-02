#arg:cursor,index
# 音符列表单行处理（宏"叶子"函数）：只处理当前这一个音符，内部绝不调用 advance / return。
# ★ 2026-08-25 重构（幽灵行修复）：26.x 宏函数若在递归栈中段调用 advance，展开结束时会从函数中间点
#   重跑剩余代码（产生 idx=29-33 幽灵行）。现在所有递归由普通函数 note_list_row_advance 驱动，
#   本函数只判定并输出当前音符；跳过与否用 #show_row 标志（不用不可靠的宏 return）。
scoreboard players set #show_row editor 1
# 计算列表长度（供驱动器判断越界）
scoreboard players set #note_total editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes run execute store result score #note_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
# 无效音符（缺 id：data remove 遗留的半坏元素）→ 不显示
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id run scoreboard players set #show_row editor 0
# 存活窗口：出生刻 = time - note_base_life×16/note_speed（ignore_note_speed→time-base_life），线性再提前4刻；playhead < 出生刻 → 未出生
# ★ 2026-09-01 出生刻改用流速缩放（与 scan_birth_one 一致），列表活跃窗口随流速正确
scoreboard players set #temp_playhead editor 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor playhead
scoreboard players set #temp_cursor editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life run execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed run scoreboard players operation #temp editor -= #temp_cursor editor
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed run scoreboard players operation #temp_cursor editor *= 16 const
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed run scoreboard players operation #temp_cursor editor /= note_speed options
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed run scoreboard players operation #temp editor -= #temp_cursor editor
# 线性提前4刻：普通0/1/2 power=1；玻璃4 power=1 dur>=1（与 scan_birth_one 一致）
scoreboard players set #temp_type editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type run execute store result score #temp_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
scoreboard players set #temp_pow editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].anim_power run execute store result score #temp_pow editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].anim_power
execute if score #temp_type editor matches 0..2 if score #temp_pow editor matches 1 run scoreboard players remove #temp editor 4
scoreboard players set #temp_dur editor 3
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration run execute store result score #temp_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration
execute if score #temp_type editor matches 4 if score #temp_pow editor matches 1 if score #temp_dur editor matches 1.. run scoreboard players remove #temp editor 4
execute if score #temp_playhead editor < #temp editor run scoreboard players set #show_row editor 0
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
execute if score #temp_playhead editor > #temp editor run scoreboard players set #show_row editor 0
# 存活序上限 40
execute if score #note_alive editor matches 40.. run scoreboard players set #show_row editor 0
# 存活：计数 +1，算按钮值（编辑 600+序、复制 640+序、粘贴 680+序、删除 720+序）
execute if score #show_row editor matches 1 run scoreboard players add #note_alive editor 1
execute if score #show_row editor matches 1 run execute store result score #temp editor run scoreboard players get #note_alive editor
execute if score #show_row editor matches 1 run scoreboard players set #temp_cursor editor 599
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp editor
execute if score #show_row editor matches 1 run scoreboard players set #temp_cursor editor 40
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #temp editor
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #temp editor
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp editor
# 输出行
$execute if score #show_row editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run function rhythm_axe:editor/menu/note/list/note_list_line with storage rhythm_axe:prop
# 结束（叶子：不调用 advance）
