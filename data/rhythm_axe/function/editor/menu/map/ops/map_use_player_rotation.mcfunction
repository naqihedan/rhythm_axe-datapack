# 初始角度设为玩家当前朝向（只改暂存 panel_temp）；★ 角度只保留整数（四舍五入）
#   ×1000 读入（data get 的 scale）→ round_score 四舍五入到 ×1000（= 整度）→ ×0.001 还原真实值写回 double
#   面板角度行仍按一位小数显示，整数会显示成 90.0 这类（显示格式未改）
execute store result score #rnd_v editor run data get entity @s Rotation[0] 1000
function rhythm_axe:editor/util/round_score {"unit":"1000","half":"500"}
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_yaw double 0.001 run scoreboard players get #rnd_v editor
execute store result score #rnd_v editor run data get entity @s Rotation[1] 1000
function rhythm_axe:editor/util/round_score {"unit":"1000","half":"500"}
execute store result storage rhythm_axe:maps.editor panel_temp.spawn_pitch double 0.001 run scoreboard players get #rnd_v editor
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
