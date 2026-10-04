# 定点线性插值（防溢出）：出 #dw_p = #dw_a + (#dw_b - #dw_a) * #dw_r / 10000
#   入参：计分项 #dw_a / #dw_b / #dw_r（0~10000）
#   把 #dw_r 拆成 高位(#r/100) + 低位(#r%100) 两步乘，避免 delta×10000 溢出（delta 可到 10 万级）
scoreboard players set #dw_c100 editor 100
scoreboard players set #dw_c10k editor 10000
scoreboard players operation #dw_d editor = #dw_b editor
scoreboard players operation #dw_d editor -= #dw_a editor
scoreboard players operation #dw_q editor = #dw_r editor
scoreboard players operation #dw_q editor /= #dw_c100 editor
scoreboard players operation #dw_rm editor = #dw_r editor
scoreboard players operation #dw_rm editor %= #dw_c100 editor
scoreboard players operation #dw_t editor = #dw_d editor
scoreboard players operation #dw_t editor *= #dw_q editor
scoreboard players operation #dw_t editor /= #dw_c100 editor
scoreboard players operation #dw_t2 editor = #dw_d editor
scoreboard players operation #dw_t2 editor *= #dw_rm editor
scoreboard players operation #dw_t2 editor /= #dw_c10k editor
scoreboard players operation #dw_p editor = #dw_t editor
scoreboard players operation #dw_p editor += #dw_t2 editor
scoreboard players operation #dw_p editor += #dw_a editor
