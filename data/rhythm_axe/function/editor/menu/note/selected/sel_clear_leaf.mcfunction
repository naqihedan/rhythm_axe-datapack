#arg:cursor,i
# 若音符带 selected 标记则移除
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].selected run data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].selected
