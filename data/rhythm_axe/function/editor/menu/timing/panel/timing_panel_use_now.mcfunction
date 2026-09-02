# 时间设为播放头位置（只改暂存 editing.temp）
execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run data get storage rhythm_axe:maps.editor playhead
function rhythm_axe:editor/menu/timing/panel/timing_panel
