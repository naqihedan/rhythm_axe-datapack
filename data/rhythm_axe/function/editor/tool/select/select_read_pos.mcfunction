# 读当前注视方块中心到 prop.sx/sy/sz（data modify set from 保留 double；26.x store result 会截断 0.5→0）
execute anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run summon marker ~ ~ ~ {Tags:["editor_tool_sel_pos"]}
data modify storage rhythm_axe:prop sx set from entity @e[tag=editor_tool_sel_pos,limit=1] Pos[0]
data modify storage rhythm_axe:prop sy set from entity @e[tag=editor_tool_sel_pos,limit=1] Pos[1]
data modify storage rhythm_axe:prop sz set from entity @e[tag=editor_tool_sel_pos,limit=1] Pos[2]
kill @e[tag=editor_tool_sel_pos]
