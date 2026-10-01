#arg:src,dst,unit_ms
# 把 $(src) editor 的数值换算成显示用时间分量，写到 $(dst)_* 分数（tellraw 用 score 组件拼出时间）
#   $(unit_ms) = 「1 个单位 = 多少毫秒」：刻输入传 50，毫秒输入传 1
#   $(dst)_m / $(dst)_s10 / $(dst)_s1 / $(dst)_c10 / $(dst)_c1 = 分:秒.百分秒（如 1:23.05）
#   $(dst)_ls / $(dst)_lc10 / $(dst)_lc1                     = 秒.百分秒（如 10.00）
#   单位数 × unit_ms ÷ 10 = 百分秒；6000 百分秒 = 1 分
# ⚠️ 两个口径千万别混（2026-10-01 用户指出）：
#     · 大厅预览（无 tick rate 调整、20tps）1 刻 = 50ms ⇒ unit_ms = 50
#     · 编辑器内 1 刻 ≠ 50ms（tick rate 随时间点变）⇒ 主菜单读 mod 算好的毫秒，unit_ms = 1
#   秒与百分秒都拆十位/个位 ⇒ 显示天然补零（0:06.40 而不是 0:6.4）
# 调用：function rhythm_axe:editor/util/tick_to_time {"src":"#temp","dst":"#tz","unit_ms":"50"}
#   ⚠️ src 分数要由调用方先 store 好（store result 失败会留旧值，本函数不做兜底）
$scoreboard players operation #tt_cs editor = $(src) editor
$scoreboard players operation #tt_cs editor *= $(unit_ms) const
scoreboard players operation #tt_cs editor /= 10 const
execute if score #tt_cs editor matches ..-1 run scoreboard players set #tt_cs editor 0
# —— 分:秒.百分秒 ——
$scoreboard players operation $(dst)_m editor = #tt_cs editor
$scoreboard players operation $(dst)_m editor /= 6000 const
scoreboard players operation #tt_rem editor = #tt_cs editor
scoreboard players operation #tt_rem editor %= 6000 const
$scoreboard players operation $(dst)_s10 editor = #tt_rem editor
$scoreboard players operation $(dst)_s10 editor /= 1000 const
$scoreboard players operation $(dst)_s1 editor = #tt_rem editor
$scoreboard players operation $(dst)_s1 editor %= 1000 const
$scoreboard players operation $(dst)_s1 editor /= 100 const
$scoreboard players operation $(dst)_c10 editor = #tt_rem editor
$scoreboard players operation $(dst)_c10 editor %= 100 const
$scoreboard players operation $(dst)_c10 editor /= 10 const
$scoreboard players operation $(dst)_c1 editor = #tt_rem editor
$scoreboard players operation $(dst)_c1 editor %= 10 const
# —— 秒.百分秒 ——
$scoreboard players operation $(dst)_ls editor = #tt_cs editor
$scoreboard players operation $(dst)_ls editor /= 100 const
$scoreboard players operation $(dst)_lc10 editor = #tt_cs editor
$scoreboard players operation $(dst)_lc10 editor %= 100 const
$scoreboard players operation $(dst)_lc10 editor /= 10 const
$scoreboard players operation $(dst)_lc1 editor = #tt_cs editor
$scoreboard players operation $(dst)_lc1 editor %= 10 const
