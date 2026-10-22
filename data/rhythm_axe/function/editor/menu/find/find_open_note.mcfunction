# 查找音符（2026-10-21 重做）：打开「类型/颜色/时间范围」筛选对话框（提交 → dialog_submit_find_note）
#   旧「按 id 查找输出聊天栏」已删除（find_note_prep/find_note_/find_note_cmp）
data modify storage rhythm_axe:maps.editor editing set value {}
dialog show @s rhythm_axe:editor_find_note
