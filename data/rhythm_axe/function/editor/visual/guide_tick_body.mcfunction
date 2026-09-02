# 编辑器引导线绘制（由 guide_tick 入口调用；@s = editor_guide；#m/#n/#ga/#gb 已由入口算好）
# 设计同游玩：m<0 → A=前音符实时位置，l=两音符距离，长度=l；
#   0<=m<n → A=前判定位置快照，长度 = l×(n-m)/n（m=n 时归零）；仅 m<n 时调用，/#n 安全。
# A 端默认 = 前一个音符判定位置快照；m<0 时改用前一个音符实时视觉中心
scoreboard players operation #ax editor = @s note_guide_x
scoreboard players operation #ay editor = @s note_guide_y
scoreboard players operation #az editor = @s note_guide_z
scoreboard players set #bx editor 0
scoreboard players set #by editor 0
scoreboard players set #bz editor 0
# 端点 = 音符展示实体视觉中心（editor_n_vx/vy/vz，place 计算：判定位置 + 沿飞行方向的实时偏移，×1000 → /10 → ×100）
# 仅 m<0（前一个音符未到判定时刻）才读前一个音符 #ga 的实时视觉中心
execute if score #m editor matches ..-1 run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #ga editor run scoreboard players operation #ax editor = @s editor_n_vx
execute if score #m editor matches ..-1 run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #ga editor run scoreboard players operation #ay editor = @s editor_n_vy
execute if score #m editor matches ..-1 run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #ga editor run scoreboard players operation #az editor = @s editor_n_vz
execute if score #m editor matches ..-1 run scoreboard players operation #ax editor /= 10 const
execute if score #m editor matches ..-1 run scoreboard players operation #ay editor /= 10 const
execute if score #m editor matches ..-1 run scoreboard players operation #az editor /= 10 const
# B 端默认 = 当前音符 B 的出生点（×100，note_guide_sx/sy/sz）；B 已出生则用其实时视觉中心（×1000→/10→×100）覆盖
scoreboard players operation #bx editor = @s note_guide_sx
scoreboard players operation #by editor = @s note_guide_sy
scoreboard players operation #bz editor = @s note_guide_sz
scoreboard players set #b_born editor 0
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #gb editor run scoreboard players set #b_born editor 1
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #gb editor run scoreboard players operation #bx editor = @s editor_n_vx
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #gb editor run scoreboard players operation #by editor = @s editor_n_vy
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #gb editor run scoreboard players operation #bz editor = @s editor_n_vz
execute if score #b_born editor matches 1 run scoreboard players operation #bx editor /= 10 const
execute if score #b_born editor matches 1 run scoreboard players operation #by editor /= 10 const
execute if score #b_born editor matches 1 run scoreboard players operation #bz editor /= 10 const
# 中点 = (A+B)/2（x100）
scoreboard players operation #mx editor = #ax editor
scoreboard players operation #mx editor += #bx editor
scoreboard players operation #mx editor /= 2 const
scoreboard players operation #my editor = #ay editor
scoreboard players operation #my editor += #by editor
scoreboard players operation #my editor /= 2 const
scoreboard players operation #mz editor = #az editor
scoreboard players operation #mz editor += #bz editor
scoreboard players operation #mz editor /= 2 const
# 方向 = B-A（x100），同时计算水平距离与总距离
scoreboard players operation #dx editor = #bx editor
scoreboard players operation #dx editor -= #ax editor
scoreboard players operation #dy editor = #by editor
scoreboard players operation #dy editor -= #ay editor
scoreboard players operation #dz editor = #bz editor
scoreboard players operation #dz editor -= #az editor
scoreboard players operation #hz2 display_calc = #dx editor
scoreboard players operation #hz2 display_calc *= #dx editor
scoreboard players operation #hzz display_calc = #dz editor
scoreboard players operation #hzz display_calc *= #dz editor
scoreboard players operation #hz2 display_calc += #hzz display_calc
scoreboard players operation #sqrt_sq display_calc = #hz2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #h display_calc = #sqrt_out display_calc
scoreboard players operation #d2 display_calc = #dx editor
scoreboard players operation #d2 display_calc *= #dx editor
scoreboard players operation #t2 display_calc = #dy editor
scoreboard players operation #t2 display_calc *= #dy editor
scoreboard players operation #d2 display_calc += #t2 display_calc
scoreboard players operation #t2 display_calc = #dz editor
scoreboard players operation #t2 display_calc *= #dz editor
scoreboard players operation #d2 display_calc += #t2 display_calc
scoreboard players operation #sqrt_sq display_calc = #d2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #gd display_calc = #sqrt_out display_calc
# 四元数：yaw=atan2(dx,dz)，pitch=atan2(-dy,h)
scoreboard players operation #num display_calc = #dx editor
scoreboard players operation #den display_calc = #dz editor
function rhythm_axe:utilization/math/atan2
scoreboard players operation #ha_ry display_calc = #atan_deg100 display_calc
scoreboard players operation #ha_ry display_calc /= 20 const
scoreboard players operation #num display_calc = #dy editor
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #h display_calc
function rhythm_axe:utilization/math/atan2
scoreboard players operation #ha_rx display_calc = #atan_deg100 display_calc
scoreboard players operation #ha_rx display_calc /= 20 const
scoreboard players set #ha_rz display_calc 0
function rhythm_axe:utilization/math/euler_to_quat
# 收缩因子 s = (n-m)/n（×1000 定点，避免整数除法丢失）；m<0 → 1
scoreboard players operation #s editor = #n editor
scoreboard players operation #s editor -= #m editor
scoreboard players operation #s editor *= 1000 const
execute if score #m editor matches ..-1 run scoreboard players set #s editor 1000
execute unless score #m editor matches ..-1 run scoreboard players operation #s editor /= #n editor
# 长度 = |A-B| × s（#gd 为原始 3D 距离 ×100）
scoreboard players operation #glen editor = #gd display_calc
scoreboard players operation #glen editor *= #s editor
scoreboard players operation #glen editor /= 1000 const
# 中点 = B + (A-B)×s/2（一头始终锚定 B=后一个音符）
scoreboard players operation #offx editor = #ax editor
scoreboard players operation #offx editor -= #bx editor
scoreboard players operation #offx editor *= #s editor
scoreboard players operation #offx editor /= 1000 const
scoreboard players operation #offx editor /= 2 const
scoreboard players operation #mx editor = #bx editor
scoreboard players operation #mx editor += #offx editor
scoreboard players operation #offy editor = #ay editor
scoreboard players operation #offy editor -= #by editor
scoreboard players operation #offy editor *= #s editor
scoreboard players operation #offy editor /= 1000 const
scoreboard players operation #offy editor /= 2 const
scoreboard players operation #my editor = #by editor
scoreboard players operation #my editor += #offy editor
scoreboard players operation #offz editor = #az editor
scoreboard players operation #offz editor -= #bz editor
scoreboard players operation #offz editor *= #s editor
scoreboard players operation #offz editor /= 1000 const
scoreboard players operation #offz editor /= 2 const
scoreboard players operation #mz editor = #bz editor
scoreboard players operation #mz editor += #offz editor
# 写入 transformation，长度 = #glen
data modify storage rhythm_axe:editor_guide transformation set value {translation:[0.0d,0.0d,0.0d],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.15f,0.15f,0.01f]}
execute store result storage rhythm_axe:editor_guide transformation.translation[0] double 0.01 run scoreboard players get #mx editor
execute store result storage rhythm_axe:editor_guide transformation.translation[1] double 0.01 run scoreboard players get #my editor
execute store result storage rhythm_axe:editor_guide transformation.translation[2] double 0.01 run scoreboard players get #mz editor
execute store result storage rhythm_axe:editor_guide transformation.left_rotation[0] float 0.0001 run scoreboard players get #qx display_calc
execute store result storage rhythm_axe:editor_guide transformation.left_rotation[1] float 0.0001 run scoreboard players get #qy display_calc
execute store result storage rhythm_axe:editor_guide transformation.left_rotation[2] float 0.0001 run scoreboard players get #qz display_calc
execute store result storage rhythm_axe:editor_guide transformation.left_rotation[3] float 0.0001 run scoreboard players get #qw display_calc
execute store result storage rhythm_axe:editor_guide transformation.scale[2] float 0.01 run scoreboard players get #glen editor
data modify entity @s transformation set from storage rhythm_axe:editor_guide transformation
