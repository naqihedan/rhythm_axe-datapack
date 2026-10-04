#arg: cursor, cur, i2, kn2
# 算这一颗的**判定位置**：三轴各自 = 从 + (到−从) × ease(i2 / kn2)
#   口径是「音符颗数」（每颗都有自己的格子；同刻多颗会并排摆在不同位置）
$scoreboard players set #ez_n editor $(i2)
$scoreboard players set #ez_total editor $(kn2)
execute store result score #ez_power editor run data get storage rhythm_axe:maps.editor editing.df.s_pow
execute store result score #ez_type editor run data get storage rhythm_axe:maps.editor editing.df.s_ease
function rhythm_axe:editor/util/ease_power
execute store result score #dw_r editor run scoreboard players get #ez_ratio editor
# X
execute store result score #dw_a editor run data get storage rhythm_axe:maps.editor editing.df.s_a_fp[0]
execute store result score #dw_b editor run data get storage rhythm_axe:maps.editor editing.df.s_b_fp[0]
function rhythm_axe:editor/menu/note/df/df_lerp
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(cur)].position[0] double 0.01 run scoreboard players get #dw_p editor
# Y
execute store result score #dw_a editor run data get storage rhythm_axe:maps.editor editing.df.s_a_fp[1]
execute store result score #dw_b editor run data get storage rhythm_axe:maps.editor editing.df.s_b_fp[1]
function rhythm_axe:editor/menu/note/df/df_lerp
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(cur)].position[1] double 0.01 run scoreboard players get #dw_p editor
# Z
execute store result score #dw_a editor run data get storage rhythm_axe:maps.editor editing.df.s_a_fp[2]
execute store result score #dw_b editor run data get storage rhythm_axe:maps.editor editing.df.s_b_fp[2]
function rhythm_axe:editor/menu/note/df/df_lerp
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(cur)].position[2] double 0.01 run scoreboard players get #dw_p editor
