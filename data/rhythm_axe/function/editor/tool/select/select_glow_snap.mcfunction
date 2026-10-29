#arg:gid
# 选择工具 state=0 预览玻璃的网格吸附（@s = 玩家；玻璃 tag = glow_sel_$(gid)）
#   由 select_glow_tick 在「已 tp 到游标原始点」之后调用 ⇒ 小方块与角点落在同一格点
#   ★ 单独成函数：把 $(gid) 的宏实例化收敛成一次（state=0 是本工具最常驻的分支）
function rhythm_axe:editor/tool/select/select_grid_setup
$execute store result score #gs_v editor run data get entity @e[tag=glow_sel_$(gid),limit=1] Pos[0] 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
$execute store result entity @e[tag=glow_sel_$(gid),limit=1] Pos[0] double 0.001 run scoreboard players get #gs_v editor
$execute store result score #gs_v editor run data get entity @e[tag=glow_sel_$(gid),limit=1] Pos[1] 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
$execute store result entity @e[tag=glow_sel_$(gid),limit=1] Pos[1] double 0.001 run scoreboard players get #gs_v editor
$execute store result score #gs_v editor run data get entity @e[tag=glow_sel_$(gid),limit=1] Pos[2] 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
$execute store result entity @e[tag=glow_sel_$(gid),limit=1] Pos[2] double 0.001 run scoreboard players get #gs_v editor