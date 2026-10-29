#arg:gid
# 光标玻璃网格吸附（@s = 玩家；tag = glow_$(gid) 的那一块）
#   由 glow_note 每刻在「已 tp 到游标原始点」之后调用 ⇒ 玻璃与音符落在同一格点上
#   ★ 单独成函数是为了把 $(gid) 的宏实例化收敛成一次（glow_note 里 6 行宏会重复展开）
function rhythm_axe:editor/tool/note/grid_setup
$execute store result score #gs_v editor run data get entity @e[tag=glow_$(gid),limit=1] Pos[0] 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
$execute store result entity @e[tag=glow_$(gid),limit=1] Pos[0] double 0.001 run scoreboard players get #gs_v editor
$execute store result score #gs_v editor run data get entity @e[tag=glow_$(gid),limit=1] Pos[1] 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
$execute store result entity @e[tag=glow_$(gid),limit=1] Pos[1] double 0.001 run scoreboard players get #gs_v editor
$execute store result score #gs_v editor run data get entity @e[tag=glow_$(gid),limit=1] Pos[2] 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
$execute store result entity @e[tag=glow_$(gid),limit=1] Pos[2] double 0.001 run scoreboard players get #gs_v editor