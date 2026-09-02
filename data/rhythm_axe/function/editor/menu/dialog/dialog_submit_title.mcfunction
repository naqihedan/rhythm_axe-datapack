#arg:value
# 对话框提交：标题存为字符串（内容=JSON 文本组件，如 {"text":"A"} 或 [{"text":"A"},{"text":"B"}] 或 "新手教程"）
# 显示处用宏传 $(title) 作为组件参数解析（26.x nbt interpret 不解析，只能用宏）
$data modify storage rhythm_axe:maps.editor panel_temp.title set value '$(value)'
data modify storage rhythm_axe:maps.editor feedback set value "已修改谱面标题（保存设置后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
