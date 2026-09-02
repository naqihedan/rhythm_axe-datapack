#arg:value
# 对话框提交：BPM（小数）写入暂存 editing.temp（确认后才进历史）
$data modify storage rhythm_axe:maps.editor editing.temp.bpm set value $(value)
execute store result storage rhythm_axe:maps.editor editing.temp.bpm float 1 run data get storage rhythm_axe:maps.editor editing.temp.bpm
data modify storage rhythm_axe:maps.editor feedback set value "BPM 已修改（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/timing/panel/timing_panel
