# 判定延迟补偿 · 还原被临时回退过的判定箱（@s = 交互实体，tag=st_lag_moved）
# 由 st_player 在**每位玩家退场前**调用（不能只在整段末尾：@a 遍历顺序任意，
#   无补偿的房主若排在客机后面，就会拿客机回退过的位置去测）。
# 线性：move_self 按公式重算（此刻 #lag_extra 恒 0 = 当前刻视觉位置）
# 非线性：直接写回位置环的「当前」槽 note_vis0

execute if entity @s[tag=note_linear] run function rhythm_axe:play/active_note/move_self
execute unless entity @s[tag=note_linear] run scoreboard players operation #vx play_state = @s note_vis0_x
execute unless entity @s[tag=note_linear] run scoreboard players operation #vy play_state = @s note_vis0_y
execute unless entity @s[tag=note_linear] run scoreboard players operation #vz play_state = @s note_vis0_z
execute unless entity @s[tag=note_linear] run execute store result entity @s Pos[0] double 0.01 run scoreboard players get #vx play_state
execute unless entity @s[tag=note_linear] run execute store result entity @s Pos[1] double 0.01 run scoreboard players get #vy play_state
execute unless entity @s[tag=note_linear] run execute store result entity @s Pos[2] double 0.01 run scoreboard players get #vz play_state
