#arg:st_name,st_label
# 时间点面板【同步缩放】开关翻转（宏）：翻转 options.<st_name>（0/1）并提示 + 重绘面板
# ★ 四个开关（行 107）共用本函数：10701 音乐对齐 / 10702 长条时长 / 10703 飞行时长 / 10704 事件时间
# ★ 与主菜单 event_play_toggle 同款写法（翻转 → 提示 → 重绘所在面板）
# ★ 参数名用 st_* 前缀：既避开与 timing_panel / show_val3 的 prop.label 撞名，
#   也必须与 panel4 注入的 storage 键**完全一致**（不一致 ⇒ 宏实例化静默失败 = 点了没反应）
scoreboard players set #rs_tog editor 1
$execute if score $(st_name) options matches 1 run scoreboard players set #rs_tog editor 0
$scoreboard players operation $(st_name) options = #rs_tog editor
$execute if score $(st_name) options matches 1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"$(st_label)","color":"green"},{"text":"：开","color":"green"},{"text":"（改 tpb 时会同步调整）","color":"gray"}]
$execute unless score $(st_name) options matches 1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"$(st_label)","color":"red"},{"text":"：关","color":"red"},{"text":"（改 tpb 时不动谱面）","color":"gray"}]
function rhythm_axe:editor/menu/timing/panel/timing_panel