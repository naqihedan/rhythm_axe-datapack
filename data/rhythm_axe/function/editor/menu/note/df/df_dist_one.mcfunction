# 单颗音符的分发：prop.do_time / do_space 决定改哪几项
#   （执行时间分布 = 只 do_time；执行空间分布 = 只 do_space；填充 = 两者都有）
execute if data storage rhythm_axe:prop do_time run function rhythm_axe:editor/menu/note/df/df_dist_one_time with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop do_space run function rhythm_axe:editor/menu/note/df/df_dist_one_space with storage rhythm_axe:prop
