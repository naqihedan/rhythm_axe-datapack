#arg:group,label,case,edit,color
$execute if score #group editor matches $(group) run tellraw @s [{"text":"$(label) / type0: ","color":"$(color)"},{"nbt":"sounds[$(group)][0].$(case)","storage":"rhythm_axe:feedback","color":"$(color)"}]
$execute if score #group editor matches $(group) run tellraw @s [{"text":"$(label) / type1: ","color":"$(color)"},{"nbt":"sounds[$(group)][1].$(case)","storage":"rhythm_axe:feedback","color":"$(color)"}]
$execute if score #group editor matches $(group) run tellraw @s [{"text":"$(label) / type2: ","color":"$(color)"},{"nbt":"sounds[$(group)][2].$(case)","storage":"rhythm_axe:feedback","color":"$(color)"}]
$execute if score #group editor matches $(group) run tellraw @s [{"text":"$(label) / type3: ","color":"$(color)"},{"nbt":"sounds[$(group)][3].$(case)","storage":"rhythm_axe:feedback","color":"$(color)"}]
$execute if score #group editor matches $(group) run tellraw @s [{"text":"$(label) / type4: ","color":"$(color)"},{"nbt":"sounds[$(group)][4].$(case)","storage":"rhythm_axe:feedback","color":"$(color)"}]
