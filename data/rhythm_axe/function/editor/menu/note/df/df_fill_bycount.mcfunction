#arg: cursor, src
# 设定个数模式：把 [起点, 终点] 等分成 (N+1) 段 → j=0..N+1 共 N+2 个刻度（含两端）
#   ★ 头尾一律不生成 ⇒ 只取 j=1..N 这 **N 个**刻度（面板【个数】= 头尾之间生成几个）
scoreboard players set #fg_n editor 1
execute store result score #fg_n editor run data get storage rhythm_axe:maps.editor editing.df.cnt
scoreboard players add #fg_n editor 1
scoreboard players set #fg_j editor 0
function rhythm_axe:editor/menu/note/df/df_fill_cnt_loop with storage rhythm_axe:prop
