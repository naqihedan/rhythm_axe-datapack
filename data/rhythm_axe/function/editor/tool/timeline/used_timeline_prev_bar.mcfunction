# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 直接执行：站立=快退一小节(step bar back)，蹲下=快进一小节(step bar fwd)；不再 set trigger 避免 consume 二次发声
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop kind set value "bar"
execute unless entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "back"
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop kind set value "bar"
execute if entity @s[predicate=rhythm_axe:sneaking] run data modify storage rhythm_axe:prop direction set value "fwd"
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
