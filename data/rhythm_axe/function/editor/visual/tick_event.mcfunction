# 编辑器事件点触发入口：@s = 编辑玩家；从游标 #vis_event 起检查 events[]（time 升序）
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop ev_idx int 1 run scoreboard players get #vis_event editor
function rhythm_axe:editor/visual/event_advance_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop ev_idx
data remove storage rhythm_axe:prop cursor
