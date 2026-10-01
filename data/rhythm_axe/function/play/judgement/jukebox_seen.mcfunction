# 唱片机判定保护记录（@s = 唱片机交互实体）
# 判定窗口内任一刻「视线与唱片机相交」→ 打 note_jb_seen（只记一次；末刻兜底 jukebox_late 依据它放 good_late）
# 机制同 look_check / st_probe：给本音符交互实体打临时标签 to_be_looked_at → 谓词命中 → 撤标签
#   （谓词 looking_at 靠 {Tags:[to_be_looked_at]} 选中"准星命中的实体"，一次只能给一个实体打标签）
# 距离基准 = 玩家视线位置：执行位置下移 1.62 格后，distance 等价于测「音符 → 玩家眼睛」
# ★ 唱片机不走 same_tick 的命中检测（点击天然单目标、不参与同刻配额），故这里自己扫谓词；
#   main_jukebox 只在判定窗口 [3x, -2x] 内、且本音符尚未记录时调用（记上后不再扫）
tag @s add to_be_looked_at
execute positioned ~ ~-1.62 ~ if entity @a[team=player,sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run tag @s add note_jb_seen
tag @s remove to_be_looked_at
