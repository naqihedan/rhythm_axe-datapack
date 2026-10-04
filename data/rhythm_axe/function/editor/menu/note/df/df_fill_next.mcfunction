# 跨刻入口（schedule 调用，执行者是服务端 → 必须重新 as 玩家）
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/note/df/df_fill_go
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/note/df/df_fill_go
