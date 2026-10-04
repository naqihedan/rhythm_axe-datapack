# 修改时间点：前置 prop.index（时间点索引）+ prop.timing_fields（只 merge 传入的字段）
execute unless data storage rhythm_axe:prop index run tellraw @s [{"text":"[编辑器] 缺少索引（prop.index）","color":"red"}]
execute unless data storage rhythm_axe:prop index run return fail

function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/timing/modify_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
# ★ 时间点改动不重建音符（2026-10-02）：只同步 #ed_scale（播放头所在段的 judgement_scale）
function rhythm_axe:editor/judge/scale_sync
tellraw @s [{"text":"[编辑器] 已修改时间点 ","color":"green"},{"nbt":"index","storage":"rhythm_axe:prop","color":"aqua"}]

data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop timing_fields
data remove storage rhythm_axe:prop cursor
