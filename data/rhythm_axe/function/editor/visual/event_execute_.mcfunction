# 事件指令执行（宏参数：cursor, ev_idx, cmd_idx, cur_cmd；@s = 编辑玩家）
# ★ 执行位置与游玩模式对齐：固定 `positioned 0.0 0.0 0.0`（世界原点），不再用编辑玩家脚下的 ~ ~ ~
# ★ 递归推进必须在独立函数 event_execute_next_ 完成（宏展开快照问题，与 play/event/execute_next 同解）
#arg: cursor, ev_idx, cmd_idx, cur_cmd
# 执行当前指令（宏展开 cur_cmd）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run execute positioned 0.0 0.0 0.0 run $(cur_cmd)
# 游标+1（有下一条才推进）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run scoreboard players add #ev_cmd_idx editor 1
execute store result storage rhythm_axe:prop cmd_idx int 1 run scoreboard players get #ev_cmd_idx editor
# 有下一条 → 交给 event_execute_next_（重新快照 cmd_idx=新值）预置 cur_cmd 后继续递归
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run function rhythm_axe:editor/visual/event_execute_next_ with storage rhythm_axe:prop
