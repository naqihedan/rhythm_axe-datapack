# 写回谱面最高分（宏函数，由 score_calculate 在手动模式 auto=0 时调用）
# 独立成宏函数：score_calculate 是宏函数但"execute if ... run $execute"不合法（$ 必须整行开头），
#   写回需用带 $(mapid) 的宏行 → 拆成此独立宏函数，score_calculate 条件调用。
#arg: mapid
$execute store result storage rhythm_axe:maps.$(mapid) highest_score int 1 run scoreboard players get highest_score play_state
