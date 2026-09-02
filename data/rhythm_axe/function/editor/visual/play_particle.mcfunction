# 编辑器判定粒子播放（宏参数 cur_particle；粒子表存完整指令，直接宏执行）
# storage = rhythm_axe:editor.runtime（编辑器专属，与游玩系统 rhythm_axe:runtime 互不干扰）
# 执行者 = 展示实体，位置 = 音符判定位置（指令内 ~ ~ ~ 以此为准）
# ★ 玻璃（type=4）零特效：即使误入播放函数也直接 return（终极防线）
#arg: cur_particle
execute if score @s editor_n_type matches 4 run return fail
$execute if data storage rhythm_axe:editor.runtime cur_particle run $(cur_particle)
