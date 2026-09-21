# 编辑器真实判定：射线步进视线检测（每 tick 调用；**仅用于【判定保护进入】**）
# 与游玩 play/active_note/raycast 同一套，差异只在 tag：
#   玩家 = editor_active（游玩 playing）、实体 = editor_note（游玩 note_display / note_interaction）
# 完美判定区域 = 判定位置：编辑器展示实体 Pos **恒 = 判定位置**（由 fill_disp 从谱面 position 写入），
#   视觉位置在 transformation.translation 上，所以展示实体可以直接代表判定位置（无碰撞箱、不挡视线）
# 做法：从每个编辑者眼睛出发，沿视线每 0.5 格采样，采样点附近 1 格内有展示实体 → 它打 editor_n_looked_perfect
# 实际判定（分支 B）不用射线步进，仍用原版 looking_at 精确命中音符 hitbox（见 judge/look_check）
# ★ 标记由调用方（visual/tick）每刻先清后打，只代表"本刻"
scoreboard players set #ray_max editor 9
execute as @a[tag=editor_active] at @s anchored eyes run function rhythm_axe:editor/judge/raycast_init
