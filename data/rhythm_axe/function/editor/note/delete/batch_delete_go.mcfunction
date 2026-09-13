# 批量删除 —— 真正干活的实现（由 batch_delete.mcfunction 分发进来）
# 批量删除 = 删除原语 delete_by_ids：不做任何复制、不碰剪贴板（此前是「复用剪切链路」，会误报「已剪切」且要备份/还原剪贴板）
# ① selection 先存成待删列表（清空选中后就取不到了）② 记下从哪个面板点的 ③ 清空选中 ④ 删除
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
data modify storage rhythm_axe:prop note_ids set from storage rhythm_axe:maps.editor selection
execute store result storage rhythm_axe:prop ret_panel int 1 run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
data modify storage rhythm_axe:maps.editor op_label set value "批量删除音符"
function rhythm_axe:editor/note/delete/delete_by_ids
