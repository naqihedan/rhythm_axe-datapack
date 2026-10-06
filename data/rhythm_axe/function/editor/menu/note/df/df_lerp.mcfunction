# 定点线性插值（防溢出）：出 #dw_p = #dw_a + (#dw_b − #dw_a) × #dw_r / 10000
#   入参：计分项 #dw_a / #dw_b（被插值的两端）、#dw_r（0~10000 的万分比进度）
#   ★ 2026-10-07 重写：单步相乘 + **四舍五入**
#     · 旧实现把 #dw_r 拆成 高位(/100) + 低位(%100) 两步乘除来防溢出，但**两次截断**会累积成
#       系统性偏早：2464→2470 三等分算出 2465 / 2467，正确的等分点应是 2466 / 2468
#       （1/3 存成 3333/10000，×6 = 1.9998 ⇒ 截断成 1）。
#     · 现在直接 d×r：最大 10^5 × 10^4 = 10^9，远小于 int 上限 2.1×10^9
#       （即"两端差 ≤ 20 万刻"都不会溢出，time 与位置都远远够用）。
#     · 四舍五入：delta 为正加 +5000、为负加 −5000，再用向零截断的 `/=` 落地。
scoreboard players set #dw_c10k editor 10000
scoreboard players operation #dw_d editor = #dw_b editor
scoreboard players operation #dw_d editor -= #dw_a editor
scoreboard players set #dw_half editor 5000
execute if score #dw_d editor matches ..-1 run scoreboard players set #dw_half editor -5000
scoreboard players operation #dw_t editor = #dw_d editor
scoreboard players operation #dw_t editor *= #dw_r editor
scoreboard players operation #dw_t editor += #dw_half editor
scoreboard players operation #dw_t editor /= #dw_c10k editor
scoreboard players operation #dw_p editor = #dw_t editor
scoreboard players operation #dw_p editor += #dw_a editor
