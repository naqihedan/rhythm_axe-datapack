# 判定延迟补偿 · 非线性音符分支（@s = 音符交互实体，tag=note_noteblock/note_plank，无 note_linear）
# 非线性音符（anim_power≠1）由 display_animation 逐缓动驱动，视觉位置没有闭式反解
#   ⇒ 回退只能取「真实历史」：位置环 note_vis<L>（由 active_note/vis_ring_next 每刻维护）
# 环的语义：note_vis0 = 当前刻视觉位置（= 判定箱当前位置）、note_vis1 = 再往前 1 刻 … note_vis4 = 再往前 4 刻
#   #st_lag = L ⇒ 目标 =「L 刻前」的视觉位置 = note_vis<L>
# 环没建起来（note_vis_ok 未置位，如刚出生还没跑过 move_write_pair）→ 不补偿（保持原位置）：
#   宁可不补，也不要读到未初始化的 0（会被当成世界原点）

execute unless score @s note_vis_ok matches 1 run return 0
execute if score #st_lag play_state matches 1 run scoreboard players operation #vx play_state = @s note_vis1_x
execute if score #st_lag play_state matches 1 run scoreboard players operation #vy play_state = @s note_vis1_y
execute if score #st_lag play_state matches 1 run scoreboard players operation #vz play_state = @s note_vis1_z
execute if score #st_lag play_state matches 2 run scoreboard players operation #vx play_state = @s note_vis2_x
execute if score #st_lag play_state matches 2 run scoreboard players operation #vy play_state = @s note_vis2_y
execute if score #st_lag play_state matches 2 run scoreboard players operation #vz play_state = @s note_vis2_z
execute if score #st_lag play_state matches 3 run scoreboard players operation #vx play_state = @s note_vis3_x
execute if score #st_lag play_state matches 3 run scoreboard players operation #vy play_state = @s note_vis3_y
execute if score #st_lag play_state matches 3 run scoreboard players operation #vz play_state = @s note_vis3_z
execute if score #st_lag play_state matches 4 run scoreboard players operation #vx play_state = @s note_vis4_x
execute if score #st_lag play_state matches 4 run scoreboard players operation #vy play_state = @s note_vis4_y
execute if score #st_lag play_state matches 4 run scoreboard players operation #vz play_state = @s note_vis4_z
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #vx play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #vy play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #vz play_state
tag @s add st_lag_moved
