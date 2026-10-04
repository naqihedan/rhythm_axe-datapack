#arg: cursor, src
# 设定个数·循环：j 从 0 到 #fg_n（= N+1），刻度 = lerp(起, 止, j / (N+1))
#   ★ 头尾一律不生成 ⇒ 只有 1 ≤ j ≤ #fg_n-1 这些「头尾之间」的刻度才生成（正好 N 个 = 面板【个数】）
scoreboard players set #dw_c10k editor 10000
scoreboard players operation #dw_r editor = #fg_j editor
scoreboard players operation #dw_r editor *= #dw_c10k editor
scoreboard players operation #dw_r editor /= #fg_n editor
execute store result score #dw_a editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #dw_b editor run data get storage rhythm_axe:maps.editor editing.df.t_b
function rhythm_axe:editor/menu/note/df/df_lerp
execute if score #fg_j editor matches 1.. if score #fg_j editor < #fg_n editor run execute store result storage rhythm_axe:prop t int 1 run scoreboard players get #dw_p editor
execute if score #fg_j editor matches 1.. if score #fg_j editor < #fg_n editor run function rhythm_axe:editor/menu/note/df/df_fill_put with storage rhythm_axe:prop
scoreboard players add #fg_j editor 1
execute if score #fg_j editor <= #fg_n editor run function rhythm_axe:editor/menu/note/df/df_fill_cnt_loop with storage rhythm_axe:prop
