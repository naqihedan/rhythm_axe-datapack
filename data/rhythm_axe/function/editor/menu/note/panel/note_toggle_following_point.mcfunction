# 切换引导线开关（following_point）：开=生成前后 0/1/2 音符引导线；关=不生成引导线
# 先快照原始状态再互斥切换（顺序 if/unless 会互相覆盖：remove 后 unless 立即为真又把开关设回去→永远变开）
scoreboard players set #following_was editor 0
execute store result score #following_was editor run data get storage rhythm_axe:maps.editor editing.temp.following_point
execute if score #following_was editor matches 1 run data remove storage rhythm_axe:maps.editor editing.temp.following_point
execute if score #following_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 1b
data remove storage rhythm_axe:prop following_was
function rhythm_axe:editor/menu/note/panel/note_panel
