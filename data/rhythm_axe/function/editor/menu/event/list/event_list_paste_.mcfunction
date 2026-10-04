#arg:cursor,index
# 粘贴事件信息到该事件（保留原 time，指令列表用剪贴板；一次历史快照）
execute unless data storage rhythm_axe:maps.editor event_clip run tellraw @s [{"text":"[编辑器] 剪贴板为空，先复制一个事件","color":"red"}]
execute unless data storage rhythm_axe:maps.editor event_clip run return fail
$execute store result score #new_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)].time
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改事件"
$data modify storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] merge from storage rhythm_axe:maps.editor event_clip
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)].time int 1 run scoreboard players get #new_time editor
function rhythm_axe:editor/file/commit
# ★ 事件点改动与音符视觉 / #ed_scale 均无关 → 不需要刷新（2026-10-02）
data modify storage rhythm_axe:maps.editor feedback set value "已粘贴事件信息"
# ★ 2026-09-12：列表渲染推迟到下一 tick（列表渲染是 O(谱长) 两遍遍历，与主操作分开跑）
schedule function rhythm_axe:editor/menu/event/list/event_list_open_next 1t
