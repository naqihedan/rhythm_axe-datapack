# 执行一条 hit_events 命令（宏参数 cur_cmd）
# 执行者 = 音符交互实体，位置 = 交互实体位置（指令内 ~ ~ ~ 以此为准；不做位置归零）
#arg: cur_cmd
$execute if data storage rhythm_axe:runtime cur_cmd run $(cur_cmd)
