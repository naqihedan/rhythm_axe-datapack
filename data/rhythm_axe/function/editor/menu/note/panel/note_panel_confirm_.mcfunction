#arg:cursor,index
# 确认写入：移除原音符后按新 time 升序重插
# ★ 2026-09-16 身份校验（防误删别的音符）：只有「下标处的音符 id == 正在编辑的音符 id」才允许摘除重插。
#   数组只要在面板打开后被改动过（批量改时间后的 order_repair / 粘贴 / 翻转 / 撤销…），原下标就可能
#   指向另一个音符 → 无校验时那个音符会被删掉并被 editing.temp 顶替（= 用户看到的「删了单个音符」）。
#   两个 id 先置 -1 哨兵：任一读取失败（元素不存在 / temp.id 缺失）都判为不一致 → 中止且不动数据。
scoreboard players set #cfm_id editor -1
scoreboard players set #cfm_tid editor -1
$execute store result score #cfm_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
execute store result score #cfm_tid editor run data get storage rhythm_axe:maps.editor editing.temp.id
execute unless score #cfm_id editor = #cfm_tid editor run tellraw @s [{"text":"[编辑器] 该音符已变动（面板失效），已取消确认，请重新打开该音符","color":"red"}]
execute unless score #cfm_id editor = #cfm_tid editor run return fail
data modify storage rhythm_axe:prop tmp_elem set from storage rhythm_axe:maps.editor editing.temp
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
execute store result storage rhythm_axe:prop new_time int 1 run data get storage rhythm_axe:maps.editor editing.temp.time
data modify storage rhythm_axe:prop list_name set value "notes"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_at with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop insert_index run function rhythm_axe:editor/util/insert_append with storage rhythm_axe:prop
