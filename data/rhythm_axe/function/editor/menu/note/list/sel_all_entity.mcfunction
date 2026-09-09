# @s = 单个存活音符的展示实体（全部选中用）
# 统一以 storage 为真源：无条件给该音符元素加 .selected（已选再 merge 无害），并补实体标签与发光
# 不再用实体标签判断“已选”→ 去掉每实体 O(n) 的已选扫描，整体 O(n)，也无标签/存储脱同步风险
execute store result score #t_id editor run scoreboard players get @s note_id
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get @s editor_n_idx
function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
data remove storage rhythm_axe:prop idx
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #t_id editor run tag @s add editor_note_selected
data modify entity @s Glowing set value 1b
data modify entity @s glow_color_override set value 16776960
