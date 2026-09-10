# 编辑指令前奏：点击值 = (1000+指令序号)×100 + 3 → 序号 = click/100 - 1000
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
execute store result storage rhythm_axe:maps.editor editing.cmd_target int 1 run scoreboard players get #temp editor
dialog show @s rhythm_axe:editor_event_cmd
