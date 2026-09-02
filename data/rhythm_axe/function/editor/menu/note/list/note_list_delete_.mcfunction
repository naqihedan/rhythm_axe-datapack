#arg:cursor,index
# 删除该音符（按类型写撤销标签"删除{种类}"）
$execute store result score #note_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
execute if score #note_type editor matches 0 run data modify storage rhythm_axe:maps.editor op_label set value "删除音符盒"
execute if score #note_type editor matches 1 run data modify storage rhythm_axe:maps.editor op_label set value "删除木板"
execute if score #note_type editor matches 2 run data modify storage rhythm_axe:maps.editor op_label set value "删除唱片机"
execute if score #note_type editor matches 3 run data modify storage rhythm_axe:maps.editor op_label set value "删除混凝土"
execute if score #note_type editor matches 4 run data modify storage rhythm_axe:maps.editor op_label set value "删除染色玻璃"
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
execute store result storage rhythm_axe:prop note_id int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/note/delete/delete
data remove storage rhythm_axe:prop note_id
data modify storage rhythm_axe:maps.editor feedback set value "已删除音符"
# 返回来源列表：已选定(18)回已选定，否则回活跃(10)
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #from editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute unless score #from editor matches 18 run function rhythm_axe:editor/menu/note/list/note_list_open
