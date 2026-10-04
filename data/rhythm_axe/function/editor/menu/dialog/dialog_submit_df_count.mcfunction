#arg: value
# 对话框提交：每段插入个数（1~99）
data remove storage rhythm_axe:prop in
$data modify storage rhythm_axe:prop in set value $(value)
tellraw @s [{"text":"[编辑器] "},{"text":"输入无效，请填数字（1~99）","color":"red"}]
execute if data storage rhythm_axe:prop in run tellraw @s ""
execute if data storage rhythm_axe:prop in run execute store result score #v editor run data get storage rhythm_axe:prop in
execute if data storage rhythm_axe:prop in if score #v editor matches ..0 run scoreboard players set #v editor 1
execute if data storage rhythm_axe:prop in if score #v editor matches 100.. run scoreboard players set #v editor 99
execute if data storage rhythm_axe:prop in run execute store result storage rhythm_axe:maps.editor editing.df.cnt int 1 run scoreboard players get #v editor
execute if data storage rhythm_axe:prop in run function rhythm_axe:editor/menu/note/df/df_render
data remove storage rhythm_axe:prop in
