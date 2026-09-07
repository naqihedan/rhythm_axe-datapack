#arg:mapid,i
# 若音符带 selected 标记则移除（正式谱面不带选中状态）
$execute if data storage rhythm_axe:maps.$(mapid).notes[$(i)].selected run data remove storage rhythm_axe:maps.$(mapid).notes[$(i)].selected
