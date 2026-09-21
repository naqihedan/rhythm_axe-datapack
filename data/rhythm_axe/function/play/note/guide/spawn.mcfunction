# 生成音符间引导线（连接前一个 0/1/2 音符与当前音符，osu 式引导线）
#arg: mapid, id, guide_prev, guide_tp, guide_n
# 调用前提（在 summon 里判定）：当前音符 following_point=true、类型 0/1/2、前一个 0/1/2 展示实体仍存活
# 宏上下文 = cur_note（含 mapid/id），前一个音符 id 已存入 cur_note.guide_prev（= #guide_last_id）
# 实体：item_display 青色染色玻璃，线宽 scale.x/y=0.15，长度 scale.z 由 tick 每刻按两音符中心距离更新
# ★ 移动方式（2026-08-14 重做；2026-09-21 改锚点）：顶层 Rotation 恒 0，顶层 Pos = **A 端判定位置**（不再是世界原点）；
#   中点写 transformation.translation（= 世界中点 − 锚点，见实体计分板 note_guide_px/py/pz）、朝向写 left_rotation、长度写 scale.z
#   （全在 transformation 内 → 平滑插值）；每刻 tick 算好全部值 → 一次性 data modify entity transformation set from storage（只 1 次 NBT 写入，性能优）
# ★ Pos 为什么不能留世界原点：展示实体只有落在【玩家附近】（客户端追踪范围内）才会收到更新，
#   **区块强加载并不能让它更新** → 原点上的引导线会停在旧位置/看不见。故 Pos 锚在线自己的 A 端。
# 生命周期：note_guide_a = 前一个音符 id、note_guide_b = 当前 id；
#   前一个音符存在时连接两个当前视觉位置；前一个音符消失后固定到其判定位置并继续收缩，
#   直到当前音符到达前一判定位置时长度为 0 完全消失；过程不依赖前一个音符是否已消失。
# view_range:10000：引导线是"空间引导"而非"交互目标"，需远离判定位置也能看到（音符展示实体同款）
execute store result score #guide_ax play_state run scoreboard players get @s note_base_x
execute store result score #guide_ay play_state run scoreboard players get @s note_base_y
execute store result score #guide_az play_state run scoreboard players get @s note_base_z
# ★ 2026-09-21：@s = A 端音符展示实体（Pos = A 判定位置，恒定）→ 引导线直接生成在 A 的判定位置（锚点）
#   初始 scale.z=0（不可见）：真正的几何由 guide/tick 每刻写入（首刻即到位）
$execute at @s run summon item_display ~ ~ ~ {item:{id:"minecraft:cyan_stained_glass",count:1},Tags:["note_guide","$(mapid)_guide$(id)","map_$(mapid)"],brightness:{block:15,sky:15},view_range:10000f,interpolation_duration:1,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.15f,0.15f,0f]}}
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_a $(guide_prev)
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_b $(id)
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players operation @s note_guide_x = #guide_ax play_state
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players operation @s note_guide_y = #guide_ay play_state
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players operation @s note_guide_z = #guide_az play_state
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_tp $(guide_tp)
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_n $(guide_n)
# ★ 锚点（2026-09-21）：读回实体真实 Pos（×100）存 note_guide_px/py/pz
#   → guide/tick_body 写 transformation.translation 时要减掉它（translation 是【相对 Pos】的偏移）
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run function rhythm_axe:utilization/guide_anchor_set
