# 事件点执行（宏参数 ev_idx）：执行 commands[0] 起全部，然后推进事件游标
#arg: cursor, ev_idx
scoreboard players set #ev_cmd_idx editor 0
execute store result storage rhythm_axe:prop cmd_idx int 1 run scoreboard players get #ev_cmd_idx editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[0] run data modify storage rhythm_axe:prop cur_cmd set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[0]
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[0] run function rhythm_axe:editor/visual/event_execute_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cmd_idx
data remove storage rhythm_axe:prop cur_cmd
# 推进事件游标继续检查（无论有无 commands）
function rhythm_axe:editor/visual/event_next_ with storage rhythm_axe:prop
