# 射线步进单步（@s=玩家，执行位置=当前采样点，朝向=玩家朝向；递归直到 #ray_max 步）
# 仅用于【判定保护进入】检测：采样点附近 1 格内的展示实体（Pos=判定位置）→ 配对交互实体加 looked_at_perfect
# （实际判定不用射线步进，用原版 looking_at 精确命中音符 hitbox，见 judgement/judgement）
execute as @e[type=item_display,tag=note_display,distance=..1.0] run function rhythm_axe:play/active_note/raycast_mark
# 前进 0.5 格到下一采样点
execute positioned ^ ^ ^0.5 run scoreboard players add #ray_d play_state 1
# 若未到最大步数，在下一采样点继续
execute if score #ray_d play_state < #ray_max play_state positioned ^ ^ ^0.5 run function rhythm_axe:play/active_note/raycast_step
