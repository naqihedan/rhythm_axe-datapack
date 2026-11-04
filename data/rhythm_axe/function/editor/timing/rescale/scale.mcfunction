# 比例换算：#rs_out = round(#rs_off × #rs_num / #rs_den)
# 前置：#rs_num / #rs_den（已约分，均 > 0）；#rs_off（计分板，整数 ≥ 0）
# 输出：#rs_out
# ★ 用计分板而非 storage：本函数在一张谱面上会被调用 N×4 次（每音符最多 4 个字段），
#   每次 data get 都是 NBT 读 + 解析，比计分板拷贝贵一个数量级。
# ★ 拆分「先除后乘」避免 int32 溢出：off×num 在长谱面会越过 2.1e9，
#   q = off ÷ den、r = off mod den ⇒ off×num÷den = q×num + round(r×num÷den)，
#   中间量被 den 界住（num/den 已在 run 里做过 gcd 约分）。
# ★ 只对非负 off 成立（负数取模会偏一格）；调用方保证 off ≥ 0。
scoreboard players set #rs_two editor 2
scoreboard players operation #rs_q editor = #rs_off editor
scoreboard players operation #rs_q editor /= #rs_den editor
scoreboard players operation #rs_r editor = #rs_off editor
scoreboard players operation #rs_r editor %= #rs_den editor
scoreboard players operation #rs_r editor *= #rs_num editor
# 四舍五入：r×num 补 den/2 再整除
scoreboard players operation #rs_half editor = #rs_den editor
scoreboard players operation #rs_half editor /= #rs_two editor
scoreboard players operation #rs_r editor += #rs_half editor
scoreboard players operation #rs_r editor /= #rs_den editor
scoreboard players operation #rs_out editor = #rs_q editor
scoreboard players operation #rs_out editor *= #rs_num editor
scoreboard players operation #rs_out editor += #rs_r editor