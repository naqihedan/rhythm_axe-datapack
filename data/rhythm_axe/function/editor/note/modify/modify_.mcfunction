#arg:cursor,found_index
# merge note_fields 到 notes[$(found_index)]（只覆盖传入字段）
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(found_index)] {} merge from storage rhythm_axe:prop note_fields
