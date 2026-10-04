#arg: cursor
# 填充分布前的「参与集合」打标：给本次新生成（df_new）+ 站在起点/终点上的头尾音符打 df_dist_mark
#   ★ 只有它们参与随后的分布 ⇒ 原本选中的其他音符**完全不动**（判定时间、判定位置都不动）
#   ★ 头尾必须参与：它们是插值两端（i=0 / i=kn），这样新音符才落在「头尾之间等分」的位置
#     若只让新音符参与，插值会变成 0%..100% 铺满整段，而不是 1/(N+1)..N/(N+1)
#   ★ 端点音符「不存在」时（起点/终点上没有音符）就少一端，属于正常情况
scoreboard players set #dm_max editor 0
$execute store result score #dm_max editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
scoreboard players set #dm_ta editor 0
execute store result score #dm_ta editor run data get storage rhythm_axe:maps.editor editing.df.t_a
scoreboard players set #dm_tb editor 0
execute store result score #dm_tb editor run data get storage rhythm_axe:maps.editor editing.df.t_b
data modify storage rhythm_axe:prop dm_i set value 0
execute if score #dm_max editor matches 1.. run function rhythm_axe:editor/menu/note/df/df_fill_mark_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop dm_i
