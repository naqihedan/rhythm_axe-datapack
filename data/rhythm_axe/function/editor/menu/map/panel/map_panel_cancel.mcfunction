# 取消谱面设置：丢弃暂存副本，回主菜单
data modify storage rhythm_axe:maps.editor feedback set value "已取消谱面设置修改"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data remove storage rhythm_axe:maps.editor panel_temp
function rhythm_axe:editor/menu/main
