# 编辑指令前奏：点击值 = (1000+指令序号)×100 + 3 → 序号 = click/100 - 1000
# ★ 2026-11-08：普通【✏】编辑必须先清掉「快捷操作」标记，否则该对话框点【取消】会误走
#   quick_flow / quick_add 分支（复原暂存甚至删掉一条指令）。
data remove storage rhythm_axe:maps.editor editing.quick_flow
data remove storage rhythm_axe:maps.editor editing.quick_add
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
execute store result storage rhythm_axe:maps.editor editing.cmd_target int 1 run scoreboard players get #temp editor
dialog show @s rhythm_axe:editor_event_cmd
