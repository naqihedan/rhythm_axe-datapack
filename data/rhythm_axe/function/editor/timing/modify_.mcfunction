#arg:cursor,index
# merge timing_fields 到 timing_points[$(index)]（只覆盖传入字段）
$data modify storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] {} merge from storage rhythm_axe:prop timing_fields
