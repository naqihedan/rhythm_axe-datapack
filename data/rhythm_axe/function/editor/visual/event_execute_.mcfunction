# 事件指令执行（宏参数：ev_idx, cmd_idx, cur_cmd；@s = 编辑玩家，~ ~ ~ 相对玩家）
# 递归推进在独立函数内完成（宏快照：游标+1 后必须用新快照的 cmd_idx 预置 cur_cmd 再递归）
#arg: cursor, ev_idx, cmd_idx, cur_cmd
# 执行当前指令（宏展开 cur_cmd）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run $(cur_cmd)
# 游标+1，有下一条 → 预置 cur_cmd 后递归（新快照 cmd_idx）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run scoreboard players add #ev_cmd_idx editor 1
execute store result storage rhythm_axe:prop cmd_idx int 1 run scoreboard players get #ev_cmd_idx editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run data modify storage rhythm_axe:prop cur_cmd set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)]
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run function rhythm_axe:editor/visual/event_execute_ with storage rhythm_axe:prop
