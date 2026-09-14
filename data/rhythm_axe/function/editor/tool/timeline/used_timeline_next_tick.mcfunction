# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 执行工具命令：站立=前进一刻(24)，蹲下=后退一刻(22)
execute unless entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 24
execute if entity @s[predicate=rhythm_axe:sneaking] run trigger editor_click set 22
