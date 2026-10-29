# 网格吸附单轴（就地修改 #gs_v editor，口径 ×1000）
#   前置：#gs_v（坐标×1000）、#g_u（格距×1000）、#g_o（相位×1000）、#g_h（= #g_u/2）
#   公式：v' = floor((v - o + h) / u) * u + o   —— 计分板 /= 本身就是 floor，正负都正确
#   ★ 不用 round_score：它靠取绝对值，|v| < 1 的负数会丢符号
scoreboard players operation #gs_v editor -= #g_o editor
scoreboard players operation #gs_v editor += #g_h editor
scoreboard players operation #gs_v editor /= #g_u editor
scoreboard players operation #gs_v editor *= #g_u editor
scoreboard players operation #gs_v editor += #g_o editor