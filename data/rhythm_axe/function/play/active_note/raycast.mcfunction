# 射线步进视线检测（每 tick 调用；仅用于【判定保护进入】）
# 完美判定区域 = 判定位置为中心的区域（音符.md），用展示实体本身代表：
#   展示实体 Pos 恒定 = 判定位置，且无碰撞箱不挡视线（interaction 会挡，已弃用）
# 从每个 playing 玩家眼睛出发，沿视线方向每 0.5 格采样，检测采样点附近 1 格内
#   是否有展示实体（=判定位置）→ 有则给其配对音符加 looked_at_perfect（保护进入用）
# 实际判定（分支B）不用射线步进，用原版 looking_at 精确命中音符 hitbox
scoreboard players set #ray_max play_state 9
execute as @a[tag=playing] at @s anchored eyes run function rhythm_axe:play/active_note/raycast_init
