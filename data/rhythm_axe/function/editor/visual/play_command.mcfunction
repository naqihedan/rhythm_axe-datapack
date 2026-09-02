# 编辑器 hit_events 单条命令执行（宏参数 cur_cmd）
# storage = rhythm_axe:editor.runtime（编辑器专属）
# 执行者 = 展示实体，位置 = 音符判定位置（指令内 ~ ~ ~ 以此为准）
# ★ 玻璃（type=4）零事件：即使误入也直接 return（终极防线）
#arg: cur_cmd
execute if score @s editor_n_type matches 4 run return fail
$execute if data storage rhythm_axe:editor.runtime cur_cmd run $(cur_cmd)
