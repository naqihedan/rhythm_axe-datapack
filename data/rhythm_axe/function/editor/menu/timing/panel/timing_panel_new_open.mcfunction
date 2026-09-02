# 打开新增时间点面板：默认值 time=播放头，其余默认（150 BPM / 4 拍 / 8 刻 / 判定缩放 1）
data modify storage rhythm_axe:maps.editor editing set value {}
# 记录操作发起面板（撤销/重做后回此面板；从时间点列表打开 → 3）
data modify storage rhythm_axe:maps.editor editing.panel_from set from storage rhythm_axe:maps.editor current_panel
data modify storage rhythm_axe:maps.editor current_panel set value 4
data modify storage rhythm_axe:maps.editor editing.is_new set value 1b
data modify storage rhythm_axe:maps.editor editing.temp set value {time:0,bpm:150.0f,bpb:4,tpb:8,judgement_scale:1}
execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run data get storage rhythm_axe:maps.editor playhead
function rhythm_axe:editor/menu/timing/panel/timing_panel
