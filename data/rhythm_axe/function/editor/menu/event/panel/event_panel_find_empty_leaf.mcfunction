#arg:fe_i
# 空指令查找叶子（宏）：只处理当前这一个元素，不递归。
# #fe_ex：1 = 元素存在 / 0 = 越界（遍历结束）
# #fe_len：该指令字符串长度（`data get` 对标量返回长度；非标量 store 失败 → 0，同样按空处理）
# 命中长度 0 → 覆盖 prop.empty_index（遍历到底时保留的就是**最后一条**空指令）
$execute store success score #fe_ex editor run execute store result score #fe_len editor run data get storage rhythm_axe:maps.editor editing.temp.commands[$(fe_i)]
execute if score #fe_ex editor matches 0 run scoreboard players set #fe_done editor 1
$execute if score #fe_ex editor matches 1 if score #fe_len editor matches ..0 run data modify storage rhythm_axe:prop empty_index set value $(fe_i)