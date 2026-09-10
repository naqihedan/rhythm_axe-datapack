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
scoreboard players set #temp_ig editor 0
$execute store result score #temp_ig editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
execute if score #temp_ig editor matches 1 run scoreboard players operation #temp editor -= #temp_cursor editor
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp_cursor editor *= 16 const
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp_cursor editor /= note_speed options
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp editor -= #temp_cursor editor
# 出生刻判定（与 spawn_one_ 一致，无线性提前）：playhead < 出生刻 → 未出生
execute if score #temp_playhead editor < #temp editor run scoreboard players set #show_row editor 0
# 消失刻 = 实体 editor_n_end（playhead > 消失刻 → 已消失；与 spawn_one_ 的 #n_end 一致）：
#   普通 0/1/2：time；混凝土 3：time+dur-1；玻璃 4：time+dur×16/note_speed+1（ignore_note_speed=1 不缩放）
scoreboard players set #temp_cursor editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration run execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration
scoreboard players set #temp_type editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type run execute store result score #temp_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
execute if score #temp_type editor matches 3 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #temp_type editor matches 3 run scoreboard players remove #temp editor 1
execute if score #temp_type editor matches 4 run scoreboard players operation #temp_glass editor = #temp_cursor editor
execute if score #temp_type editor matches 4 if score #temp_ig editor matches 0 run scoreboard players operation #temp_glass editor *= 16 const
execute if score #temp_type editor matches 4 if score #temp_ig editor matches 0 run scoreboard players operation #temp_glass editor /= note_speed options
execute if score #temp_type editor matches 4 run scoreboard players operation #temp editor += #temp_glass editor
execute if score #temp_type editor matches 4 run scoreboard players add #temp editor 1
execute if score #temp_playhead editor > #temp editor run scoreboard players set #show_row editor 0
# 复选框：选中状态以 storage 音符元素 .selected 为真源（供排序与勾选）
scoreboard players set #sel_on editor 0
$execute if score #show_row editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].selected run scoreboard players set #sel_on editor 1
# 排序：选中音符置底（#list_pass 0=只显示未选中；1=只显示选中）
execute if score #list_pass editor matches 0 if score #sel_on editor matches 1 run scoreboard players set #show_row editor 0
execute if score #list_pass editor matches 1 if score #sel_on editor matches 0 run scoreboard players set #show_row editor 0
# 存活：计数 +1（得显示序号）
execute if score #show_row editor matches 1 run scoreboard players add #note_alive editor 1
# 翻页过滤：仅显示本页（#temp = 序号 - 页起点 #page_start）
execute if score #show_row editor matches 1 run execute store result score #temp editor run scoreboard players get #note_alive editor
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor -= #page_start editor
execute if score #show_row editor matches 1 if score #temp editor matches ..0 run scoreboard players set #show_row editor 0
execute if score #show_row editor matches 1 if score #temp editor matches 41.. run scoreboard players set #show_row editor 0
# 按钮值（规范v2：值 = 行号×100 + 列码；行号 = 1000 + 页内序 ⇒ 值 = 100000 + 页内序×100 + 列码）
# 列码：复选框 0 / 编辑 3 / 复制 5 / 粘贴 6 / 删除 7
# ★ 2026-09-07 修复：用 alive_seq[$(index)]（数组存活序）而非 #note_alive（显示序），
#   否则"选中置底"后显示序与数组存活序错位，点击按钮会定位到错误音符。
$execute if score #show_row editor matches 1 if data storage rhythm_axe:prop alive_seq[$(index)] run execute store result score #temp editor run data get storage rhythm_axe:prop alive_seq[$(index)]
$execute if score #show_row editor matches 1 if data storage rhythm_axe:prop alive_seq[$(index)] run scoreboard players operation #temp editor -= #page_start editor
execute if score #show_row editor matches 1 run scoreboard players set #temp_cursor editor 100
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #show_row editor matches 1 run scoreboard players add #temp editor 100003
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp editor
execute if score #show_row editor matches 1 run scoreboard players add #temp editor 2
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #temp editor
execute if score #show_row editor matches 1 run scoreboard players add #temp editor 1
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #temp editor
execute if score #show_row editor matches 1 run scoreboard players add #temp editor 1
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp editor
# 复选框 toggle 点击值（列码 0）★ 用数组存活序 alive_seq[$(index)]
$execute if score #show_row editor matches 1 if data storage rhythm_axe:prop alive_seq[$(index)] run execute store result score #temp editor run data get storage rhythm_axe:prop alive_seq[$(index)]
$execute if score #show_row editor matches 1 if data storage rhythm_axe:prop alive_seq[$(index)] run scoreboard players operation #temp editor -= #page_start editor
execute if score #show_row editor matches 1 run scoreboard players set #temp_cursor editor 100
execute if score #show_row editor matches 1 run scoreboard players operation #temp editor *= #temp_cursor editor
execute if score #show_row editor matches 1 run scoreboard players add #temp editor 100000
execute if score #show_row editor matches 1 run execute store result storage rhythm_axe:prop sel_val int 1 run scoreboard players get #temp editor
# 输出行
$execute if score #show_row editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run function rhythm_axe:editor/menu/note/list/note_checkbox_write with storage rhythm_axe:prop
$execute if score #show_row editor matches 1 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run function rhythm_axe:editor/menu/note/list/note_list_line with storage rhythm_axe:prop
# 结束（叶子：不调用 advance）
