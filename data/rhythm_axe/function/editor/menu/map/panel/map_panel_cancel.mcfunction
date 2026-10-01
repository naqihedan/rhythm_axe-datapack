# 取消谱面设置：丢弃暂存副本，回主菜单
# 关闭面板 → 顺手清掉标题展示实体（Axiom 改标题通道，见 map_title_display_clear）
function rhythm_axe:editor/menu/map/ops/map_title_display_clear
data modify storage rhythm_axe:maps.editor feedback set value "已取消谱面设置修改"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data remove storage rhythm_axe:maps.editor panel_temp
function rhythm_axe:editor/menu/main
