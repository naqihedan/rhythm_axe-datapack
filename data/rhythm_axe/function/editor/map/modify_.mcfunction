#arg:cursor
# merge map_fields 到当前工作副本根（只覆盖传入字段）
$data modify storage rhythm_axe:maps.editor history[$(cursor)] {} merge from storage rhythm_axe:prop map_fields
