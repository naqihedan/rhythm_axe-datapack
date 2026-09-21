# 混凝土每 tick（active_note 调用）
# @s = 混凝土展示实体
# ★ 2026-09-15「一条曲线」模型：头端/尾端沿同一条轨迹各走一次缓动（尾端 = 头端延后 m 刻）
#   三段视觉（拉伸 / 平移或静止 / 收缩）是它的自然结果，不再分段各自套缓动。
#   两套实现数值一致：
#     · 线性（power=1，默认）：客户端插值（seg1_client → seg1_merge → seg2_client → seg3_client）
#       —— 本文件只负责「段推进阈值 + 头端进度」，不写 NBT
#     · 非线性（power≠1）：本文件每刻调 concrete/drive 直接写 NBT（drive 同时写好 #hp）
# 头端进度 hp（0..lt，单位刻）：头端偏移 = dir×hp/lt（混凝土判定走展示实体自身 Pos 的判定区域，不依赖交互实体位置）

# ---- 进度 t = lt - l + 2（渲染延迟 2 刻）----
scoreboard players operation #cl play_state = @s note_life
scoreboard players operation #ct display_calc = @s note_c_lt
scoreboard players operation #ct display_calc -= #cl play_state
scoreboard players operation #ct display_calc += 2 const

# ---- 非线性：每刻直接驱动（写 NBT + 写 #hp）----
execute unless score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/drive

# ---- 线性：段推进（客户端插值；阈值 = 模型时间 + 2 刻渲染延迟）----
# 长 hold 段①→段②（t ≥ lt：进入中间静止段）
execute if score @s note_c_power matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_seg matches 1 if score #ct display_calc >= @s note_c_lt unless score @s anim_status matches 1 run scoreboard players set @s note_c_seg 2
# 短 hold 段①→段② 阈值 = seg1_s + seg1_dur（= m+2）：触发时快照正好落在段①轨迹上 → 头端无缝继续
scoreboard players operation #seg2_trig display_calc = @s note_c_seg1_s
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #seg2_trig display_calc += @s note_c_seg1_dur
execute if score @s note_c_power matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_seg matches 1 if score @s note_c_seg1_s matches 1.. if score #ct display_calc >= #seg2_trig display_calc unless score @s anim_status matches 1 run function rhythm_axe:play/note/concrete/seg2_client
# 长 hold 段②→段③（t ≥ m：尾端开始收缩）
execute if score @s note_c_power matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_seg matches 2 if score #ct display_calc >= @s note_c_m unless score @s anim_status matches 1 run function rhythm_axe:play/note/concrete/seg3_client
# 短 hold 段②→段③ 阈值 = lt+2（推迟到快照落在段②轨迹上，尾端无缝继续）
scoreboard players operation #seg3_trig display_calc = @s note_c_lt
scoreboard players operation #seg3_trig display_calc += 2 const
execute if score @s note_c_power matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_seg matches 2 if score #ct display_calc >= #seg3_trig display_calc unless score @s anim_status matches 1 run function rhythm_axe:play/note/concrete/seg3_client
# 段①客户端插值：pending 后每 tick 计数 +1，>=2 才 merge 段①终点（出生→merge 隔 2-tick：#ct 2→4，seg1_s=4）
execute if entity @s[tag=note_concrete_seg1_pending] if score @s note_c_seg1_ticks matches 2.. run function rhythm_axe:play/note/concrete/seg1_merge
execute if entity @s[tag=note_concrete_seg1_pending] if score @s note_c_seg1_ticks matches ..1 run scoreboard players add @s note_c_seg1_ticks 1

# 【调试】段推进/NBT 实测（/scoreboard players set debug_output options 2）
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][混凝土]","color":"aqua"},{"text":" seg=","color":"gray"},{"score":{"objective":"note_c_seg","name":"@s"}},{"text":" pow=","color":"gray"},{"score":{"objective":"note_c_power","name":"@s"}},{"text":" ct=","color":"gray"},{"score":{"objective":"display_calc","name":"#ct"}},{"text":" hp=","color":"gray"},{"score":{"objective":"display_calc","name":"#hp"}},{"text":" tz=","color":"gray"},{"nbt":"transformation.translation[2]","entity":"@s"},{"text":" sz=","color":"gray"},{"nbt":"transformation.scale[2]","entity":"@s"}]

# ---- 头端进度 hp（0..lt，单位刻）----
# · 非线性：drive 每刻已按 E(u_h) 写好 #hp（与展示同刻）
# · 线性：客户端插值比模型晚 2 刻 → hp = clamp(#ct - 2, 0, lt)
execute if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #ct display_calc
execute if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc -= 2 const
execute if score @s note_c_power matches 1 if score #hp display_calc matches ..0 run scoreboard players set #hp display_calc 0
execute if score @s note_c_power matches 1 if score #hp display_calc > @s note_c_lt run scoreboard players operation #hp display_calc = @s note_c_lt

# ---- 交互实体跟随头端（= 展示头端）----
# 头端偏移 = dir×hp/lt（dir = -start = note_c_sx/sy/sz 取反；C4：除以 lt 不除以 dist）
scoreboard players operation #ihx display_calc = @s note_c_sx
scoreboard players operation #ihx display_calc *= -1 const
scoreboard players operation #ihx display_calc *= #hp display_calc
scoreboard players operation #ihx display_calc /= @s note_c_lt
scoreboard players operation #ihy display_calc = @s note_c_sy
scoreboard players operation #ihy display_calc *= -1 const
scoreboard players operation #ihy display_calc *= #hp display_calc
scoreboard players operation #ihy display_calc /= @s note_c_lt
scoreboard players operation #ihz display_calc = @s note_c_sz
scoreboard players operation #ihz display_calc *= -1 const
scoreboard players operation #ihz display_calc *= #hp display_calc
scoreboard players operation #ihz display_calc /= @s note_c_lt
# 头端世界坐标（×100）
# ★ 性能优化（2026-09-04）：展示实体 Pos 固定 = 判定位置（summon 已快照到 note_base_*），用计分板替代 Pos 读
scoreboard players operation #icx play_state = @s note_base_x
scoreboard players operation #icx play_state += @s note_c_sx
scoreboard players operation #icx play_state += #ihx display_calc
scoreboard players operation #icy play_state = @s note_base_y
scoreboard players operation #icy play_state += @s note_c_sy
scoreboard players operation #icy play_state += #ihy display_calc
scoreboard players operation #icys display_calc = @s note_c_size
scoreboard players operation #icys display_calc /= 2 const
scoreboard players operation #icy play_state -= #icys display_calc
scoreboard players operation #icz play_state = @s note_base_z
scoreboard players operation #icz play_state += @s note_c_sz
scoreboard players operation #icz play_state += #ihz display_calc
# 配对写入交互实体（1 次扫描：#icx/#icy/#icz 经 #pv* 交给 move_write_pair）
scoreboard players operation #nid play_state = @s note_id
scoreboard players operation #pvx play_state = #icx play_state
scoreboard players operation #pvy play_state = #icy play_state
scoreboard players operation #pvz play_state = #icz play_state
execute as @e[type=interaction,tag=note_interaction] if score @s note_id = #nid play_state run function rhythm_axe:play/active_note/move_write_pair

# 调试（lv.2）：展示 vs 交互到位时序
execute store result score #disp_tz display_calc run data get entity @s transformation.translation[2] 100
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][混凝土]","color":"aqua"},{"text":" l=","color":"gray"},{"score":{"objective":"play_state","name":"#cl"}},{"text":" hp=","color":"gray"},{"score":{"objective":"display_calc","name":"#hp"}},{"text":" dispTZ=","color":"gray"},{"score":{"objective":"display_calc","name":"#disp_tz"}},{"text":" 交互Z=","color":"gold"},{"score":{"objective":"play_state","name":"#icz"}}]
