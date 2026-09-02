# 确认删除音符（已武装）：按类型写撤销标签后调底层 note/delete，回列表
execute unless data storage rhythm_axe:maps.editor editing.delete_armed run function rhythm_axe:editor/menu/note/panel/note_panel_delete_arm
execute unless data storage rhythm_axe:maps.editor editing.delete_armed run return fail
execute store result score #note_type editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #note_type editor matches 0 run data modify storage rhythm_axe:maps.editor op_label set value "删除音符盒"
execute if score #note_type editor matches 1 run data modify storage rhythm_axe:maps.editor op_label set value "删除木板"
execute if score #note_type editor matches 2 run data modify storage rhythm_axe:maps.editor op_label set value "删除唱片机"
execute if score #note_type editor matches 3 run data modify storage rhythm_axe:maps.editor op_label set value "删除混凝土"
execute if score #note_type editor matches 4 run data modify storage rhythm_axe:maps.editor op_label set value "删除染色玻璃"
data modify storage rhythm_axe:prop note_id set from storage rhythm_axe:maps.editor editing.temp.id
# 先读来源面板（note/delete 内部 file/begin 会 consume 掉 editing.panel_from），删除后从哪来回哪去
execute store result score #from editor run data get storage rhythm_axe:maps.editor editing.panel_from
function rhythm_axe:editor/note/delete/delete
data remove storage rhythm_axe:prop note_id
data modify storage rhythm_axe:maps.editor feedback set value "已删除音符"
data remove storage rhythm_axe:maps.editor editing
function rhythm_axe:editor/menu/note/panel/note_panel_return
