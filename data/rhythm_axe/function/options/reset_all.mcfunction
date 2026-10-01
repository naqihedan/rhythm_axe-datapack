# 【恢复默认】第二步（16005，**确认后**）：清待确认状态，把所有设置重置为初始值（重绘由调用方统一做）。
# 复用 options/reset_options（含 options 与 score_calculate 两个计分板；幂等；末尾会 tellraw @a 提示）
#   ⚠️ reset_options 里 `options_initialized` 不动（那是 load 的首次加载哨兵），只重写各设置项的值。
data remove storage rhythm_axe:map_list reset_confirm
function rhythm_axe:options/reset_options
