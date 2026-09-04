# 播放中节拍器（advance_ 调用；@s=编辑者；#cur_time/#cur_tpb/#cur_bpb 为当前段）
# 每小节开头（含时间点本身）播"节"音，其余每拍起点播"拍"音
# 小节/拍相对当前段起点 #cur_time 计算：新时间点存在即新小节起点（红线/绿线均重置）
# ★ 与 mod 时间轴（TimelineGui 节奏染色）一致：模数取 Math.max(1,tpb/bpb)；取模用"非负余数"，
#   使播放头早于段起点（seek 回开头 / 首时间点 time>0 而 playhead 在其前）时 #m_rel 为负仍能正确判节/拍
scoreboard players operation #m_tpb editor = #cur_tpb editor
scoreboard players operation #m_bpb editor = #cur_bpb editor
execute if score #m_tpb editor matches ..0 run scoreboard players set #m_tpb editor 1
execute if score #m_bpb editor matches ..0 run scoreboard players set #m_bpb editor 1
scoreboard players operation #m_bar editor = #m_tpb editor
scoreboard players operation #m_bar editor *= #m_bpb editor
# 相对段首的刻数
scoreboard players operation #m_rel editor = #playhead editor
scoreboard players operation #m_rel editor -= #cur_time editor
# 小节判断：非负余数 #m_rel_bar == 0（rel 是 bar 的整数倍，含负数）
scoreboard players operation #m_rel_bar editor = #m_rel editor
scoreboard players operation #m_rel_bar editor %= #m_bar editor
scoreboard players operation #m_rel_bar editor += #m_bar editor
scoreboard players operation #m_rel_bar editor %= #m_bar editor
execute if score #m_rel_bar editor matches 0 at @s run \
    playsound minecraft:block.note_block.xylophone master @s ~ ~ ~ 1 1

# 拍判断：非负余数 #m_rel_beat == 0 且非小节
scoreboard players operation #m_rel_beat editor = #m_rel editor
scoreboard players operation #m_rel_beat editor %= #m_tpb editor
scoreboard players operation #m_rel_beat editor += #m_tpb editor
scoreboard players operation #m_rel_beat editor %= #m_tpb editor
execute if score #m_rel_bar editor matches 1.. if score #m_rel_beat editor matches 0 at @s run \
    playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 1