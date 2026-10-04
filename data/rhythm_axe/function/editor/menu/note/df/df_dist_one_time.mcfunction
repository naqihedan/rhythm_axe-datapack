#arg: cursor, cur, i, kn
# 算这一颗的**新时间**：t = 起 + (止−起) × ease(i / kn)（i / kn 都是「时间单位」口径）
#   prop.strict 存在 ⇒ 保证本批严格递增（= 「拆分同一刻内的音符」启用；#dw_prev 由 df_dist_drive 初始化）
#   prop.strict 不存在 ⇒ 同一刻的成员各自算各自的，允许落在同一刻（桶整体搬走）
$scoreboard players set #ez_n editor $(i)
$scoreboard players set #ez_total editor $(kn)
execute store result score #ez_power editor run data get storage rhythm_axe:maps.editor editing.df.t_pow
execute store result score #ez_type editor run data get storage rhythm_axe:maps.editor editing.df.t_ease
function rhythm_axe:editor/util/ease_power
execute store result score #dw_r editor run scoreboard players get #ez_ratio editor
execute store result score #dw_a editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #dw_b editor run data get storage rhythm_axe:maps.editor editing.df.t_b
function rhythm_axe:editor/menu/note/df/df_lerp
execute if data storage rhythm_axe:prop strict if score #dw_p editor <= #dw_prev editor run scoreboard players operation #dw_p editor = #dw_prev editor
execute if data storage rhythm_axe:prop strict if score #dw_p editor <= #dw_prev editor run scoreboard players add #dw_p editor 1
execute if data storage rhythm_axe:prop strict run scoreboard players operation #dw_prev editor = #dw_p editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(cur)].time int 1 run scoreboard players get #dw_p editor
