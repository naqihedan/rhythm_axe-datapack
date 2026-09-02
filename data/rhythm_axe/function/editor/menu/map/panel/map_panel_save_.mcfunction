#arg:cursor
# merge 暂存副本到当前工作副本（只覆盖面板编辑过的根字段）
$data modify storage rhythm_axe:maps.editor history[$(cursor)] merge from storage rhythm_axe:maps.editor panel_temp
