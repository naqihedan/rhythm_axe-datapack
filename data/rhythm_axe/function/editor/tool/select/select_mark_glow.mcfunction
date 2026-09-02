#arg:nid
# 给同 note_id 的展示实体（玩家看到的音符）发黄光
$execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s Glowing set value 1b
$execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s glow_color_override set value 16776960
