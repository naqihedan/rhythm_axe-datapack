#arg: tool_label
# 无设置项的工具选项栏（面板 23，@s = 查看者；tool_label 经 storage rhythm_axe:prop 传入）
# 用户 2026-10-06 指定格式：======{工具名}选项栏======= + 正文"该工具没有设置项。"
$tellraw @s [{"text":"====$(tool_label)选项栏====","color":"gold","bold":true}]
tellraw @s [{"text":"该工具没有设置项。","color":"gray"}]
tellraw @s [{"text":""},{"text":"【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回上一个打开的面板"}}]
