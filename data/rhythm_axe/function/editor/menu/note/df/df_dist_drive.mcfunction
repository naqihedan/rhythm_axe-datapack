# 逐音符分配驱动器：初始化序号 / 「上一刻」/ 移出表，然后宏叶子遍历 notes
# 前置：editing.df.k（时间单位数）、editing.df.k2（选中音符颗数）
#   prop.i  = 时间单位序号（prop.group 存在 ⇒ 同一刻共用）
#   prop.i2 = 音符序号（空间用，每颗 +1）
#   prop.kn / kn2 = 对应总数 −1（缓动 total）
scoreboard players set #dd_i editor -1
scoreboard players set #dd_i2 editor 0
scoreboard players set #dd_prev_t editor -1
# 严格递增模式（拆分同一刻=启用）用的「上一颗的时间」必须清零：
#   否则会沿用上一批的残值，把这一批的首颗顶到「残值+1」（实测过：首颗被顶到 6041 而不是 6000）
scoreboard players set #dw_prev editor -2147483648
data remove storage rhythm_axe:prop move_idx
data remove storage rhythm_axe:prop move_out
execute store result score #dd_kn editor run data get storage rhythm_axe:maps.editor editing.df.k
scoreboard players remove #dd_kn editor 1
execute if score #dd_kn editor matches ..-1 run scoreboard players set #dd_kn editor 0
execute store result storage rhythm_axe:prop kn int 1 run scoreboard players get #dd_kn editor
execute store result score #dd_kn2 editor run data get storage rhythm_axe:maps.editor editing.df.k2
scoreboard players remove #dd_kn2 editor 1
execute if score #dd_kn2 editor matches ..-1 run scoreboard players set #dd_kn2 editor 0
execute store result storage rhythm_axe:prop kn2 int 1 run scoreboard players get #dd_kn2 editor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# 命中判据（宏注入进 NBT 路径片段）：默认 selected；填充分布先设 prop.dist_fill ⇒ 改判 df_dist_mark
data modify storage rhythm_axe:prop mark set value "selected"
execute if data storage rhythm_axe:prop dist_fill run data modify storage rhythm_axe:prop mark set value "df_dist_mark"
data modify storage rhythm_axe:prop idx set value 0
function rhythm_axe:editor/menu/note/df/df_dist_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop mark
data remove storage rhythm_axe:prop cur
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop i2
data remove storage rhythm_axe:prop kn
data remove storage rhythm_axe:prop kn2
