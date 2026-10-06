#arg: key
# 工具选项栏 · 布尔翻转（tool_opt）：值 1 → 0，其它（0/缺失）→ 1
# key = 计分项名
scoreboard players set #tn editor 1
$execute if score $(key) tool_opt matches 1 run scoreboard players set #tn editor 0
$scoreboard players operation $(key) tool_opt = #tn editor
