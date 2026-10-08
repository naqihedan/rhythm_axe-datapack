# title1776 驱动器（每刻自调度）：按每个实体自己的 t1776_t 推进 —— 实例之间互不影响
# 时间轴（相对触发器）：t=2 / t=6 两段旋转（各 4 刻）；t=10 平移收尾；t≥35 → 清计时并删除实体
# ★ title 与 background 分开下发：background 每个关键帧的平移 Y 都比 title 低 0.0625（相对偏移全程不变）
# ★ 平移全程 32 刻匀速（两实体同速）：每段 merge 都把平移推到「该时刻应到的位置」（4/32 → 8/32 → 走完）
# ★ background 的 z 间距（0.04）只在旋转段（t<10）用：t=10（= 你说的第 8 刻）用 Pos 撤回 0.01，8-32 段不再施加
#   （display 的可插值字段共享一条时间线 ⇒ 旋转和平移没法各用各的时长；拆成几段同速下发即可）

# ★ 连发：每 8 刻生成一对，共 16 对（第 0/8/…/120 刻），到第 128 刻收工
# 计时推进（动画跑完后不再增长）
scoreboard players add @e[tag=t1776,scores={t1776_t=..35}] t1776_t 1

# 第 1 段（t=2）：旋转 K1 → [0,0.9238795,-0.38268346,0]，4 刻；平移同步起步到 4/32
execute as @e[tag=title,scores={t1776_t=2}] run data merge entity @s {transformation:{left_rotation:[0.0f,0.9238795f,-0.38268346f,0.0f],translation:[0.0f,-0.1875f,0.0f]},interpolation_duration:4,start_interpolation:0}
execute as @e[tag=background,scores={t1776_t=2}] run data merge entity @s {transformation:{left_rotation:[0.0f,0.9238795f,-0.38268346f,0.0f],translation:[0.0f,-0.25f,0.0f]},interpolation_duration:4,start_interpolation:0}

# 第 2 段（t=6）：旋转 → [0,1,0,0]（绕 Y 轴 180°），再 4 刻；平移同步到 8/32
execute as @e[tag=title,scores={t1776_t=6}] run data merge entity @s {transformation:{left_rotation:[0.0f,1.0f,0.0f,0.0f],translation:[0.0f,-0.375f,0.0f]},interpolation_duration:4,start_interpolation:0}
execute as @e[tag=background,scores={t1776_t=6}] run data merge entity @s {transformation:{left_rotation:[0.0f,1.0f,0.0f,0.0f],translation:[0.0f,-0.4375f,0.0f]},interpolation_duration:4,start_interpolation:0}

# 第 3 段（t=10）：旋转已完成，平移按同一速度走完剩下 24 刻（8 + 24 = 32）
execute as @e[tag=title,scores={t1776_t=10}] run data merge entity @s {transformation:{translation:[0.0f,-1.5f,0.0f]},interpolation_duration:24,start_interpolation:0}
execute as @e[tag=background,scores={t1776_t=10}] run data merge entity @s {transformation:{translation:[0.0f,-1.5625f,0.0f]},interpolation_duration:24,start_interpolation:0}

# 旋转段结束（t=10）：撤掉 background 的 z 间距，恢复到原来的 0.01 —— 用 Pos 直接改（不经插值）⇒ 精确在这一刻消失
# 这个间距只用来防「倾斜时两层共面 → z-fighting → 白板盖住字」，正对之后的 8-32 段不需要它
execute if entity @e[tag=background,scores={t1776_t=10}] run scoreboard players set #t1776_z t1776_t 500
execute as @e[tag=background,scores={t1776_t=10}] run execute store result entity @s Pos[2] double 0.001 run scoreboard players get #t1776_z t1776_t

# 动画跑完 → 打标记 → 清计时 → 删实体
#（计分项不会随实体消失而自动清除，所以要先 reset 再 kill；标记用 tag 避免 reset 后选不中）
execute as @e[tag=t1776,scores={t1776_t=35..}] run tag @s add t1776_done
execute as @e[tag=t1776_done] run scoreboard players reset @s t1776_t
kill @e[tag=t1776_done]

# 连发段：每 8 刻生成一对（第 8/16/…/120 刻），到第 128 刻为止 ⇒ 连开关那一次共 16 对
#   要调次数/间隔：只改下面两个数（窗口 ..128 / 上限 1..127 / 间隔 8）；例如 8 对就是 ..64 与 1..63
scoreboard players set #t1776_int t1776_t 8
execute if score #t1776_wave t1776_t matches ..128 run scoreboard players add #t1776_wave t1776_t 1
scoreboard players operation #t1776_mod t1776_t = #t1776_wave t1776_t
scoreboard players operation #t1776_mod t1776_t %= #t1776_int t1776_t
execute if score #t1776_mod t1776_t matches 0 if score #t1776_wave t1776_t matches 1..127 run function rhythm_axe:maps/goodworld/title1776summon

# 继续条件：还有实例在动画中，或连发段（≤128 刻）没走完 → 再跑一刻；否则停链并清开关
#   （只 schedule 一次，不能分两条写，否则同一刻会排出两条计时链）
scoreboard players set #t1776_go t1776_t 0
execute if entity @e[tag=t1776,scores={t1776_t=..34}] run scoreboard players set #t1776_go t1776_t 1
execute if score #t1776_wave t1776_t matches ..127 run scoreboard players set #t1776_go t1776_t 1
execute if score #t1776_go t1776_t matches 1 run schedule function rhythm_axe:maps/goodworld/title1776_tick 1t

# ★ 全部收工（最后一个实体已清除、连发也走完）→ 删掉本套计分项：
#   连带清掉所有实例计时与临时假玩家分数 ⇒ 事件结束后不留任何东西（下次开关会重新 add，无副作用）
execute if score #t1776_go t1776_t matches 0 run scoreboard objectives remove t1776_t
