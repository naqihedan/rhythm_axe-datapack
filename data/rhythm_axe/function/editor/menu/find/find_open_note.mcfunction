# 查找音符：标记类型后打开 id 输入对话框
data modify storage rhythm_axe:maps.editor editing set value {}
data modify storage rhythm_axe:maps.editor editing.find_is_note set value 1b
dialog show @s rhythm_axe:editor_find_note
