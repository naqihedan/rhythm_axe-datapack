# 批量剪切 —— 真正干活的实现
# 剪切 = 复制 + 删除：先复制（收集链路）再删原音符；clip_action="batch_cut" 让 remove_finish 走到 batch_cut_finish
# ① selection 先存成待处理列表（清空选中后就取不到了）② 记下从哪个面板点的 ③ 清空选中 ④ 复制 + 删除
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
data modify storage rhythm_axe:prop note_ids set from storage rhythm_axe:maps.editor selection
execute store result storage rhythm_axe:prop ret_panel int 1 run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
data modify storage rhythm_axe:maps.editor op_label set value "批量剪切音符"
data modify storage rhythm_axe:prop clip_action set value "batch_cut"
function rhythm_axe:editor/note/copy/copy
