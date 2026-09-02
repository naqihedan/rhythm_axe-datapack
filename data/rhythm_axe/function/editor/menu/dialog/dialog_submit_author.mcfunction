#arg:value
# 对话框提交：作者写入暂存 panel_temp（字段名 artist，与谱面存储格式一致）
$data modify storage rhythm_axe:maps.editor panel_temp.artist set value "$(value)"
data modify storage rhythm_axe:maps.editor feedback set value "已修改谱面作者（保存设置后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
