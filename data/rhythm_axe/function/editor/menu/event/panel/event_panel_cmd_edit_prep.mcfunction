# 编辑指令前奏：点击值 = 511 + 指令序号，目标序号写入 editing.cmd_target 后打开对话框
scoreboard players operation #temp editor = #click_value editor
scoreboard players remove #temp editor 511
execute store result storage rhythm_axe:maps.editor editing.cmd_target int 1 run scoreboard players get #temp editor
dialog show @s rhythm_axe:editor_event_cmd
