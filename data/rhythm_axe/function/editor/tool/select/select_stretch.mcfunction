#arg:cx_int,cy_int,cz_int,nx,ny,nz
# 更新黄绿玻璃为选区长方体：item_display 位置 = 选区中心，scale = 各轴边长（=|角差|+1）
# 中心整数部分由 cx_int 等给出，奇数轴（#n?_odd=1）再补 0.5
# marker 精确定位中心（规避 26.x 实体 Pos 的 store result 写入失效，用 set from entity）
$summon marker $(cx_int).0 $(cy_int).0 $(cz_int).0 {Tags:["editor_tool_sel_anchor"]}
execute if score #nx_odd editor matches 1 as @e[tag=editor_tool_sel_anchor] at @s run tp @s ~0.5 ~ ~
execute if score #ny_odd editor matches 1 as @e[tag=editor_tool_sel_anchor] at @s run tp @s ~ ~0.5 ~
execute if score #nz_odd editor matches 1 as @e[tag=editor_tool_sel_anchor] at @s run tp @s ~ ~ ~0.5
data modify entity @e[tag=editor_tool_select_glow,limit=1] Pos[0] set from entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[0]
data modify entity @e[tag=editor_tool_select_glow,limit=1] Pos[1] set from entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[1]
data modify entity @e[tag=editor_tool_select_glow,limit=1] Pos[2] set from entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[2]
kill @e[tag=editor_tool_sel_anchor]
$data modify entity @e[tag=editor_tool_select_glow,limit=1] transformation.scale set value [$(nx),$(ny),$(nz)]
