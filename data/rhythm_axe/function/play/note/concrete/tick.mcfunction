# 混凝土每 tick（active_note 调用；替代 concrete_move 的视觉逐帧驱动）
# @s = 混凝土展示实体
# 1. 段推进：t 到 m → 段②；t 到 lt → 段③（等当前段动画完成，anim_status 无才启动下一段）
# 2. 交互实体跟随头端（C3：上一刻头端 note_prev_cx/cy/cz 解耦；C4：头端 = 出生 + dir×hp/lt）
# 视觉由 display_animation 驱动（段①/②/③），这里不再写 translation/scale
# ★ hp 用线性近似（服务器独立算）：视觉是 easing，交互是线性——混凝土判定用 marker 区域，
#   不依赖交互实体位置，故近似可接受（交互仅位置跟随视觉辅助）

# ---- 进度 t = lt - l + 2（C1：渲染延迟 2 刻）----
scoreboard players operation #cl play_state = @s note_life
scoreboard players operation #ct display_calc = @s note_c_lt
scoreboard players operation #ct display_calc -= #cl play_state
scoreboard players operation #ct display_calc += 2 const

# ---- 段推进（★ 按模型分流 2026-08-09；当前段动画完成后启动下一段）----
# 段①时长/段②结束点：短 hold（m<=lt）= m / lt；长 hold（m>lt）= lt / m
# 短 hold 段①→段② = seg2（平移）；长 hold 段①→段② = 仅切 seg2（中间静止，不写 NBT）
execute if score @s note_c_m > @s note_c_lt if score @s note_c_seg matches 1 if score #ct display_calc >= @s note_c_lt unless score @s anim_status matches 1 run scoreboard players set @s note_c_seg 2
# 段②触发阈值（★ 2026-08-14：= seg1_s + seg1_dur，去掉 +1）
#   段①现以模型速度完成；此刻触发时，段②更新经 1 刻处理延迟到达，快照正好落在段①轨迹上（87.5%）
#   → 头端无缝继续、无停顿无跳变（旧 +1 导致段①完成后停顿 + 速度突变）
scoreboard players operation #seg2_trig display_calc = @s note_c_seg1_s
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #seg2_trig display_calc += @s note_c_seg1_dur
# 短 hold 段①→段②（★ 2026-08-09 分流）：线性（幂次 1）→ 客户端插值（seg2_client 单阶段）；非线性 → display_animation（seg2）
execute if score @s note_c_m <= @s note_c_lt if score @s note_c_seg matches 1 if score @s note_c_seg1_s matches 1.. if score #ct display_calc >= #seg2_trig display_calc unless score @s anim_status matches 1 if score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg2_client
execute if score @s note_c_m <= @s note_c_lt if score @s note_c_seg matches 1 if score #ct display_calc >= @s note_c_m unless score @s anim_status matches 1 unless score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg2
# 段②→段③（★ 2026-08-09/14 分流）：线性（幂次 1）→ 客户端插值（seg3_client 单阶段：参数+终点同刻）；非线性 → display_animation（seg3）
# 长 hold 段②→段③（t>=m）
execute if score @s note_c_m > @s note_c_lt if score @s note_c_seg matches 2 if score #ct display_calc >= @s note_c_m unless score @s anim_status matches 1 if score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg3_client
execute if score @s note_c_m > @s note_c_lt if score @s note_c_seg matches 2 if score #ct display_calc >= @s note_c_m unless score @s anim_status matches 1 unless score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg3
# 短 hold 段②→段③（★ 2026-08-14 修订：阈值 = lt+2）
#   旧 #ct>lt（=17）触发过早，快照切掉段②太多尾巴 → 尾部瞬移/停滞（两次卡顿之二）；
#   推迟到 #ct≥18（=lt+2）触发：快照落在段②轨迹上（尾端无缝继续），
#   段③ 8 刻收缩后尾端恰好在寿命 -duration 时到判定位置
scoreboard players operation #seg3_trig display_calc = @s note_c_lt
scoreboard players operation #seg3_trig display_calc += 2 const
execute if score @s note_c_m <= @s note_c_lt if score @s note_c_seg matches 2 if score #ct display_calc >= #seg3_trig display_calc unless score @s anim_status matches 1 if score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg3_client
execute if score @s note_c_m <= @s note_c_lt if score @s note_c_seg matches 2 if score #ct display_calc >= #seg3_trig display_calc unless score @s anim_status matches 1 unless score @s note_c_power matches 1 run function rhythm_axe:play/note/concrete/seg3
# 段①客户端插值（两阶段延迟，2026-08-10）：armed+active=1 → promote；pending+active=1 → merge 段①终点
#   （summon 在 active_note 之前 → 出生同 tick active 已翻 1 → 用 armed→pending 再延迟一 tick，保证参数与终点分 tick）
execute if entity @s[tag=note_concrete_seg1_armed] if score @s note_active matches 1 run function rhythm_axe:play/note/concrete/seg1_promote
execute if entity @s[tag=note_concrete_seg1_pending] if score @s note_active matches 1 run function rhythm_axe:play/note/concrete/seg1_merge
# 段③客户端插值（★ 2026-08-14 起单阶段：seg3_client 一次下发 参数+终点；旧三阶段已弃用）
#   （旧：armed+active=1 → seg3_param；pending+active=1 → seg3_merge——有 2 tick 空窗+瞬切跳变，不再调用）
# execute if entity @s[tag=note_concrete_seg3_armed] if score @s note_active matches 1 run function rhythm_axe:play/note/concrete/seg3_param
# execute if entity @s[tag=note_concrete_seg3_pending] if score @s note_active matches 1 run function rhythm_axe:play/note/concrete/seg3_merge

# 【调试 2026-08-09】短 hold 段推进/NBT 实测（note_id 12-15；/scoreboard players set debug_output options 2）
execute if score debug_output options matches 2.. if score @s note_id matches 12..15 run tellraw @a ["",{"text":"[调试.lv2][短hold]","color":"gray"},{"text":" seg=","color":"gray"},{"score":{"objective":"note_c_seg","name":"@s"}},{"text":" as=","color":"gray"},{"score":{"objective":"anim_status","name":"@s"}},{"text":" ct=","color":"gray"},{"score":{"objective":"display_calc","name":"#ct"}},{"text":" tz=","color":"gray"},{"nbt":"transformation.translation[2]","entity":"@s"},{"text":" sz=","color":"gray"},{"nbt":"transformation.scale[2]","entity":"@s"}]

# ---- 交互实体跟随头端（= 展示缓动头部，2026-08-08 修复）----
# 头进度 hp = 复刻 display_animation 的 easing 进度（与展示视觉头部同步）
#   ★ 展示用 display_animation（easing 缓动：缓出前期快 → 头部在 timer 接近 duration 时早就位）
#     之前交互用线性（hp=lt-l）到位 l=0，比展示头部（缓出，~l=4 到位）晚 ~m 刻（用户实测晚 4 刻）
#     修复：读 @s anim_timer/anim_duration/anim_easing/anim_power 复刻 easing，hp 跟随展示
#   段①：hp = ratio×m/10000（头端 0 → m 进度）
#   段②：hp = m + ratio×(lt-m)/10000（头端 m → lt 到位）
#   段③：hp = lt（头端保持到位）
scoreboard players operation #n display_calc = @s anim_timer
scoreboard players operation #total display_calc = @s anim_duration
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
scoreboard players operation #power display_calc = @s anim_power
scoreboard players operation #easing_type display_calc = @s anim_easing
function rhythm_axe:utilization/display_animation/easing/power
# 段① hp（★ 2026-08-10 分流）：线性（客户端插值，anim_status=0 不能复刻 anim_timer）→ 用 seg1_s 推算；非线性 → anim_timer 复刻 ratio
#   线性 progress = clamp((#ct - seg1_s)/时长, 0, 1)；hp = progress × 时长（短=m、长=lt）
# 短 hold 线性
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #ct display_calc
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc -= @s note_c_seg1_s
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= 10000 const
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= @s note_c_seg1_dur
execute if score #hp display_calc > 10000 const run scoreboard players set #hp display_calc 10000
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= @s note_c_m
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= 10000 const
# 长 hold 线性
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #ct display_calc
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc -= @s note_c_seg1_s
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= 10000 const
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= @s note_c_seg1_dur
execute if score #hp display_calc > 10000 const run scoreboard players set #hp display_calc 10000
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= @s note_c_lt
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= 10000 const
# 非线性（display_animation，anim_timer 复刻 ratio）
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #ratio display_calc
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= @s note_c_m
execute if score @s note_c_seg matches 1 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= 10000 const
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #ratio display_calc
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= @s note_c_lt
execute if score @s note_c_seg matches 1 if score @s note_c_m > @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= 10000 const
# 段② hp：长= lt（静止头已到位）；短 hold 线性（客户端插值，anim_status=0 不能复刻 anim_timer）→ 用 seg2_s 推算；短 hold 非线性 → anim_timer 复刻
#   progress = clamp((#ct - seg2_s)/(lt-m), 0, 1)；hp = m + progress×(lt-m)
execute if score @s note_c_seg matches 2 if score @s note_c_m > @s note_c_lt run scoreboard players operation #hp display_calc = @s note_c_lt
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #ct display_calc
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc -= @s note_c_seg2_s
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc *= 10000 const
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #tmp2 display_calc = @s note_c_lt
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #tmp2 display_calc -= @s note_c_m
execute if score #tmp2 display_calc matches ..0 run scoreboard players set #tmp2 display_calc 1
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc /= #tmp2 display_calc
execute if score #hp display_calc > 10000 const run scoreboard players set #hp display_calc 10000
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #tmp2 display_calc = @s note_c_lt
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #tmp2 display_calc -= @s note_c_m
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #tmp2 display_calc *= #hp display_calc
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #tmp2 display_calc /= 10000 const
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = @s note_c_m
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt if score @s note_c_power matches 1 run scoreboard players operation #hp display_calc += #tmp2 display_calc
# 短 hold 非线性（display_animation seg2，anim_timer 复刻 ratio）
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #tmp display_calc = @s note_c_lt
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #tmp display_calc -= @s note_c_m
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #tmp display_calc *= #ratio display_calc
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #tmp display_calc /= 10000 const
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc = #tmp display_calc
execute if score @s note_c_seg matches 2 if score @s note_c_m <= @s note_c_lt unless score @s note_c_power matches 1 run scoreboard players operation #hp display_calc += @s note_c_m
# 段③：hp = lt（头端保持到位，两种模型同）
execute if score @s note_c_seg matches 3 run scoreboard players operation #hp display_calc = @s note_c_lt
# hp 封顶 lt（防 easing 数值误差）
execute if score #hp display_calc > @s note_c_lt run scoreboard players operation #hp display_calc = @s note_c_lt
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
execute store result score #icx play_state run data get entity @s Pos[0] 100
scoreboard players operation #icx play_state += @s note_c_sx
scoreboard players operation #icx play_state += #ihx display_calc
execute store result score #icy play_state run data get entity @s Pos[1] 100
scoreboard players operation #icy play_state += @s note_c_sy
scoreboard players operation #icy play_state += #ihy display_calc
scoreboard players operation #icys display_calc = @s note_c_size
scoreboard players operation #icys display_calc /= 2 const
scoreboard players operation #icy play_state -= #icys display_calc
execute store result score #icz play_state run data get entity @s Pos[2] 100
scoreboard players operation #icz play_state += @s note_c_sz
scoreboard players operation #icz play_state += #ihz display_calc
# ★ 混凝土：交互实体往出生方向回退 size/2（对准长条身体而非头端，避免只包住 50%；方向 = note_c_s/note_c_dist）
execute if score @s note_c_dist matches 1.. run scoreboard players operation #bo display_calc = @s note_c_size
execute if score @s note_c_dist matches 1.. run scoreboard players operation #bo display_calc /= 2 const
execute if score @s note_c_dist matches 1.. run scoreboard players operation #box display_calc = #bo display_calc
execute if score @s note_c_dist matches 1.. run scoreboard players operation #box display_calc *= @s note_c_sx
execute if score @s note_c_dist matches 1.. run scoreboard players operation #box display_calc /= @s note_c_dist
execute if score @s note_c_dist matches 1.. run scoreboard players operation #icx play_state += #box display_calc
execute if score @s note_c_dist matches 1.. run scoreboard players operation #boy display_calc = #bo display_calc
execute if score @s note_c_dist matches 1.. run scoreboard players operation #boy display_calc *= @s note_c_sy
execute if score @s note_c_dist matches 1.. run scoreboard players operation #boy display_calc /= @s note_c_dist
execute if score @s note_c_dist matches 1.. run scoreboard players operation #icy play_state += #boy display_calc
execute if score @s note_c_dist matches 1.. run scoreboard players operation #boz display_calc = #bo display_calc
execute if score @s note_c_dist matches 1.. run scoreboard players operation #boz display_calc *= @s note_c_sz
execute if score @s note_c_dist matches 1.. run scoreboard players operation #boz display_calc /= @s note_c_dist
execute if score @s note_c_dist matches 1.. run scoreboard players operation #icz play_state += #boz display_calc
# 配对写入交互实体（直接写当前头端 = 展示视觉位置）
scoreboard players operation #nid play_state = @s note_id
execute as @e[type=interaction,tag=note_interaction] if score @s note_id = #nid play_state run execute store result entity @s Pos[0] double 0.01 run scoreboard players get #icx play_state
execute as @e[type=interaction,tag=note_interaction] if score @s note_id = #nid play_state run execute store result entity @s Pos[1] double 0.01 run scoreboard players get #icy play_state
execute as @e[type=interaction,tag=note_interaction] if score @s note_id = #nid play_state run execute store result entity @s Pos[2] double 0.01 run scoreboard players get #icz play_state
# （不再存 note_prev_cx/cy/cz：交互直接写当前视觉位置）

# 调试（lv.2）：诊断展示 vs 交互到位时序（2026-08-08）
#   l = 寿命；hp = 头进度（交互）；dispTZ = 展示 translation.z（中心，局部）；交互Z = 交互实体 z（×100）
execute store result score #disp_tz display_calc run data get entity @s transformation.translation[2] 100
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][混凝土]","color":"aqua"},{"text":" l=","color":"gray"},{"score":{"objective":"play_state","name":"#cl"}},{"text":" hp=","color":"gray"},{"score":{"objective":"display_calc","name":"#hp"}},{"text":" dispTZ=","color":"gray"},{"score":{"objective":"display_calc","name":"#disp_tz"}},{"text":" 交互Z=","color":"gold"},{"score":{"objective":"play_state","name":"#icz"}}]
