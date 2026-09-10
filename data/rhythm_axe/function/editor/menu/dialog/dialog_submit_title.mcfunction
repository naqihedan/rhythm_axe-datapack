#arg:value
# 对话框提交：标题原样存字符串（可纯文本、可 JSON 文本组件）
# 显示处由 utilization/title_comp 生成标题组件：JSON 组件字符串宏传解析，裸纯文本走 nbt 引用渲染（都不会消失）
$data modify storage rhythm_axe:maps.editor panel_temp.title set value '$(value)'
data modify storage rhythm_axe:maps.editor feedback set value "已修改谱面标题（保存设置后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
