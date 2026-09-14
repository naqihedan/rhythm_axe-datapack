# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 站立：播放速度循环（25/50/75/100%）；下蹲：音符流速工具（2/4/8/16 循环，刷新世界音符）
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/cycle_note_speed
# 站立：播放速度循环直接执行（不再 set trigger 避免 consume 二次发声）
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/cycle_speed
