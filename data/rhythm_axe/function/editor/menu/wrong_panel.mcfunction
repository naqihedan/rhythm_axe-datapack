# 兜底：trigger 值不属于当前打开面板（@s = 玩家）。
# 由 consume 按 #panel_id 分发到的各 panelN 分支函数在“值均未命中”时于末尾调用一次。
# 说明：分支函数内每个命中值都用 `run return run` 提前退出，全部未命中才会落到本函数。
tellraw @s [{"text":"[编辑器] 该按钮不属于当前面板","color":"yellow"}]
return fail
