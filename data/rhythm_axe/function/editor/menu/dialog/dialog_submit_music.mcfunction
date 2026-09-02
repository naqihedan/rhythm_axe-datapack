#arg:value
# 对话框提交：音乐文件写入暂存 panel_temp
$data modify storage rhythm_axe:maps.editor panel_temp.music set value "$(value)"
data modify storage rhythm_axe:maps.editor feedback set value "已修改音乐文件（保存设置后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
