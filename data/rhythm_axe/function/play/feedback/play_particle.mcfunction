# 播放判定粒子（宏参数 cur_particle；粒子表存完整指令，直接宏执行）
# 执行者 = 音符交互实体，位置 = 交互实体位置（指令内 ~ ~ ~ 以此为准）
#arg: cur_particle
$execute if data storage rhythm_axe:runtime cur_particle run $(cur_particle)
