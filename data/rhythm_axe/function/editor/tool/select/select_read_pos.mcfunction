# 读当前注视点（按选择工具自己的网格吸附）到 prop.sx/sy/sz（data modify set from 保留 double；26.x store result 会截断 0.5→0）
# ★ 2026-10-29：网格尺寸（select_grid —— 与音符工具的 note_grid 独立）。
#   格点 = 0.5 + k×size；档3（1 格）= 0.5/1.5/2.5…，与旧「align + ~0.5」逐位一致 ⇒ 默认档零行为变化。
#   先取游标**原始点**（不能带 align/~0.5，否则子格信息丢失），再逐轴吸附。
execute anchored eyes positioned ^ ^ ^4 run summon marker ~ ~ ~ {Tags:["editor_tool_sel_pos"]}
data modify storage rhythm_axe:prop sx set from entity @e[tag=editor_tool_sel_pos,limit=1] Pos[0]
data modify storage rhythm_axe:prop sy set from entity @e[tag=editor_tool_sel_pos,limit=1] Pos[1]
data modify storage rhythm_axe:prop sz set from entity @e[tag=editor_tool_sel_pos,limit=1] Pos[2]
kill @e[tag=editor_tool_sel_pos]
# 网格吸附（共享 grid_setup / grid_snap_axis，只换档位来源）
function rhythm_axe:editor/tool/select/select_grid_setup
execute store result score #gs_v editor run data get storage rhythm_axe:prop sx 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
execute store result storage rhythm_axe:prop sx double 0.001 run scoreboard players get #gs_v editor
execute store result score #gs_v editor run data get storage rhythm_axe:prop sy 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
execute store result storage rhythm_axe:prop sy double 0.001 run scoreboard players get #gs_v editor
execute store result score #gs_v editor run data get storage rhythm_axe:prop sz 1000
function rhythm_axe:editor/tool/note/grid_snap_axis
execute store result storage rhythm_axe:prop sz double 0.001 run scoreboard players get #gs_v editor
