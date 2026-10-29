#arg:glow_sel
# 计算从第一角(corner1)到当前注视位置的选区长方体，更新黄绿玻璃（state=1 预览）
# 协作：glow_sel = 本次要更新的那块玻璃的身份 tag（每人一块，由 select_glow_tick 传入）
# ★ 2026-10-29：全部 ×1000（支持亚方块网格）。第一角来自 select_read_pos（已吸附），
#   当前注视点在这里按**同一个** select_grid 吸附 ⇒ 与确认时（select_second 走 select_read_pos）逐位一致。
# 输出：macro minx/maxx/.../g_u → select_box（算盒子中心/边长并写玻璃）
execute store result score #c1x editor run data get storage rhythm_axe:maps.editor select_tool.corner1[0] 1000
execute store result score #c1y editor run data get storage rhythm_axe:maps.editor select_tool.corner1[1] 1000
execute store result score #c1z editor run data get storage rhythm_axe:maps.editor select_tool.corner1[2] 1000
# 当前注视点：取原始点 → 按 select_grid 吸附（不能用 align/~0.5，否则子格信息丢失）
execute anchored eyes positioned ^ ^ ^4 run summon marker ~ ~ ~ {Tags:["editor_tool_sel_anchor"]}
execute store result score #cx editor run data get entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[0] 1000
execute store result score #cy editor run data get entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[1] 1000
execute store result score #cz editor run data get entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[2] 1000
kill @e[tag=editor_tool_sel_anchor]
function rhythm_axe:editor/tool/select/select_grid_setup
scoreboard players operation #gs_v editor = #cx editor
function rhythm_axe:editor/tool/note/grid_snap_axis
scoreboard players operation #cx editor = #gs_v editor
scoreboard players operation #gs_v editor = #cy editor
function rhythm_axe:editor/tool/note/grid_snap_axis
scoreboard players operation #cy editor = #gs_v editor
scoreboard players operation #gs_v editor = #cz editor
function rhythm_axe:editor/tool/note/grid_snap_axis
scoreboard players operation #cz editor = #gs_v editor

# min/max 各轴（×1000）
scoreboard players operation #minx editor = #c1x editor
execute if score #cx editor < #minx editor run scoreboard players operation #minx editor = #cx editor
scoreboard players operation #maxx editor = #c1x editor
execute if score #cx editor > #maxx editor run scoreboard players operation #maxx editor = #cx editor
scoreboard players operation #miny editor = #c1y editor
execute if score #cy editor < #miny editor run scoreboard players operation #miny editor = #cy editor
scoreboard players operation #maxy editor = #c1y editor
execute if score #cy editor > #maxy editor run scoreboard players operation #maxy editor = #cy editor
scoreboard players operation #minz editor = #c1z editor
execute if score #cz editor < #minz editor run scoreboard players operation #minz editor = #cz editor
scoreboard players operation #maxz editor = #c1z editor
execute if score #cz editor > #maxz editor run scoreboard players operation #maxz editor = #cz editor
# 存宏参（含网格尺寸 #g_u，select_box 用它算 [min−g/2, max+g/2] 的盒子）
execute store result storage rhythm_axe:prop minx int 1 run scoreboard players get #minx editor
execute store result storage rhythm_axe:prop maxx int 1 run scoreboard players get #maxx editor
execute store result storage rhythm_axe:prop miny int 1 run scoreboard players get #miny editor
execute store result storage rhythm_axe:prop maxy int 1 run scoreboard players get #maxy editor
execute store result storage rhythm_axe:prop minz int 1 run scoreboard players get #minz editor
execute store result storage rhythm_axe:prop maxz int 1 run scoreboard players get #maxz editor
execute store result storage rhythm_axe:prop g_u int 1 run scoreboard players get #g_u editor
$data modify storage rhythm_axe:prop glow_sel set value "$(glow_sel)"
function rhythm_axe:editor/tool/select/select_box with storage rhythm_axe:prop
# 清宏参
data remove storage rhythm_axe:prop glow_sel
data remove storage rhythm_axe:prop minx
data remove storage rhythm_axe:prop maxx
data remove storage rhythm_axe:prop miny
data remove storage rhythm_axe:prop maxy
data remove storage rhythm_axe:prop minz
data remove storage rhythm_axe:prop maxz
data remove storage rhythm_axe:prop g_u
data remove storage rhythm_axe:prop nx
data remove storage rhythm_axe:prop ny
data remove storage rhythm_axe:prop nz
