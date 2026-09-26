# 判定延迟补偿 · 体检（手动运行：/function rhythm_axe:test/lag_report）
# 逐玩家打印：计分板 net 原始值（mod 写入的 RTT）→ 手动覆盖值 → 实际回退刻数
#   ★ 典型排查：net 全是 -1 ⇒ 房主那台机器没装（或没跑）rhythm_axe_mod
#     ⇒ #st_lag 恒 0、补偿静默失效（不报错、不刷日志，看日志查不出来，只能这样体检）
tellraw @a [{"text":"[延迟补偿] 逐玩家状态 —— 每人的判定箱回退刻数","color":"gold"}]
tellraw @a [{"text":"  覆盖用法：/scoreboard players set <玩家> lag_rtt_manual <毫秒>（0 = 该玩家不补偿，不设 = 自动）","color":"gray"}]
execute as @a run function rhythm_axe:test/lag_report_one
