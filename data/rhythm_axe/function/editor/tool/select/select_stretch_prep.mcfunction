# 计算从第一角(corner1)到当前注视位置的选区长方体，更新黄绿玻璃（state=1 预览）
# 输出：prop.minx/miny/minz/nx/ny/nz → select_stretch（宏）
execute store result score #c1x editor run data get storage rhythm_axe:maps.editor select_tool.corner1[0]
execute store result score #c1y editor run data get storage rhythm_axe:maps.editor select_tool.corner1[1]
execute store result score #c1z editor run data get storage rhythm_axe:maps.editor select_tool.corner1[2]
# 当前注视方块坐标（store result 截断为整数方块坐标）
execute anchored eyes positioned ^ ^ ^4 run summon marker ~ ~ ~ {Tags:["editor_tool_sel_anchor"]}
execute store result score #cx editor run data get entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[0]
execute store result score #cy editor run data get entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[1]
execute store result score #cz editor run data get entity @e[tag=editor_tool_sel_anchor,limit=1] Pos[2]
kill @e[tag=editor_tool_sel_anchor]

# min/max 各轴
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
# 边长 n = max - min + 1（含两端方块）
scoreboard players operation #nx editor = #maxx editor
scoreboard players operation #nx editor -= #minx editor
scoreboard players add #nx editor 1
scoreboard players operation #ny editor = #maxy editor
scoreboard players operation #ny editor -= #miny editor
scoreboard players add #ny editor 1
scoreboard players operation #nz editor = #maxz editor
scoreboard players operation #nz editor -= #minz editor
scoreboard players add #nz editor 1
# 中心整数部分 = min + n/2（整数除法 floor）
scoreboard players operation #cx_int editor = #nx editor
scoreboard players operation #cx_int editor /= 2 const
scoreboard players operation #cx_int editor += #minx editor
scoreboard players operation #cy_int editor = #ny editor
scoreboard players operation #cy_int editor /= 2 const
scoreboard players operation #cy_int editor += #miny editor
scoreboard players operation #cz_int editor = #nz editor
scoreboard players operation #cz_int editor /= 2 const
scoreboard players operation #cz_int editor += #minz editor
# 奇偶标志（n%2；奇数轴中心需补 0.5，偶数轴中心是整数）
scoreboard players operation #nx_odd editor = #nx editor
scoreboard players operation #nx_odd editor %= 2 const
scoreboard players operation #ny_odd editor = #ny editor
scoreboard players operation #ny_odd editor %= 2 const
scoreboard players operation #nz_odd editor = #nz editor
scoreboard players operation #nz_odd editor %= 2 const
# 存宏参
execute store result storage rhythm_axe:prop cx_int int 1 run scoreboard players get #cx_int editor
execute store result storage rhythm_axe:prop cy_int int 1 run scoreboard players get #cy_int editor
execute store result storage rhythm_axe:prop cz_int int 1 run scoreboard players get #cz_int editor
execute store result storage rhythm_axe:prop nx int 1 run scoreboard players get #nx editor
execute store result storage rhythm_axe:prop ny int 1 run scoreboard players get #ny editor
execute store result storage rhythm_axe:prop nz int 1 run scoreboard players get #nz editor
# 更新黄绿玻璃（中心定位 + 边长缩放）

function rhythm_axe:editor/tool/select/select_stretch with storage rhythm_axe:prop
# 清宏参
data remove storage rhythm_axe:prop cx_int
data remove storage rhythm_axe:prop cy_int
data remove storage rhythm_axe:prop cz_int
data remove storage rhythm_axe:prop nx
data remove storage rhythm_axe:prop ny
data remove storage rhythm_axe:prop nz
