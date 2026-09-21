# 兜底：trigger 值不属于大厅当前面板（@s = 玩家）
# 与 editor/menu/wrong_panel 同职责，只是文案按"大厅"写。
tellraw @s [{"text":"[大厅] 该按钮不属于当前面板","color":"yellow"}]
return fail
