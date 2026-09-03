# 切换流速无视开关（ignore_note_speed）：开=出生时刻=判定时间-基础寿命；关=×16/流速
# 用计分板判断（if data storage 对 0b 也判真会误判）；批量时打 batch_set 标记
scoreboard players set #igit_was editor 0
execute store result score #igit_was editor run data get storage rhythm_axe:maps.editor editing.temp.ignore_note_speed
execute if score #igit_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 0b
execute if score #igit_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 1b
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed set value 1b
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.changed.ignore_note_speed set value 1b
execute unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.changed.ignore_note_speed set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
