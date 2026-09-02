# 重排工作副本所有音符 id 为连续唯一（= 数组下标 0..n-1），并同步 next_note_id。
# 用途：修复"打开已有谱面后新音符 id 与旧音符重复"导致的选中/删除错乱。
# 调用后自动 refresh 重建编辑器实体（note_id 配对用新 id）。
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
scoreboard players set #fix_total editor 0
data modify storage rhythm_axe:prop idx set value 0
function rhythm_axe:editor/util/fix_note_ids_drive
# next_note_id = 音符总数（id 已连续 0..n-1）；无音符则跳过
execute if score #fix_total editor matches 1.. run execute store result storage rhythm_axe:maps.editor next_note_id int 1 run scoreboard players get #fix_total editor
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop idx
scoreboard players reset #fix_total editor
scoreboard players reset #fix_idx editor
# 重建编辑器实体，让展示/交互实体的 note_id 用新 id 配对
function rhythm_axe:editor/visual/refresh
