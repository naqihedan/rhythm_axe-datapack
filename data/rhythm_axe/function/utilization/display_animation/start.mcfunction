# ========== 启动动画 ==========
# ===== 1. 动画参数默认值 =====

    # 动画时长，默认 20 tick
    execute unless score #ANIM_DURATION display_calc matches 1.. run scoreboard players set #ANIM_DURATION display_calc 20

    # 缓动次方数，默认 3（三次方缓动）
    execute unless score #ANIM_POWER display_calc matches 1.. run scoreboard players set #ANIM_POWER display_calc 3

    # 应用位置变化标志，默认 0（0=不提交 1=动画开始前就提交 2=动画结束后提交）
    execute unless score #ANIM_APPLY_POSITION display_calc matches 0..2 run scoreboard players set #ANIM_APPLY_POSITION display_calc 0

    # 缓动类型，默认 3（缓入缓出）
    execute unless score #ANIM_EASING display_calc matches 1..3 run scoreboard players set #ANIM_EASING display_calc 3

# ===== 2. 复制动画参数到实体 =====

    execute store result score @s anim_duration run scoreboard players get #ANIM_DURATION display_calc
    execute store result score @s anim_power run scoreboard players get #ANIM_POWER display_calc
    execute store result score @s anim_apply_position run scoreboard players get #ANIM_APPLY_POSITION display_calc
    execute store result score @s anim_easing run scoreboard players get #ANIM_EASING display_calc

# ===== 3. 读取起始平移（从实体 NBT）=====
    # 平移值 ×100（精度 0.01 格）
    execute store result score #cur_px display_calc run data get entity @s transformation.translation[0] 100
    execute store result score #cur_py display_calc run data get entity @s transformation.translation[1] 100
    execute store result score #cur_pz display_calc run data get entity @s transformation.translation[2] 100

    # 若玩家设置了起始值（非零），覆盖
    execute if score #ANIM_START_PX display_calc matches 1.. run scoreboard players operation #cur_px display_calc = #ANIM_START_PX display_calc
    execute if score #ANIM_START_PX display_calc matches ..-1 run scoreboard players operation #cur_px display_calc = #ANIM_START_PX display_calc
    execute if score #ANIM_START_PY display_calc matches 1.. run scoreboard players operation #cur_py display_calc = #ANIM_START_PY display_calc
    execute if score #ANIM_START_PY display_calc matches ..-1 run scoreboard players operation #cur_py display_calc = #ANIM_START_PY display_calc
    execute if score #ANIM_START_PZ display_calc matches 1.. run scoreboard players operation #cur_pz display_calc = #ANIM_START_PZ display_calc
    execute if score #ANIM_START_PZ display_calc matches ..-1 run scoreboard players operation #cur_pz display_calc = #ANIM_START_PZ display_calc

    scoreboard players operation @s anim_start_px = #cur_px display_calc
    scoreboard players operation @s anim_start_py = #cur_py display_calc
    scoreboard players operation @s anim_start_pz = #cur_pz display_calc

# ===== 4. 读取起始缩放（从实体 NBT）=====
    # 缩放值 ×100（精度 0.01 倍）
        execute store result score #cur_sx display_calc run data get entity @s transformation.scale[0] 100
        execute store result score #cur_sy display_calc run data get entity @s transformation.scale[1] 100
        execute store result score #cur_sz display_calc run data get entity @s transformation.scale[2] 100

    # 若玩家设置了起始值（非零），覆盖
        execute if score #ANIM_START_SX display_calc matches 1.. run scoreboard players operation #cur_sx display_calc = #ANIM_START_SX display_calc
        execute if score #ANIM_START_SX display_calc matches ..-1 run scoreboard players operation #cur_sx display_calc = #ANIM_START_SX display_calc
        execute if score #ANIM_START_SY display_calc matches 1.. run scoreboard players operation #cur_sy display_calc = #ANIM_START_SY display_calc
        execute if score #ANIM_START_SY display_calc matches ..-1 run scoreboard players operation #cur_sy display_calc = #ANIM_START_SY display_calc
        execute if score #ANIM_START_SZ display_calc matches 1.. run scoreboard players operation #cur_sz display_calc = #ANIM_START_SZ display_calc
        execute if score #ANIM_START_SZ display_calc matches ..-1 run scoreboard players operation #cur_sz display_calc = #ANIM_START_SZ display_calc

        scoreboard players operation @s anim_start_sx = #cur_sx display_calc
        scoreboard players operation @s anim_start_sy = #cur_sy display_calc
        scoreboard players operation @s anim_start_sz = #cur_sz display_calc

# ===== 5. 读取起始旋转 =====
    # 优先用上一动画存储的欧拉角（避免四元数→欧拉角精度漂移）
    execute if score @s anim_cur_rx matches 1.. run scoreboard players operation #cur_rx display_calc = @s anim_cur_rx
    execute if score @s anim_cur_rx matches ..-1 run scoreboard players operation #cur_rx display_calc = @s anim_cur_rx
    execute if score @s anim_cur_ry matches 1.. run scoreboard players operation #cur_ry display_calc = @s anim_cur_ry
    execute if score @s anim_cur_ry matches ..-1 run scoreboard players operation #cur_ry display_calc = @s anim_cur_ry
    execute if score @s anim_cur_rz matches 1.. run scoreboard players operation #cur_rz display_calc = @s anim_cur_rz
    execute if score @s anim_cur_rz matches ..-1 run scoreboard players operation #cur_rz display_calc = @s anim_cur_rz
    # 第一次动画无存储记录时，从实体四元数读取
    execute unless score @s anim_cur_rx matches 1.. unless score @s anim_cur_rx matches ..-1 run function rhythm_axe:utilization/math/quat_to_euler
    # cur_rx/ry/rz 已确定
    # 若玩家设置了某一轴的起始值（非零），覆盖该轴
    execute if score #ANIM_START_RX display_calc matches 1.. run scoreboard players operation #cur_rx display_calc = #ANIM_START_RX display_calc
    execute if score #ANIM_START_RX display_calc matches ..-1 run scoreboard players operation #cur_rx display_calc = #ANIM_START_RX display_calc
    execute if score #ANIM_START_RY display_calc matches 1.. run scoreboard players operation #cur_ry display_calc = #ANIM_START_RY display_calc
    execute if score #ANIM_START_RY display_calc matches ..-1 run scoreboard players operation #cur_ry display_calc = #ANIM_START_RY display_calc
    execute if score #ANIM_START_RZ display_calc matches 1.. run scoreboard players operation #cur_rz display_calc = #ANIM_START_RZ display_calc
    execute if score #ANIM_START_RZ display_calc matches ..-1 run scoreboard players operation #cur_rz display_calc = #ANIM_START_RZ display_calc

    scoreboard players operation @s anim_start_rx = #cur_rx display_calc
    scoreboard players operation @s anim_start_ry = #cur_ry display_calc
    scoreboard players operation @s anim_start_rz = #cur_rz display_calc

# ===== 6. 计算目标变换 =====
        # 最终目标 = target（绝对基准）+ delta（叠加偏移）
        # target 存在（非零）时作为基准，否则用 start

        # 平移 X
        scoreboard players operation @s anim_end_px = @s anim_start_px
        execute if score #ANIM_TARGET_PX display_calc matches 1.. run scoreboard players operation @s anim_end_px = #ANIM_TARGET_PX display_calc
        execute if score #ANIM_TARGET_PX display_calc matches ..-1 run scoreboard players operation @s anim_end_px = #ANIM_TARGET_PX display_calc
        scoreboard players operation @s anim_end_px += #ANIM_DELTA_PX display_calc

        # 平移 Y
        scoreboard players operation @s anim_end_py = @s anim_start_py
        execute if score #ANIM_TARGET_PY display_calc matches 1.. run scoreboard players operation @s anim_end_py = #ANIM_TARGET_PY display_calc
        execute if score #ANIM_TARGET_PY display_calc matches ..-1 run scoreboard players operation @s anim_end_py = #ANIM_TARGET_PY display_calc
        scoreboard players operation @s anim_end_py += #ANIM_DELTA_PY display_calc

        # 平移 Z
        scoreboard players operation @s anim_end_pz = @s anim_start_pz
        execute if score #ANIM_TARGET_PZ display_calc matches 1.. run scoreboard players operation @s anim_end_pz = #ANIM_TARGET_PZ display_calc
        execute if score #ANIM_TARGET_PZ display_calc matches ..-1 run scoreboard players operation @s anim_end_pz = #ANIM_TARGET_PZ display_calc
        scoreboard players operation @s anim_end_pz += #ANIM_DELTA_PZ display_calc

        # 旋转 X
        scoreboard players operation @s anim_end_rx = @s anim_start_rx
        execute if score #ANIM_TARGET_RX display_calc matches 1.. run scoreboard players operation @s anim_end_rx = #ANIM_TARGET_RX display_calc
        execute if score #ANIM_TARGET_RX display_calc matches ..-1 run scoreboard players operation @s anim_end_rx = #ANIM_TARGET_RX display_calc
        scoreboard players operation @s anim_end_rx += #ANIM_DELTA_RX display_calc

        # 旋转 Y
        scoreboard players operation @s anim_end_ry = @s anim_start_ry
        execute if score #ANIM_TARGET_RY display_calc matches 1.. run scoreboard players operation @s anim_end_ry = #ANIM_TARGET_RY display_calc
        execute if score #ANIM_TARGET_RY display_calc matches ..-1 run scoreboard players operation @s anim_end_ry = #ANIM_TARGET_RY display_calc
        scoreboard players operation @s anim_end_ry += #ANIM_DELTA_RY display_calc

        # 旋转 Z
        scoreboard players operation @s anim_end_rz = @s anim_start_rz
        execute if score #ANIM_TARGET_RZ display_calc matches 1.. run scoreboard players operation @s anim_end_rz = #ANIM_TARGET_RZ display_calc
        execute if score #ANIM_TARGET_RZ display_calc matches ..-1 run scoreboard players operation @s anim_end_rz = #ANIM_TARGET_RZ display_calc
        scoreboard players operation @s anim_end_rz += #ANIM_DELTA_RZ display_calc

        # 缩放 X
        scoreboard players operation @s anim_end_sx = @s anim_start_sx
        execute if score #ANIM_TARGET_SX display_calc matches 1.. run scoreboard players operation @s anim_end_sx = #ANIM_TARGET_SX display_calc
        execute if score #ANIM_TARGET_SX display_calc matches ..-1 run scoreboard players operation @s anim_end_sx = #ANIM_TARGET_SX display_calc
        scoreboard players operation @s anim_end_sx += #ANIM_DELTA_SX display_calc

        # 缩放 Y
        scoreboard players operation @s anim_end_sy = @s anim_start_sy
        execute if score #ANIM_TARGET_SY display_calc matches 1.. run scoreboard players operation @s anim_end_sy = #ANIM_TARGET_SY display_calc
        execute if score #ANIM_TARGET_SY display_calc matches ..-1 run scoreboard players operation @s anim_end_sy = #ANIM_TARGET_SY display_calc
        scoreboard players operation @s anim_end_sy += #ANIM_DELTA_SY display_calc

        # 缩放 Z
        scoreboard players operation @s anim_end_sz = @s anim_start_sz
        execute if score #ANIM_TARGET_SZ display_calc matches 1.. run scoreboard players operation @s anim_end_sz = #ANIM_TARGET_SZ display_calc
        execute if score #ANIM_TARGET_SZ display_calc matches ..-1 run scoreboard players operation @s anim_end_sz = #ANIM_TARGET_SZ display_calc
        scoreboard players operation @s anim_end_sz += #ANIM_DELTA_SZ display_calc

# ===== 6.5 计算各分量"是否有变化"标志（anim_c_*=1 有变化 / 0 无变化）=====
# ★ 优化（2026-08-09）：step 每 tick 据此跳过无变化分量的插值 + 跳过旋转计算。
#   原理：end-start 的 diff 每 tick 重算是浪费——start 算一次打标志，step 每 tick 只插值有变化的分量。
#   音符场景：旋转恒为单位四元数（anim_c_rot=0 → step 直接写单位四元数，省 euler_to_quat ~59 条/实体/tick），
#   平移/缩放多数轴 end==start（无变化 → step 只 1 条 cur=start，省 ~4 条/轴）。
# 平移三轴
scoreboard players operation @s anim_c_px = @s anim_end_px
scoreboard players operation @s anim_c_px -= @s anim_start_px
execute if score @s anim_c_px matches 1.. run scoreboard players set @s anim_c_px 1
execute if score @s anim_c_px matches ..-1 run scoreboard players set @s anim_c_px 1
scoreboard players operation @s anim_c_py = @s anim_end_py
scoreboard players operation @s anim_c_py -= @s anim_start_py
execute if score @s anim_c_py matches 1.. run scoreboard players set @s anim_c_py 1
execute if score @s anim_c_py matches ..-1 run scoreboard players set @s anim_c_py 1
scoreboard players operation @s anim_c_pz = @s anim_end_pz
scoreboard players operation @s anim_c_pz -= @s anim_start_pz
execute if score @s anim_c_pz matches 1.. run scoreboard players set @s anim_c_pz 1
execute if score @s anim_c_pz matches ..-1 run scoreboard players set @s anim_c_pz 1
# 旋转三轴
scoreboard players operation @s anim_c_rx = @s anim_end_rx
scoreboard players operation @s anim_c_rx -= @s anim_start_rx
execute if score @s anim_c_rx matches 1.. run scoreboard players set @s anim_c_rx 1
execute if score @s anim_c_rx matches ..-1 run scoreboard players set @s anim_c_rx 1
scoreboard players operation @s anim_c_ry = @s anim_end_ry
scoreboard players operation @s anim_c_ry -= @s anim_start_ry
execute if score @s anim_c_ry matches 1.. run scoreboard players set @s anim_c_ry 1
execute if score @s anim_c_ry matches ..-1 run scoreboard players set @s anim_c_ry 1
scoreboard players operation @s anim_c_rz = @s anim_end_rz
scoreboard players operation @s anim_c_rz -= @s anim_start_rz
execute if score @s anim_c_rz matches 1.. run scoreboard players set @s anim_c_rz 1
execute if score @s anim_c_rz matches ..-1 run scoreboard players set @s anim_c_rz 1
# 缩放三轴
scoreboard players operation @s anim_c_sx = @s anim_end_sx
scoreboard players operation @s anim_c_sx -= @s anim_start_sx
execute if score @s anim_c_sx matches 1.. run scoreboard players set @s anim_c_sx 1
execute if score @s anim_c_sx matches ..-1 run scoreboard players set @s anim_c_sx 1
scoreboard players operation @s anim_c_sy = @s anim_end_sy
scoreboard players operation @s anim_c_sy -= @s anim_start_sy
execute if score @s anim_c_sy matches 1.. run scoreboard players set @s anim_c_sy 1
execute if score @s anim_c_sy matches ..-1 run scoreboard players set @s anim_c_sy 1
scoreboard players operation @s anim_c_sz = @s anim_end_sz
scoreboard players operation @s anim_c_sz -= @s anim_start_sz
execute if score @s anim_c_sz matches 1.. run scoreboard players set @s anim_c_sz 1
execute if score @s anim_c_sz matches ..-1 run scoreboard players set @s anim_c_sz 1
# 旋转组标志（任一旋转轴有变化 → 1；step 据此决定是否进 euler_to_quat）
scoreboard players set @s anim_c_rot 0
execute if score @s anim_c_rx matches 1 run scoreboard players set @s anim_c_rot 1
execute if score @s anim_c_ry matches 1 run scoreboard players set @s anim_c_rot 1
execute if score @s anim_c_rz matches 1 run scoreboard players set @s anim_c_rot 1

# ===== 7. 预提交位置偏移 (apply_position=1) =====
    # 在动画开始前将实体实际位置移到终点，调整 translation 保持渲染不变
    # 这样动画过程中 Pos 已在终点，translation 从补偿值过渡到 0
    # 适用于需要让其他系统在动画期间读取到正确 Pos 的场景
    execute if score @s anim_apply_position matches 1 run function rhythm_axe:utilization/display_animation/pre_commit

# ===== 8. 标记动画状态 =====

    scoreboard players set @s anim_status 1
    scoreboard players set @s anim_timer 0

# 设置步间平滑插值（展示实体在 1t 内从上一帧线性过渡到当前帧）
    data merge entity @s {interpolation_duration:1}
