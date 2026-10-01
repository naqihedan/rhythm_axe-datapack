# 判定位置 = 玩家当前世界坐标（【使用玩家位置】）；★ 坐标只保留 1 位小数（四舍五入，同谱面设置面板）
#   ×1000 读入（data get 的 scale）→ round_score 四舍五入到 ×100（= 0.1 精度）→ ×0.001 还原真实值写回 double
execute store result score #rnd_v editor run data get entity @s Pos[0] 1000
function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
execute store result storage rhythm_axe:maps.editor editing.temp.position[0] double 0.001 run scoreboard players get #rnd_v editor
execute store result score #rnd_v editor run data get entity @s Pos[1] 1000
function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
execute store result storage rhythm_axe:maps.editor editing.temp.position[1] double 0.001 run scoreboard players get #rnd_v editor
execute store result score #rnd_v editor run data get entity @s Pos[2] 1000
function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
execute store result storage rhythm_axe:maps.editor editing.temp.position[2] double 0.001 run scoreboard players get #rnd_v editor
# ★ 批量模式：标记「判定位置」已被改动 —— 否则 batch_apply_one 的绝对分支（if editing.batch_set.position）
#   不会把 editing.temp.position 写回音符，表现为「面板显示了新坐标但确认后音符没变」
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.position set value 1b

data modify storage rhythm_axe:maps.editor feedback set value "判定位置已设为玩家位置（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
