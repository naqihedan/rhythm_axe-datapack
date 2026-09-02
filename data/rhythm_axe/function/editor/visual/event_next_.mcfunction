# 事件游标推进（宏参数 ev_idx）：#vis_event +1 并继续检查
#arg: ev_idx
scoreboard players add #vis_event editor 1
execute store result storage rhythm_axe:prop ev_idx int 1 run scoreboard players get #vis_event editor
function rhythm_axe:editor/visual/event_advance_ with storage rhythm_axe:prop
