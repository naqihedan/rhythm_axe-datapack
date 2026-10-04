#arg: value
# 对话框提交：间隔（两颗之间空几刻，0~9999；0 = 每刻一颗）
data remove storage rhythm_axe:prop in
$data modify storage rhythm_axe:prop in set value $(value)
tellraw @s [{"text":"[编辑器] "},{"text":"输入无效，请填数字（0~9999）","color":"red"}]
execute if data storage rhythm_axe:prop in run tellraw @s ""
execute if data storage rhythm_axe:prop in run execute store result score #v editor run data get storage rhythm_axe:prop in
execute if data storage rhythm_axe:prop in if score #v editor matches ..-1 run scoreboard players set #v editor 0
execute if data storage rhythm_axe:prop in if score #v editor matches 10000.. run scoreboard players set #v editor 9999
execute if data storage rhythm_axe:prop in run execute store result storage rhythm_axe:maps.editor editing.df.stp int 1 run scoreboard players get #v editor
execute if data storage rhythm_axe:prop in run function rhythm_axe:editor/menu/note/df/df_render
data remove storage rhythm_axe:prop in
