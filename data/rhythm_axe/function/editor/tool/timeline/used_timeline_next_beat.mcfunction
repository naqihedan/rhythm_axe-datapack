# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 执行工具命令：站立=前进一拍(25)，蹲下=后退一拍(21)
execute unless entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 25
execute if entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 21
