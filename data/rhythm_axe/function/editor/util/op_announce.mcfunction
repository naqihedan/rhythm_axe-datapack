#arg:op_label
# 重操作提示（各重操作入口在「真正干活之前」调用；见调用方注释）
#   · 处理音符数 > 50（读计分板 #op_count）→ 聊天栏提示「正在 …（N 个音符），请稍候…」并置 #op_big = 1
#     调用方据此把整段重活 schedule 到下一刻 —— tellraw 与重活同 tick 时客户端会一起渲染，玩家看不到提示就先卡住了。
#   · ≤ 50 → 静默（#op_big = 0），调用方本刻直接执行，不增加任何延迟。
# ⚠️ 音符数走**计分板**而不是宏参数：调用方只需写 prop.op_label（操作名），少一个宏参就少一处"缺参静默不执行"的坑。
scoreboard players set #op_big editor 0
execute if score #op_count editor matches 51.. run scoreboard players set #op_big editor 1
$execute if score #op_count editor matches 51.. run tellraw @s [{"text":"[编辑器] 正在","color":"yellow"},{"text":"$(op_label)","color":"gold"},{"text":"（","color":"yellow"},{"score":{"name":"#op_count","objective":"editor"},"color":"aqua"},{"text":" 个音符），请稍候…","color":"yellow"}]
data remove storage rhythm_axe:prop op_label