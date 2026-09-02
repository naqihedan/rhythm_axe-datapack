# 打开新增事件点面板：默认值 time=播放头、无指令
data modify storage rhythm_axe:maps.editor current_panel set value 6
data modify storage rhythm_axe:maps.editor editing set value {}
data modify storage rhythm_axe:maps.editor editing.is_new set value 1b
data modify storage rhythm_axe:maps.editor editing.temp set value {time:0,commands:[]}
execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run data get storage rhythm_axe:maps.editor playhead
function rhythm_axe:editor/menu/event/panel/event_panel
