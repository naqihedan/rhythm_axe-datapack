# 混凝土段①：拉伸（接入 display_animation，2026-08-08）
# @s = 混凝土展示实体（summon 出生时调用）
# 运动模型（C5 四情况 → 三段 display_animation，每段保留 easing 缓动）：
#   段① t 0→m      ：头动尾停，长条从出生位置拉伸（translation 移动 + scale.z 增长）
#   段② t m→lt     ：头尾都动，长条整体平移（scale.z 恒定）
#   段③ t lt→lt+m  ：头停尾动，长条收缩到判定位置（scale.z 归零）
#   进度 t = lt - l + 2（C1：渲染延迟 2 刻，视觉到位 l=0）
# 起点 = 出生局部状态（summon 已设 translation.z=-dist+size/2、scale.z=0）
# 段①终点（t=m）：translation.z = z1 = -dist×(2lt-m)/(2lt) + size/2；scale.z = len1 = dist×m/lt
# ★ 段间衔接：display_animation/start 读实体当前 NBT 作起点 → 段②③ 自然从上一段终点继续（连续）
# ★ 朝向在实体 Rotation（不入 transformation），left_rotation 保持单位，无旋转动画
# 输入（实体计分板）：note_c_lt（note_base_life）、note_c_m（duration）、note_c_dist（|start|×100）、
#   note_c_size（size×100）、note_c_easing/power（缓动）

# 清空 display_animation 全局参数（防上一音符残留）
function rhythm_axe:utilization/display_animation/reset_globals
# 段①终点（★ 按模型分流 2026-08-09）：
#   短 hold（m<=lt，现有）：z1 = -dist×(2lt-m)/(2lt) + size/2
#   长 hold（m>lt）：center = -dist/2 + size/2（段①时长=lt，头端到位判定位置、尾端仍在出生位置）
# 长 hold 中心 = -dist/2（★ 2026-08-26 尾端往回退 size/2 → 头端到位 s/2，中心 = -d/2，不再 +size/2）
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #c2l display_calc = @s note_c_dist
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #c2l display_calc *= -1 const
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #c2l display_calc /= 2 const
# 短 hold z1 = -dist×(2lt-m)/(2lt) - size/2（★ 2026-08-26 尾端往回退：+size/2 → -size/2；必须带条件，否则覆盖长 hold 的 #c2l）
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc = @s note_c_lt
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc *= 2 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc -= @s note_c_m
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc *= @s note_c_dist
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc /= @s note_c_lt
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc /= 2 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc *= -1 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c_tmp display_calc = @s note_c_size
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c_tmp display_calc /= 2 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c2l display_calc -= #c_tmp display_calc
# 段①长度 len1（★ 2026-08-26 尾端往回退 size/2）：短=dist×m/lt、长=dist+size（头端到位 s/2 需多走 size）
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc = @s note_c_dist
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc *= @s note_c_m
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc /= @s note_c_lt
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #clen display_calc = @s note_c_dist
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #clen display_calc += @s note_c_size
# 段①时长（★ 按模型）：短=m、长=lt
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #ANIM_DURATION display_calc = @s note_c_m
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #ANIM_DURATION display_calc = @s note_c_lt
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
scoreboard players operation #ANIM_EASING display_calc = @s note_c_easing
scoreboard players operation #ANIM_POWER display_calc = @s note_c_power
# 终点：translation 只动 z（x/y 保持 0）；scale 只动 z（x/y 保持 size）
# target=0 → end=start（当前 NBT 不变）
scoreboard players set #ANIM_TARGET_PX display_calc 0
scoreboard players set #ANIM_TARGET_PY display_calc 0
scoreboard players operation #ANIM_TARGET_PZ display_calc = #c2l display_calc
scoreboard players set #ANIM_TARGET_SX display_calc 0
scoreboard players set #ANIM_TARGET_SY display_calc 0
scoreboard players operation #ANIM_TARGET_SZ display_calc = #clen display_calc
# delta / apply_position 已由 reset_globals 归零（display_animation 主入口末尾清理）
# 启动动画 + 记录当前段
tag @s add anim_task
function rhythm_axe:utilization/display_animation/display_animation
scoreboard players set @s note_c_seg 1
