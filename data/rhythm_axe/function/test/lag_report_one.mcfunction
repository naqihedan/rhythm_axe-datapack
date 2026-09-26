# 判定延迟补偿 · 单玩家状态（@s = 玩家；由 test/lag_report 用 execute as @a 调用）
# ★ 用独立临时量 #rpt_*，不碰判定侧的 #st_*（本函数可能在任意时刻被手动调用，不能干扰当刻判定）
# net 原始值（-1 = 该玩家在 net 里没有分 = 房主没装 mod / 还没写）
# ★ 用 if score 而非 scoreboard players get：后者对“没有分”的玩家会报错刷日志
scoreboard players set #rpt_raw play_state -1
execute if score @s net matches -2147483648.. run scoreboard players operation #rpt_raw play_state = @s net
# 手动覆盖值（-1 = 没设 = 自动）
scoreboard players set #rpt_manual play_state -1
execute if score @s lag_rtt_manual matches 0.. run scoreboard players operation #rpt_manual play_state = @s lag_rtt_manual
# 有效 RTT = 手动（若设）优先，否则 net
scoreboard players operation #rpt_rtt play_state = #rpt_raw play_state
execute if score #rpt_manual play_state matches 0.. run scoreboard players operation #rpt_rtt play_state = #rpt_manual play_state
# 换算刻数（与 st_player 完全同式）：(RTT+30)/50，clamp 0..4
scoreboard players operation #rpt_lag play_state = #rpt_rtt play_state
scoreboard players add #rpt_lag play_state 30
scoreboard players operation #rpt_lag play_state /= 50 const
execute if score #rpt_lag play_state matches ..0 run scoreboard players set #rpt_lag play_state 0
execute if score #rpt_lag play_state matches 5.. run scoreboard players set #rpt_lag play_state 4
execute if score judge_lag_comp options matches 0 run scoreboard players set #rpt_lag play_state 0
tellraw @a ["",{"text":"[延迟补偿] ","color":"gold"},{"selector":"@s"},{"text":"  net=","color":"gray"},{"score":{"name":"#rpt_raw","objective":"play_state"}},{"text":"  手动=","color":"gray"},{"score":{"name":"#rpt_manual","objective":"play_state"}},{"text":"  ⇒ 回退=","color":"gray"},{"score":{"name":"#rpt_lag","objective":"play_state"}},{"text":"刻","color":"gray"},{"text":"   （-1 = 未写入/未设；开关 judge_lag_comp=0 时回退强制 0）","color":"dark_gray"}]
