# 音符列表【复制】前置：点击值 640+存活序 → 按存活序找数组索引 → 复制
execute store result score #temp editor run data get storage rhythm_axe:maps.editor notes_page
scoreboard players set #temp_cursor editor 40
scoreboard players operation #temp editor *= #temp_cursor editor
scoreboard players operation #temp_cursor editor = #click_value editor
scoreboard players remove #temp_cursor editor 100000
scoreboard players operation #temp_cursor editor /= 100 const
scoreboard players operation #temp editor += #temp_cursor editor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop count set value 0
data remove storage rhythm_axe:prop found_index
execute store result storage rhythm_axe:prop target int 1 run scoreboard players get #temp editor
# ★ 2026-08-25 重构：改调普通函数驱动器（宏叶子不递归）
function rhythm_axe:editor/menu/note/list/note_find_alive_advance
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 该音符不存在","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
function rhythm_axe:editor/menu/note/list/note_list_copy_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop count
data remove storage rhythm_axe:prop target
data remove storage rhythm_axe:prop found_index
# ★ 2026-09-30 用户要求：行级复制后重开活跃音符列表刷新面板（此前只发绿色聊天行，面板看起来“没反应”）
#   复制不改谱面 → 无需 refresh，直接重开列表；反馈“已复制音符信息”在十行换行下方渲染
#   当前面板仍是 10 → note_list_open 不会清掉刚写入的 note_clip（见其顶部剪贴板会话判定）
function rhythm_axe:editor/menu/note/list/note_list_open
