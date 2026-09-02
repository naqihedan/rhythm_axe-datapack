# 遍历到末尾：prev=跳候选（最后记录）/ next=无目标
execute if data storage rhythm_axe:prop {jump_mode:"prev"} run function rhythm_axe:editor/util/jump_prev_apply
execute if data storage rhythm_axe:prop {jump_mode:"next"} run function rhythm_axe:editor/util/jump_next_none
