#arg:cursor,index
# 打开已有时间点的设置面板：暂存副本 editing.temp（编辑只改暂存，【确认】才写回并进历史）
data modify storage rhythm_axe:maps.editor editing set value {}
# 记录操作发起面板（撤销/重做后回此面板；从时间点列表打开 → 3）
data modify storage rhythm_axe:maps.editor editing.panel_from set from storage rhythm_axe:maps.editor current_panel
data modify storage rhythm_axe:maps.editor current_panel set value 4
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)]
# 旧时间点可能缺字段，补缺省值
execute unless data storage rhythm_axe:maps.editor editing.temp.bpm run data modify storage rhythm_axe:maps.editor editing.temp.bpm set value 150.0f
execute unless data storage rhythm_axe:maps.editor editing.temp.bpb run data modify storage rhythm_axe:maps.editor editing.temp.bpb set value 4
execute unless data storage rhythm_axe:maps.editor editing.temp.tpb run data modify storage rhythm_axe:maps.editor editing.temp.tpb set value 8
execute unless data storage rhythm_axe:maps.editor editing.temp.judgement_scale run data modify storage rhythm_axe:maps.editor editing.temp.judgement_scale set value 1
function rhythm_axe:editor/menu/timing/panel/timing_panel
