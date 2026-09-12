#arg:field_name,delta,rel_group,rel_axis
# 判定位置/起始位置单轴加减（position[i]/start_pos[i]；scoreboard 存 ×100，delta ±10=0.1 格）
# 绝对模式改 editing.temp.<field>；相对模式改 editing.rel.delta.<group>[axis]（×100 整数）；无值域钳制
scoreboard players set #rel_on editor 0
$execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.$(rel_group)
$execute if score #rel_on editor matches 0 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.$(field_name) 1000
execute if score #rel_on editor matches 0 run scoreboard players operation #temp editor += 5 const
execute if score #rel_on editor matches 0 run scoreboard players operation #temp editor /= 10 const
$execute if score #rel_on editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.rel.delta.$(rel_group)[$(rel_axis)]
$scoreboard players operation #temp editor += $(delta) const
# 批量：标记本项已被改动（供面板【x】红/灰显示与取消）
$execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.$(rel_group) set value 1b
$execute if score #rel_on editor matches 0 run execute store result storage rhythm_axe:maps.editor editing.temp.$(field_name) double 0.01 run scoreboard players get #temp editor
$execute if score #rel_on editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.$(rel_group)[$(rel_axis)] int 1 run scoreboard players get #temp editor
data remove storage rhythm_axe:prop field_name
data remove storage rhythm_axe:prop delta
data remove storage rhythm_axe:prop rel_group
data remove storage rhythm_axe:prop rel_axis
function rhythm_axe:editor/menu/note/panel/note_panel
