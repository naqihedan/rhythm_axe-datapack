# 查找事件点：标记类型后打开时间输入对话框
data modify storage rhythm_axe:maps.editor editing set value {}
data modify storage rhythm_axe:maps.editor editing.find_is_event set value 1b
dialog show @s rhythm_axe:editor_find_time
