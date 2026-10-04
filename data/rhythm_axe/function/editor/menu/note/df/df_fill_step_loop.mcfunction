#arg: cursor, src
# 设定间隔·循环：刻度 = 起点 + k × (S+1)
#   ★ 「间隔 N」= 两颗之间**空 N 刻** ⇒ 相邻间距 = N+1，第一颗 = 起点 + N + 1（先间隔再填，不贴着起点）
#   ★ 头尾一律不生成 ⇒ 只有 k ≥ 1 且 位置 < 终点 的刻度才生成
#     （k=0 就是起点本身；正好落在终点上的候选也跳过）
scoreboard players operation #dw_p editor = #fg_step editor
scoreboard players add #dw_p editor 1
scoreboard players operation #dw_p editor *= #fg_k editor
scoreboard players operation #dw_p editor += #fg_t0 editor
execute if score #fg_k editor matches 1.. if score #dw_p editor < #fg_lim editor run execute store result storage rhythm_axe:prop t int 1 run scoreboard players get #dw_p editor
execute if score #fg_k editor matches 1.. if score #dw_p editor < #fg_lim editor run function rhythm_axe:editor/menu/note/df/df_fill_put with storage rhythm_axe:prop
scoreboard players add #fg_k editor 1
execute if score #dw_p editor < #fg_lim editor if score #fg_k editor matches ..200 run function rhythm_axe:editor/menu/note/df/df_fill_step_loop with storage rhythm_axe:prop
