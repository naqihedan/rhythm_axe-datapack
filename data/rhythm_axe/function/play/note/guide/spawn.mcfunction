# 生成音符间引导线（连接前一个 0/1/2 音符与当前音符，osu 式引导线）
#arg: mapid, id, guide_prev, guide_tp, guide_n
# 调用前提（在 summon 里判定）：当前音符 following_point=true、类型 0/1/2、前一个 0/1/2 展示实体仍存活
# 宏上下文 = cur_note（含 mapid/id），前一个音符 id 已存入 cur_note.guide_prev（= #guide_last_id）
# 实体：item_display 青色染色玻璃，线宽 scale.x/y=0.15，长度 scale.z 由 tick 每刻按两音符中心距离更新
# ★ 移动方式（2026-08-14 重做）：顶层 Pos 恒 (0,0,0)、顶层 Rotation 恒 0（这两者不参与 display 插值）；
#   中点世界坐标写 transformation.translation、朝向写 left_rotation、长度写 scale.z（全在 transformation 内 → 平滑插值）
#   每刻 tick 算好全部值 → 一次性 data modify entity transformation set from storage（只 1 次 NBT 写入，性能优）
# 生命周期：note_guide_a = 前一个音符 id、note_guide_b = 当前 id；
#   前一个音符存在时连接两个当前视觉位置；前一个音符消失后固定到其判定位置并继续收缩，
#   直到当前音符到达前一判定位置时长度为 0 完全消失；过程不依赖前一个音符是否已消失。
# view_range:10000：引导线是"空间引导"而非"交互目标"，需远离判定位置也能看到（音符展示实体同款）
execute store result score #guide_ax play_state run scoreboard players get @s note_base_x
execute store result score #guide_ay play_state run scoreboard players get @s note_base_y
execute store result score #guide_az play_state run scoreboard players get @s note_base_z
$summon item_display 0.0 0.0 0.0 {item:{id:"minecraft:cyan_stained_glass",count:1},Tags:["note_guide","$(mapid)_guide$(id)","map_$(mapid)"],brightness:{block:15,sky:15},view_range:10000f,interpolation_duration:1,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.15f,0.15f,0.01f]}}
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_a $(guide_prev)
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_b $(id)
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players operation @s note_guide_x = #guide_ax play_state
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players operation @s note_guide_y = #guide_ay play_state
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players operation @s note_guide_z = #guide_az play_state
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_tp $(guide_tp)
$execute as @e[tag=$(mapid)_guide$(id),type=item_display,limit=1] run scoreboard players set @s note_guide_n $(guide_n)
