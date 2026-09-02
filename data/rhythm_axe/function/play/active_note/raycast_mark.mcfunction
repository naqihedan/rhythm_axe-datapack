# 展示实体（Pos=判定位置，完美判定区域代表）→ 给其配对的移动交互实体加 looked_at_perfect（@s=展示实体）
scoreboard players operation #tmp_nid play_state = @s note_id
execute as @e[tag=note_interaction] if score @s note_id = #tmp_nid play_state run tag @s add looked_at_perfect
