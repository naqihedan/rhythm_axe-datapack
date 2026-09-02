# 写结束时间到暂存 panel_temp 并提示
execute store result storage rhythm_axe:maps.editor panel_temp.end_time int 1 run scoreboard players get #temp editor
data modify storage rhythm_axe:maps.editor feedback set value "已设置结束时间（保存设置后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
