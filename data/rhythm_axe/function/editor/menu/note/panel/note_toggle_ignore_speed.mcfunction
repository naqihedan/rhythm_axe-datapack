# 切换流速无视开关（ignore_note_speed）：开=出生时刻=判定时间-基础寿命（忽略流速）；关=出生时刻=判定时间-基础寿命×16/流速
# 先快照原始状态再互斥切换（顺序 if/unless 会互相覆盖：remove 后 unless 立即为真又把开关设回去→永远变开）
execute if data storage rhythm_axe:maps.editor editing.temp.ignore_note_speed run data modify storage rhythm_axe:prop ignore_was set value 1b
execute unless data storage rhythm_axe:maps.editor editing.temp.ignore_note_speed run data modify storage rhythm_axe:prop ignore_was set value 0b
execute store result score #ignore_was editor run data get storage rhythm_axe:prop ignore_was
execute if score #ignore_was editor matches 1 run data remove storage rhythm_axe:maps.editor editing.temp.ignore_note_speed
execute if score #ignore_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 1b
data remove storage rhythm_axe:prop ignore_was
function rhythm_axe:editor/menu/note/panel/note_panel
