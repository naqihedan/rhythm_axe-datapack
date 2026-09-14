# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 直接执行：站立=返回开头，蹲下=跳到结尾；不再 set trigger 避免 consume 二次发声
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/jump/jump_start
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/menu/jump/jump_end
