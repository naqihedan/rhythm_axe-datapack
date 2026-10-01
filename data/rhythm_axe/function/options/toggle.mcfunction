#arg: key, obj
# 通用布尔翻转（设置面板用）：值 1 → 0，其它（0 / 缺失）→ 1
# key = 计分项名；obj = 计分板名（普通设置 = options；模组开关 = mods）
scoreboard players set #op_cur menu 0
$execute store result score #op_cur menu run scoreboard players get $(key) $(obj)
scoreboard players set #op_new menu 1
execute if score #op_cur menu matches 1 run scoreboard players set #op_new menu 0
$scoreboard players operation $(key) $(obj) = #op_new menu
