# 时间设为播放头位置（只改暂存 editing.temp，确认才写回）
data modify storage rhythm_axe:maps.editor editing.temp.time set from storage rhythm_axe:maps.editor playhead
function rhythm_axe:editor/menu/event/panel/event_panel
