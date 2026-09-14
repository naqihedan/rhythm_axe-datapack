# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 直接执行：站立=前进一刻(seek fwd 1t)，蹲下=后退一刻(seek back 1t)；不再 set trigger 避免 consume 二次发声
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "fwd"
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop ticks set value 1
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "back"
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop ticks set value 1
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
