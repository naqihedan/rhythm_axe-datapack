# 清掉【编辑器音符实体】挂在自身 UUID 上的 editor_n_* 计分项
# 用法：`execute as <编辑器音符实体> run function rhythm_axe:editor/visual/note_scores_reset_`（靠 @s 定位）
#
# 为什么必须手动清：Java 版计分板项按“名字”持久存在，实体被 kill 后计分项【不会】随之移除。
#   编辑器视觉走的是「kill 全部 + 重建」：一次编辑（refresh）、一次跳转/快进、退出编辑器（exit_do）、
#   播放经过每个音符（tick_kill）、防幽灵副本（summon_ 的 $kill）都会 kill 实体，
#   每 kill 一个音符就留下这一整套（24 项）残留。
#   实测（2026-09-20 该存档）：残留累计 1 333 190 项 / scoreboard.dat 6.75MB / 解压后 104MB。
#   而世界保存要把整份分数板序列化进磁盘 → 每次自动保存（6000 刻）都卡一下：
#   位置不固定、隔几分钟一次、甚至不玩谱面也卡（尖峰几百 ms ~ 数秒），就是这份分数板在作祟。
#   本文件是「防复发」；已经堆积的残留由 utilization/clear_note_scores 的 reset * 一次性清掉。
#
# ★ 新增 editor_n_* objective 时，本文件与 utilization/clear_note_scores.mcfunction 必须同步（否则残留漏清）。
# ★ 调用时机不限（只动这些 UUID 的分数，不影响别的实体/玩家）。
scoreboard players reset @s editor_n_birth
scoreboard players reset @s editor_n_time
scoreboard players reset @s editor_n_end
scoreboard players reset @s editor_n_dist
scoreboard players reset @s editor_n_type
scoreboard players reset @s editor_n_dur
scoreboard players reset @s editor_n_density
scoreboard players reset @s editor_n_lt
scoreboard players reset @s editor_n_easing
scoreboard players reset @s editor_n_power
scoreboard players reset @s editor_n_len
scoreboard players reset @s editor_n_seg
scoreboard players reset @s editor_n_seg_count
scoreboard players reset @s editor_n_size
scoreboard players reset @s editor_n_idx
scoreboard players reset @s editor_n_protect
scoreboard players reset @s editor_n_rec_life
scoreboard players reset @s editor_n_hit
scoreboard players reset @s editor_n_c_last
scoreboard players reset @s editor_n_px
scoreboard players reset @s editor_n_py
scoreboard players reset @s editor_n_pz
scoreboard players reset @s editor_n_vx
scoreboard players reset @s editor_n_vy
scoreboard players reset @s editor_n_vz
scoreboard players reset @s editor_n_sx
scoreboard players reset @s editor_n_sy
scoreboard players reset @s editor_n_sz
scoreboard players reset @s editor_n_vvx
scoreboard players reset @s editor_n_vvy
scoreboard players reset @s editor_n_vvz
