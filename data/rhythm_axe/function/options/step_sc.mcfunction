#arg: key, delta, min, max
# 通用步进（设置面板 · score_calculate 计分板版）：判定权重三项用（objective 是 score_calculate，不是 options）
#   ⚠️ 同 step.mcfunction：不要写 `scoreboard players add <key> <obj> -1`（add 的 count 只收正整数，
#      要减得用 remove），先把 delta 落到 #op_step 再用 operation += 做加法（支持负值、可跨 objective）。
scoreboard players set #op_step menu 0
$scoreboard players set #op_step menu $(delta)
$scoreboard players operation $(key) score_calculate += #op_step menu
$execute if score $(key) score_calculate matches ..$(min) run scoreboard players set $(key) score_calculate $(min)
$execute if score $(key) score_calculate matches $(max).. run scoreboard players set $(key) score_calculate $(max)
