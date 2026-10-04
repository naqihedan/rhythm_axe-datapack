# 统计「参与分布」的音符（分布 / 填充分布都用它算插值 total）：
#   参与判据由 prop.mark 决定：普通分布 = selected；填充分布 = df_dist_mark（新生成 + 头尾）
#   editing.df.k  = **时间单位数**（prop.group 存在 ⇒ 同一刻的成员算一个单位，对应「拆分同一刻」关闭）
#   editing.df.k2 = **选中音符颗数**（空间分布按每颗自身序号插值）
scoreboard players set #dc_n editor 0
scoreboard players set #dc_n2 editor 0
scoreboard players set #dc_prev_t editor -1
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# 命中判据（宏注入进 NBT 路径片段）：默认 selected；填充分布先设 prop.dist_fill ⇒ 改判 df_dist_mark
data modify storage rhythm_axe:prop mark set value "selected"
execute if data storage rhythm_axe:prop dist_fill run data modify storage rhythm_axe:prop mark set value "df_dist_mark"
data modify storage rhythm_axe:prop idx set value 0
function rhythm_axe:editor/menu/note/df/df_dist_count_leaf with storage rhythm_axe:prop
execute store result storage rhythm_axe:maps.editor editing.df.k int 1 run scoreboard players get #dc_n editor
execute store result storage rhythm_axe:maps.editor editing.df.k2 int 1 run scoreboard players get #dc_n2 editor
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop mark
