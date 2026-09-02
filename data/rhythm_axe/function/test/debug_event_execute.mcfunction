# 手动触发事件命令执行（游戏运行中：/function rhythm_axe:test/debug_event_execute）
# 目的：绕过 advance，直接设置 ev_idx/cmd_idx/cur_cmd 并调用 execute，看 tellraw 是否触发
# 结果判断：
#   [手动]开始 + [手动]结束 都出现，且【组A】提示也出现 → execute 正常，问题在 advance 调用链
#   [手动]开始 + [手动]结束 出现，但【组A】不出现 → execute 内部 $(cur_cmd) 展开/执行失败
#   [手动]开始 出现但 [手动]结束 不出现 → execute 宏展开错误，整个函数中断
execute store result storage rhythm_axe:runtime ev_idx int 1 run scoreboard players set #evt_i play_state 0
execute store result storage rhythm_axe:runtime cmd_idx int 1 run scoreboard players set #evt_c play_state 0
data modify storage rhythm_axe:runtime cur_cmd set from storage rhythm_axe:runtime events[0].commands[0]
tellraw @a ["","[手动] 开始调用 execute"]
function rhythm_axe:play/event/execute with storage rhythm_axe:runtime
tellraw @a ["","[手动] execute 调用结束"]
