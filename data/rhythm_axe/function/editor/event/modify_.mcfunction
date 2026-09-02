#arg:cursor,index
# merge event_fields 到 events[$(index)]（只覆盖传入字段）
$data modify storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] {} merge from storage rhythm_axe:prop event_fields
