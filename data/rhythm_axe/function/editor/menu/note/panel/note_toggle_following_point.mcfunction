# 切换引导线开关（following_point）：开=生成前后 0/1/2 音符引导线；关=不生成
# 计分板判断；批量时打 batch_set 标记
scoreboard players set #following_was editor 0
execute store result score #following_was editor run data get storage rhythm_axe:maps.editor editing.temp.following_point
execute if score #following_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 0b
execute if score #following_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 1b
execute if score #following_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.batch_set.following_point set value 1b
execute if score #following_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.batch_set.following_point set value 1b
execute if score #following_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.changed.following_point set value 1b
execute if score #following_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.changed.following_point set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
