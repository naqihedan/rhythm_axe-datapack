# 兜底：trigger 值不属于设置面板（@s = 玩家）
# 与 map_list/wrong_panel 同职责，只是文案按"设置"写。
tellraw @s [{"text":"[设置] 该按钮不属于当前面板","color":"yellow"}]
return fail
