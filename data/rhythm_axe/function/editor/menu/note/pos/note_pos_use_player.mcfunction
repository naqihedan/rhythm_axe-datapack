# 判定位置 = 玩家当前世界坐标（【使用玩家位置】）
execute store result storage rhythm_axe:maps.editor editing.temp.position[0] double 1 run data get entity @s Pos[0]
execute store result storage rhythm_axe:maps.editor editing.temp.position[1] double 1 run data get entity @s Pos[1]
execute store result storage rhythm_axe:maps.editor editing.temp.position[2] double 1 run data get entity @s Pos[2]
# ★ 批量模式：标记「判定位置」已被改动 —— 否则 batch_apply_one 的绝对分支（if editing.batch_set.position）
#   不会把 editing.temp.position 写回音符，表现为「面板显示了新坐标但确认后音符没变」
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.position set value 1b

data modify storage rhythm_axe:maps.editor feedback set value "判定位置已设为玩家位置（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
