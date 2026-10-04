#arg: cursor
# 填充收尾：处理「填充后选中头尾+新音符」+ 清 df_new 标记
#   dfsel = 0（关闭）：新音符取消选中，**选区操作前后完全不变**
#   dfsel = 1（开启，默认）：**丢弃原选区**，重建为「新生成的音符 + 头/尾音符」
#     ★ 头/尾音符 = 站在「起点 / 终点」那两颗。端点候选因判重不会重复生成，所以它们就是原本那两颗 ⇒
#       「起止选的是已有音符」时，选区 = 那两颗 + 中间新生成的，正好把这一整段框住。
# 正序遍历（本函数只改标记、不改数组，下标稳定）；selection 按 notes 顺序 append ⇒ 天然升序
scoreboard players set #ff_max editor 0
$execute store result score #ff_max editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
execute store result score #ff_sel editor run data get storage rhythm_axe:maps.editor editing.df.dfsel
execute store result score #ff_ta editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #ff_tb editor run data get storage rhythm_axe:maps.editor editing.df.t_b
execute if score #ff_sel editor matches 1 run data remove storage rhythm_axe:maps.editor selection
data remove storage rhythm_axe:prop ff_i
data modify storage rhythm_axe:prop ff_i set value 0
execute if score #ff_max editor matches 1.. run function rhythm_axe:editor/menu/note/df/df_fill_flag_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop ff_i
