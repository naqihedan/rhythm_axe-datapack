#arg:cursor,index
# 粘贴音符信息到该音符（保留原 id 与原 time，其余字段用剪贴板；一次历史快照）
# 与时间点/事件列表的粘贴语义一致：行级覆盖内容、保留行的位置标识
# （id 是实体稳定寻址标识，time 是音符在数组中的排序位置，均不可被剪贴板覆盖）
execute unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [{"text":"[编辑器] 剪贴板为空，先复制一个音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor note_clip run return fail
$execute store result score #new_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
$execute store result score #new_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改音符"
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] merge from storage rhythm_axe:maps.editor note_clip
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time int 1 run scoreboard players get #new_time editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id int 1 run scoreboard players get #new_id editor
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已粘贴音符信息"
# 返回来源列表：已选定(18)回已选定，否则回活跃(10)
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #from editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute unless score #from editor matches 18 run function rhythm_axe:editor/menu/note/list/note_list_open
