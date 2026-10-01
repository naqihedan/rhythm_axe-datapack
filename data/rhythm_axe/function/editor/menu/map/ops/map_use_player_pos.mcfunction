# 初始位置设为玩家当前位置（只改暂存 panel_temp）；★ 坐标只保留 1 位小数（四舍五入）
#   ×1000 读入（data get 的 scale）→ round_score 四舍五入到 ×100（= 0.1 精度）→ ×0.001 还原真实值写回 double
#   这样存下来的初始位置永远是整洁的 0.1 倍数，也避免被坐标 ±0.1 微调时带上长尾小数
execute store result score #rnd_v editor run data get entity @s Pos[0] 1000
function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_x double 0.001 run scoreboard players get #rnd_v editor
execute store result score #rnd_v editor run data get entity @s Pos[1] 1000
function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_y double 0.001 run scoreboard players get #rnd_v editor
execute store result score #rnd_v editor run data get entity @s Pos[2] 1000
function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_z double 0.001 run scoreboard players get #rnd_v editor
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
