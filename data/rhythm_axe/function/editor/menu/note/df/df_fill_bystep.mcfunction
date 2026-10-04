#arg: cursor, src
# 设定间隔模式：候选 = 起点 + k×(S+1)（S = 空档刻数；k ≥ 1 且 < 终点），不含起点/终点本身
#   ★ 头尾一律不生成（详见 df_fill_step_loop）
execute store result score #fg_step editor run data get storage rhythm_axe:maps.editor editing.df.stp
execute store result score #fg_t0 editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #fg_lim editor run data get storage rhythm_axe:maps.editor editing.df.t_b
scoreboard players set #fg_k editor 0
scoreboard players operation #dw_p editor = #fg_t0 editor
function rhythm_axe:editor/menu/note/df/df_fill_step_loop with storage rhythm_axe:prop
