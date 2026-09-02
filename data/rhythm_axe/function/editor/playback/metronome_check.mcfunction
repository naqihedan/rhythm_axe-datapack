# 播放中节拍器（advance_ 调用；@s=编辑者；#cur_time/#cur_tpb/#cur_bpb 为当前段）
# 每小节开头（含时间点本身）播"节"音(pling)，其余每拍起点播"拍"音(hat)
# 小节/拍相对当前段起点 #cur_time 计算：新时间点存在即新小节起点（红线/绿线均重置）
scoreboard players operation #m_tpb editor = #cur_tpb editor
scoreboard players operation #m_bpb editor = #cur_bpb editor
scoreboard players operation #m_bar editor = #m_tpb editor
scoreboard players operation #m_bar editor *= #m_bpb editor
# 相对段首的刻数
scoreboard players operation #m_rel editor = #playhead editor
scoreboard players operation #m_rel editor -= #cur_time editor
# 小节判断：rel % bar == 0
scoreboard players operation #m_rel_bar editor = #m_rel editor
scoreboard players operation #m_rel_bar editor %= #m_bar editor
execute if score #m_rel_bar editor matches 0 at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.8 1.6
# 拍判断：rel % tpb == 0 且非小节
scoreboard players operation #m_rel_beat editor = #m_rel editor
scoreboard players operation #m_rel_beat editor %= #m_tpb editor
execute if score #m_rel_bar editor matches 1.. if score #m_rel_beat editor matches 0 at @s run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.8 1.2
