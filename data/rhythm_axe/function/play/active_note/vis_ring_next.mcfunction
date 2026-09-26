# 位置历史环推进（判定延迟补偿 · 非线性音符用；@s = 音符交互实体）
#   #pvx/#pvy/#pvz（play_state，×100）= 本次要写入的「当前视觉位置」（由 move 预置）
# 为什么需要：线性音符的视觉位置有闭式公式（move_self 按 t 回退即可），
#   非线性音符（anim_power≠1）由 display_animation 逐缓动驱动、没有闭式反解，
#   所以只能「把过去若干刻的真实视觉位置存下来」，回退时直接取。
# 环的语义（每次 move_write_pair 调用后，@s 上恒满足）：
#   note_vis0 = 当前刻写入的视觉位置（= 上一刻视觉位置，与判定箱当前位置一致）
#   note_vis1 = 再往前 1 刻、note_vis2 = 再往前 2 刻 … note_vis4 = 再往前 4 刻
#   ⇒ 要「回退 L 刻」时取 note_vis<L>（L=1..4，见 judgement/st_lag_apply_nl）
# 首次调用（note_vis_ok 未置位）：5 个槽全填本次值（= 出生位置）。
#   必须初始化：未初始化的槽是 0 → 会被读成「世界原点」，短飞行音符会判歪。
# 调用点：move_write_pair 内，且只对走视线判定的音符盒/木板（混凝土走区域检测、玻璃走碰撞、唱片机走点击，都不需要）。

execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis1_x = #pvx play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis1_y = #pvy play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis1_z = #pvz play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis2_x = #pvx play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis2_y = #pvy play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis2_z = #pvz play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis3_x = #pvx play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis3_y = #pvy play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis3_z = #pvz play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis4_x = #pvx play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis4_y = #pvy play_state
execute unless score @s note_vis_ok matches 1 run scoreboard players operation @s note_vis4_z = #pvz play_state
scoreboard players set @s note_vis_ok 1

# 常规滑动：整体后移一位（旧的 vis4 丢弃），槽 0 写本次值
scoreboard players operation @s note_vis4_x = @s note_vis3_x
scoreboard players operation @s note_vis4_y = @s note_vis3_y
scoreboard players operation @s note_vis4_z = @s note_vis3_z
scoreboard players operation @s note_vis3_x = @s note_vis2_x
scoreboard players operation @s note_vis3_y = @s note_vis2_y
scoreboard players operation @s note_vis3_z = @s note_vis2_z
scoreboard players operation @s note_vis2_x = @s note_vis1_x
scoreboard players operation @s note_vis2_y = @s note_vis1_y
scoreboard players operation @s note_vis2_z = @s note_vis1_z
scoreboard players operation @s note_vis1_x = @s note_vis0_x
scoreboard players operation @s note_vis1_y = @s note_vis0_y
scoreboard players operation @s note_vis1_z = @s note_vis0_z
scoreboard players operation @s note_vis0_x = #pvx play_state
scoreboard players operation @s note_vis0_y = #pvy play_state
scoreboard players operation @s note_vis0_z = #pvz play_state
