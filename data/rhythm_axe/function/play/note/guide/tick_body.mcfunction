# 引导线绘制（由 guide/tick 入口调用；@s = note_guide；#m/#n/#ga/#gb 已由入口算好）
# 设计（用户 2026-08-30 定稿）：
#   m<0（前一个音符还没到判定时刻）→ A=前音符当前视觉位置，l=两音符当前距离，长度=l（不收缩）
#   0<=m<n（前一个音符已到判定位置，后一个音符还在路上）→ A=前判定位置快照，
#       长度 = l × (n-m)/n（l = 后音符到前判定点距离），m=n 时归零
# 只在本函数被调用时 m<n 恒成立，故 /#n 安全。
# A 端默认 = 前一个音符判定位置快照；m<0 时改用前一个音符当前视觉位置
scoreboard players operation #ax play_state = @s note_guide_x
scoreboard players operation #ay play_state = @s note_guide_y
scoreboard players operation #az play_state = @s note_guide_z
execute if score #m play_state matches ..-1 run execute as @e[type=item_display,tag=note_display] if score @s note_id = #ga play_state run function rhythm_axe:play/note/guide/read_a
# B 端 = 后一个音符当前视觉位置
scoreboard players set #bx play_state 0
scoreboard players set #by play_state 0
scoreboard players set #bz play_state 0
execute as @e[type=item_display,tag=note_display] if score @s note_id = #gb play_state run function rhythm_axe:play/note/guide/read_b
# 中点 = (A+B)/2（×100）
scoreboard players operation #mx play_state = #ax play_state
scoreboard players operation #mx play_state += #bx play_state
scoreboard players operation #mx play_state /= 2 const
scoreboard players operation #my play_state = #ay play_state
scoreboard players operation #my play_state += #by play_state
scoreboard players operation #my play_state /= 2 const
scoreboard players operation #mz play_state = #az play_state
scoreboard players operation #mz play_state += #bz play_state
scoreboard players operation #mz play_state /= 2 const
# 方向 B-A（×100）
scoreboard players operation #dx play_state = #bx play_state
scoreboard players operation #dx play_state -= #ax play_state
scoreboard players operation #dy play_state = #by play_state
scoreboard players operation #dy play_state -= #ay play_state
scoreboard players operation #dz play_state = #bz play_state
scoreboard players operation #dz play_state -= #az play_state
# 水平距离 h = sqrt(dx²+dz²)（pitch 用）
scoreboard players operation #hz2 display_calc = #dx play_state
scoreboard players operation #hz2 display_calc *= #dx play_state
scoreboard players operation #hzz display_calc = #dz play_state
scoreboard players operation #hzz display_calc *= #dz play_state
scoreboard players operation #hz2 display_calc += #hzz display_calc
scoreboard players operation #sqrt_sq display_calc = #hz2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #h display_calc = #sqrt_out display_calc
# 3D 距离 d = sqrt(dx²+dy²+dz²)（#gd = 线长基准，×100）
scoreboard players operation #d2 display_calc = #hz2 display_calc
scoreboard players operation #t2 display_calc = #dy play_state
scoreboard players operation #t2 display_calc *= #dy play_state
scoreboard players operation #d2 display_calc += #t2 display_calc
scoreboard players operation #sqrt_sq display_calc = #d2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #gd display_calc = #sqrt_out display_calc
# ---- 朝向四元数（left_rotation；euler_to_quat，半角×10 = 度×100÷20）----
scoreboard players operation #num display_calc = #dx play_state
scoreboard players operation #den display_calc = #dz play_state
function rhythm_axe:utilization/math/atan2
scoreboard players operation #ha_ry display_calc = #atan_deg100 display_calc
scoreboard players operation #ha_ry display_calc /= 20 const
scoreboard players operation #num display_calc = #dy play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #h display_calc
function rhythm_axe:utilization/math/atan2
scoreboard players operation #ha_rx display_calc = #atan_deg100 display_calc
scoreboard players operation #ha_rx display_calc /= 20 const
scoreboard players set #ha_rz display_calc 0
function rhythm_axe:utilization/math/euler_to_quat
# ---- 收缩因子 s = (n-m)/n（×1000 定点，避免整数除法丢失）；m<0 → 1 ----
scoreboard players operation #s play_state = #n play_state
scoreboard players operation #s play_state -= #m play_state
scoreboard players operation #s play_state *= 1000 const
execute if score #m play_state matches ..-1 run scoreboard players set #s play_state 1000
execute unless score #m play_state matches ..-1 run scoreboard players operation #s play_state /= #n play_state
# 长度 = |A-B| × s（#gd 为原始 3D 距离 ×100）
scoreboard players operation #glen play_state = #gd display_calc
scoreboard players operation #glen play_state *= #s play_state
scoreboard players operation #glen play_state /= 1000 const
# 中点 = B + (A-B)×s/2（一头始终锚定 B=后一个音符）
scoreboard players operation #offx play_state = #ax play_state
scoreboard players operation #offx play_state -= #bx play_state
scoreboard players operation #offx play_state *= #s play_state
scoreboard players operation #offx play_state /= 1000 const
scoreboard players operation #offx play_state /= 2 const
scoreboard players operation #mx play_state = #bx play_state
scoreboard players operation #mx play_state += #offx play_state
scoreboard players operation #offy play_state = #ay play_state
scoreboard players operation #offy play_state -= #by play_state
scoreboard players operation #offy play_state *= #s play_state
scoreboard players operation #offy play_state /= 1000 const
scoreboard players operation #offy play_state /= 2 const
scoreboard players operation #my play_state = #by play_state
scoreboard players operation #my play_state += #offy play_state
scoreboard players operation #offz play_state = #az play_state
scoreboard players operation #offz play_state -= #bz play_state
scoreboard players operation #offz play_state *= #s play_state
scoreboard players operation #offz play_state /= 1000 const
scoreboard players operation #offz play_state /= 2 const
scoreboard players operation #mz play_state = #bz play_state
scoreboard players operation #mz play_state += #offz play_state
# ---- 写 storage（translation/left_rotation/right_rotation/scale 全组装）----
data modify storage rhythm_axe:guide transformation set value {translation:[0.0d,0.0d,0.0d],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.15f,0.15f,0.01f]}
execute store result storage rhythm_axe:guide transformation.translation[0] double 0.01 run scoreboard players get #mx play_state
execute store result storage rhythm_axe:guide transformation.translation[1] double 0.01 run scoreboard players get #my play_state
execute store result storage rhythm_axe:guide transformation.translation[2] double 0.01 run scoreboard players get #mz play_state
execute store result storage rhythm_axe:guide transformation.left_rotation[0] float 0.0001 run scoreboard players get #qx display_calc
execute store result storage rhythm_axe:guide transformation.left_rotation[1] float 0.0001 run scoreboard players get #qy display_calc
execute store result storage rhythm_axe:guide transformation.left_rotation[2] float 0.0001 run scoreboard players get #qz display_calc
execute store result storage rhythm_axe:guide transformation.left_rotation[3] float 0.0001 run scoreboard players get #qw display_calc
execute store result storage rhythm_axe:guide transformation.scale[2] float 0.01 run scoreboard players get #glen play_state
data modify entity @s transformation set from storage rhythm_axe:guide transformation
