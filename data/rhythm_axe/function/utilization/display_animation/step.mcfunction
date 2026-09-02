# ========== 动画步进 ==========
# 每 tick 执行一次，计算当前帧并写入实体。
# 由 tick.mcfunction 驱动。
# ===== 1. 递增计时器 =====
scoreboard players add @s anim_timer 1

# ===== 2. 缓动计算：将 #ratio 设为当前进度 (0~10000) =====
scoreboard players operation #n display_calc = @s anim_timer
scoreboard players operation #total display_calc = @s anim_duration
scoreboard players operation #power display_calc = @s anim_power
scoreboard players operation #easing_type display_calc = @s anim_easing
function rhythm_axe:utilization/display_animation/easing/power

# ===== 3. 分量插值（★ 按需执行，2026-08-09）=====
# ★ 优化：start 已计算 anim_c_* 标志（该分量是否有变化）。无变化分量直接 cur=start（end==start，
#   cur 恒为 start，无需插值），只在有变化时才调用插值子函数 → 音符 8/9 分量无变化，省大量命令。
# 平移 X（anim_c_px=0 无变化 → cur=start；=1 有变化 → 插值子函数）
execute if score @s anim_c_px matches 0 run scoreboard players operation #cur_px display_calc = @s anim_start_px
execute if score @s anim_c_px matches 1 run function rhythm_axe:utilization/display_animation/interp/px
# 平移 Y
execute if score @s anim_c_py matches 0 run scoreboard players operation #cur_py display_calc = @s anim_start_py
execute if score @s anim_c_py matches 1 run function rhythm_axe:utilization/display_animation/interp/py
# 平移 Z
execute if score @s anim_c_pz matches 0 run scoreboard players operation #cur_pz display_calc = @s anim_start_pz
execute if score @s anim_c_pz matches 1 run function rhythm_axe:utilization/display_animation/interp/pz
# 缩放 X
execute if score @s anim_c_sx matches 0 run scoreboard players operation #cur_sx display_calc = @s anim_start_sx
execute if score @s anim_c_sx matches 1 run function rhythm_axe:utilization/display_animation/interp/sx
# 缩放 Y
execute if score @s anim_c_sy matches 0 run scoreboard players operation #cur_sy display_calc = @s anim_start_sy
execute if score @s anim_c_sy matches 1 run function rhythm_axe:utilization/display_animation/interp/sy
# 缩放 Z
execute if score @s anim_c_sz matches 0 run scoreboard players operation #cur_sz display_calc = @s anim_start_sz
execute if score @s anim_c_sz matches 1 run function rhythm_axe:utilization/display_animation/interp/sz
# 旋转 X（音符旋转恒单位 → anim_c_rx=0，直接走下方单位四元数快路径）
execute if score @s anim_c_rx matches 0 run scoreboard players operation #cur_rx display_calc = @s anim_start_rx
execute if score @s anim_c_rx matches 1 run function rhythm_axe:utilization/display_animation/interp/rx
# 旋转 Y
execute if score @s anim_c_ry matches 0 run scoreboard players operation #cur_ry display_calc = @s anim_start_ry
execute if score @s anim_c_ry matches 1 run function rhythm_axe:utilization/display_animation/interp/ry
# 旋转 Z
execute if score @s anim_c_rz matches 0 run scoreboard players operation #cur_rz display_calc = @s anim_start_rz
execute if score @s anim_c_rz matches 1 run function rhythm_axe:utilization/display_animation/interp/rz

# ===== 4. 旋转（★ 快路径 + 单轴轴角，2026-08-09）=====
# 音符旋转恒为单位四元数 → anim_c_rot=0 → 直接写单位四元数 [0,0,0,1]，
#   跳过 半角计算 + 三角查表 + euler_to_quat（~59 条/实体/tick）。
# anim_c_rot=1 且【单轴旋转】→ 用轴角 {angle(弧度), axis} 写入 left_rotation，
#   游戏底层自动转单位四元数 → 省 euler_to_quat（~59 条）。单轴 = 只有一轴变化且另两轴恒 0
#   （否则 ZYX 组合旋转轴不固定，轴角无法简单表达 → 走原 euler_to_quat）。
# anim_c_rot=1 且【多轴旋转】→ rot_calc（半角+查表+euler_to_quat）。
# 旋转模式 #rot_mode：0=单位/四元数；1=绕X；2=绕Y；3=绕Z
scoreboard players set #rot_mode display_calc 0
execute if score @s anim_c_rot matches 0 run scoreboard players set #qx display_calc 0
execute if score @s anim_c_rot matches 0 run scoreboard players set #qy display_calc 0
execute if score @s anim_c_rot matches 0 run scoreboard players set #qz display_calc 0
execute if score @s anim_c_rot matches 0 run scoreboard players set #qw display_calc 10000
# 纯 X 旋转：rx 变，ry/rz 恒 0
execute if score @s anim_c_rx matches 1 if score @s anim_start_ry matches 0 if score @s anim_end_ry matches 0 if score @s anim_start_rz matches 0 if score @s anim_end_rz matches 0 run scoreboard players set #rot_mode display_calc 1
# 纯 Y 旋转：ry 变，rx/rz 恒 0
execute if score @s anim_c_ry matches 1 if score @s anim_start_rx matches 0 if score @s anim_end_rx matches 0 if score @s anim_start_rz matches 0 if score @s anim_end_rz matches 0 run scoreboard players set #rot_mode display_calc 2
# 纯 Z 旋转：rz 变，rx/ry 恒 0
execute if score @s anim_c_rz matches 1 if score @s anim_start_rx matches 0 if score @s anim_end_rx matches 0 if score @s anim_start_ry matches 0 if score @s anim_end_ry matches 0 run scoreboard players set #rot_mode display_calc 3
# 轴角模式：度→弧度×10000（度 × 174.533 = 弧度×10000）；存轴分量
execute if score #rot_mode display_calc matches 1 run scoreboard players operation #ax_angle display_calc = #cur_rx display_calc
execute if score #rot_mode display_calc matches 2 run scoreboard players operation #ax_angle display_calc = #cur_ry display_calc
execute if score #rot_mode display_calc matches 3 run scoreboard players operation #ax_angle display_calc = #cur_rz display_calc
execute if score #rot_mode display_calc matches 1..3 run scoreboard players operation #ax_angle display_calc *= 17453 const
execute if score #rot_mode display_calc matches 1..3 run scoreboard players operation #ax_angle display_calc /= 100 const
execute if score #rot_mode display_calc matches 1 run scoreboard players set #ax_x display_calc 1
execute if score #rot_mode display_calc matches 1 run scoreboard players set #ax_y display_calc 0
execute if score #rot_mode display_calc matches 1 run scoreboard players set #ax_z display_calc 0
execute if score #rot_mode display_calc matches 2 run scoreboard players set #ax_x display_calc 0
execute if score #rot_mode display_calc matches 2 run scoreboard players set #ax_y display_calc 1
execute if score #rot_mode display_calc matches 2 run scoreboard players set #ax_z display_calc 0
execute if score #rot_mode display_calc matches 3 run scoreboard players set #ax_x display_calc 0
execute if score #rot_mode display_calc matches 3 run scoreboard players set #ax_y display_calc 0
execute if score #rot_mode display_calc matches 3 run scoreboard players set #ax_z display_calc 1
# 多轴旋转（rot_mode=0 但 anim_c_rot=1）→ 原 euler_to_quat
execute if score @s anim_c_rot matches 1 if score #rot_mode display_calc matches 0 run function rhythm_axe:utilization/display_animation/rot_calc

# ===== 5. 在 storage 中组装 transformation 并批量写入实体 =====
# （替代 10 次 execute store result entity，减少实体 NBT 写入开销）
# 初始化 translation 数组
data modify storage display_animation:transform translation set value [0.0,0.0,0.0]
execute store result storage display_animation:transform translation[0] float 0.01 run scoreboard players get #cur_px display_calc
execute store result storage display_animation:transform translation[1] float 0.01 run scoreboard players get #cur_py display_calc
execute store result storage display_animation:transform translation[2] float 0.01 run scoreboard players get #cur_pz display_calc
# 初始化 left_rotation（★ 分叉，2026-08-09：单轴轴角 / 四元数两种写入）
# 轴角模式（#rot_mode=1/2/3）：写 {angle, axis} 复合标签 → 游戏底层转单位四元数
data modify storage display_animation:transform left_rotation set value {angle:0.0f, axis:[0.0f,0.0f,0.0f]}
execute if score #rot_mode display_calc matches 1..3 run execute store result storage display_animation:transform left_rotation.angle float 0.0001 run scoreboard players get #ax_angle display_calc
execute if score #rot_mode display_calc matches 1..3 run execute store result storage display_animation:transform left_rotation.axis[0] float 1 run scoreboard players get #ax_x display_calc
execute if score #rot_mode display_calc matches 1..3 run execute store result storage display_animation:transform left_rotation.axis[1] float 1 run scoreboard players get #ax_y display_calc
execute if score #rot_mode display_calc matches 1..3 run execute store result storage display_animation:transform left_rotation.axis[2] float 1 run scoreboard players get #ax_z display_calc
# 四元数模式（#rot_mode=0）：写 [x,y,z,w]（单位四元数 / rot_calc 计算结果）
execute if score #rot_mode display_calc matches 0 run data modify storage display_animation:transform left_rotation set value [0.0,0.0,0.0,1.0]
execute if score #rot_mode display_calc matches 0 run execute store result storage display_animation:transform left_rotation[0] float 0.0001 run scoreboard players get #qx display_calc
execute if score #rot_mode display_calc matches 0 run execute store result storage display_animation:transform left_rotation[1] float 0.0001 run scoreboard players get #qy display_calc
execute if score #rot_mode display_calc matches 0 run execute store result storage display_animation:transform left_rotation[2] float 0.0001 run scoreboard players get #qz display_calc
execute if score #rot_mode display_calc matches 0 run execute store result storage display_animation:transform left_rotation[3] float 0.0001 run scoreboard players get #qw display_calc
# 初始化 scale 数组
data modify storage display_animation:transform scale set value [0.0,0.0,0.0]
execute store result storage display_animation:transform scale[0] float 0.01 run scoreboard players get #cur_sx display_calc
execute store result storage display_animation:transform scale[1] float 0.01 run scoreboard players get #cur_sy display_calc
execute store result storage display_animation:transform scale[2] float 0.01 run scoreboard players get #cur_sz display_calc
# 单次写入实体（替代 10 次单独的 entity 写入）
data modify entity @s transformation merge from storage display_animation:transform
# ★ 阶段A（性能轮）：当前局部平移 z 存计分板（move 读它替代 data get entity transformation.translation[2]）
scoreboard players operation @s note_cur_tz = #cur_pz display_calc

# ===== 10. 调试输出当前帧（lv.2）=====
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2] ","color":"dark_green"},{"score":{"objective":"anim_timer","name":"@s"},"color":"white"},{"text":"/","color":"gray"},{"score":{"objective":"anim_duration","name":"@s"},"color":"white"},{"text":"  ratio=","color":"gray"},{"score":{"objective":"display_calc","name":"#ratio"},"color":"white"},{"text":"  P:","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_px"},"color":"green"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_py"},"color":"green"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_pz"},"color":"green"},{"text":"  R:","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_rx"},"color":"yellow"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_ry"},"color":"yellow"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_rz"},"color":"yellow"},{"text":"  S:","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_sx"},"color":"aqua"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_sy"},"color":"aqua"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#cur_sz"},"color":"aqua"},{"text":"  Q:","color":"gray"},{"score":{"objective":"display_calc","name":"#qx"},"color":"light_purple"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#qy"},"color":"light_purple"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#qz"},"color":"light_purple"},{"text":",","color":"gray"},{"score":{"objective":"display_calc","name":"#qw"},"color":"light_purple"}]

# ===== 11. 动画结束检测 =====
execute if score @s anim_timer >= @s anim_duration run scoreboard players set @s anim_status 2
execute if score @s anim_status matches 2 run function rhythm_axe:utilization/display_animation/finish