#arg: x, y, z
# 对话框提交：「到」坐标（X Y Z）→ 写 editing.df.s_b_fp（百分之一格）
data remove storage rhythm_axe:prop in
$data modify storage rhythm_axe:prop in set value [$(x),$(y),$(z)]
tellraw @s [{"text":"[编辑器] "},{"text":"输入无效，请填数字（如 5 / 1.5 / 0）","color":"red"}]
execute if data storage rhythm_axe:prop in[0] run tellraw @s ""
execute if data storage rhythm_axe:prop in[0] run execute store result score #v editor run data get storage rhythm_axe:prop in[0] 100
execute if data storage rhythm_axe:prop in[0] run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[0] int 1 run scoreboard players get #v editor
execute if data storage rhythm_axe:prop in[1] run execute store result score #v editor run data get storage rhythm_axe:prop in[1] 100
execute if data storage rhythm_axe:prop in[1] run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[1] int 1 run scoreboard players get #v editor
execute if data storage rhythm_axe:prop in[2] run execute store result score #v editor run data get storage rhythm_axe:prop in[2] 100
execute if data storage rhythm_axe:prop in[2] run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[2] int 1 run scoreboard players get #v editor
execute if data storage rhythm_axe:prop in[0] run function rhythm_axe:editor/menu/note/df/df_render
data remove storage rhythm_axe:prop in
