# 失控保护触发时的提示（单独一刻打，避免和收尾挤链）
execute as @a[tag=editor_active] run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"缩放未能在预期时间内完成，已中止。请检查谱面数据后重试","color":"red"}]
