#arg:value
# 对话框提交：结束时间（刻，输入数字；输入 -1 表示未定义）；写入暂存 panel_temp
scoreboard players set #temp editor 0
$scoreboard players set #temp editor $(value)
execute if score #temp editor matches -1 run data remove storage rhythm_axe:maps.editor panel_temp.end_time
execute unless score #temp editor matches -1 run function rhythm_axe:editor/menu/dialog/dialog_submit_end_time_apply
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
