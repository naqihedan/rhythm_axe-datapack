# ========== 欧拉角 → 四元数 ==========
# 读取：display_calc 记分板的半角 #ha_rx, #ha_ry, #ha_rz（半角度×10，范围 0~3599）
# 查表获得半角的正弦/余弦值至 #sin_rx, #cos_rx 等（×10000）
# 按 ZYX 顺序计算四元数，输出到 display_calc 记分板：#qx, #qy, #qz, #qw（×10000）

# ===== 1. 查表获取半角的正弦余弦 =====
# 通过 $function 宏 + storage 查三角函数表（一次性查三轴）
execute if score #ha_rx display_calc matches ..-1 run scoreboard players add #ha_rx display_calc 3600
execute if score #ha_ry display_calc matches ..-1 run scoreboard players add #ha_ry display_calc 3600
execute if score #ha_rz display_calc matches ..-1 run scoreboard players add #ha_rz display_calc 3600

data modify storage display_animation:temp angle_rx set value 0
data modify storage display_animation:temp angle_ry set value 0
data modify storage display_animation:temp angle_rz set value 0
execute store result storage display_animation:temp angle_rx int 1 run scoreboard players get #ha_rx display_calc
execute store result storage display_animation:temp angle_ry int 1 run scoreboard players get #ha_ry display_calc
execute store result storage display_animation:temp angle_rz int 1 run scoreboard players get #ha_rz display_calc
function rhythm_axe:utilization/math/trig_lookup_all with storage display_animation:temp
execute store result score #sin_rx display_calc run data get storage display_animation:trig_result sin_rx
execute store result score #cos_rx display_calc run data get storage display_animation:trig_result cos_rx
execute store result score #sin_ry display_calc run data get storage display_animation:trig_result sin_ry
execute store result score #cos_ry display_calc run data get storage display_animation:trig_result cos_ry
execute store result score #sin_rz display_calc run data get storage display_animation:trig_result sin_rz
execute store result score #cos_rz display_calc run data get storage display_animation:trig_result cos_rz

# ===== 2. 计算四元数分量 (ZYX 顺序，所有值放大 10000 倍) =====
# qx = sin_rx*cos_ry*cos_rz - cos_rx*sin_ry*sin_rz
scoreboard players operation #tmp1 display_calc = #sin_rx display_calc
scoreboard players operation #tmp1 display_calc *= #cos_ry display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const
scoreboard players operation #tmp1 display_calc *= #cos_rz display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const

scoreboard players operation #tmp2 display_calc = #cos_rx display_calc
scoreboard players operation #tmp2 display_calc *= #sin_ry display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const
scoreboard players operation #tmp2 display_calc *= #sin_rz display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const

scoreboard players operation #qx display_calc = #tmp1 display_calc
scoreboard players operation #qx display_calc -= #tmp2 display_calc

# qy = cos_rx*sin_ry*cos_rz + sin_rx*cos_ry*sin_rz
scoreboard players operation #tmp1 display_calc = #cos_rx display_calc
scoreboard players operation #tmp1 display_calc *= #sin_ry display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const
scoreboard players operation #tmp1 display_calc *= #cos_rz display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const

scoreboard players operation #tmp2 display_calc = #sin_rx display_calc
scoreboard players operation #tmp2 display_calc *= #cos_ry display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const
scoreboard players operation #tmp2 display_calc *= #sin_rz display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const

scoreboard players operation #qy display_calc = #tmp1 display_calc
scoreboard players operation #qy display_calc += #tmp2 display_calc

# qz = cos_rx*cos_ry*sin_rz - sin_rx*sin_ry*cos_rz
scoreboard players operation #tmp1 display_calc = #cos_rx display_calc
scoreboard players operation #tmp1 display_calc *= #cos_ry display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const
scoreboard players operation #tmp1 display_calc *= #sin_rz display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const

scoreboard players operation #tmp2 display_calc = #sin_rx display_calc
scoreboard players operation #tmp2 display_calc *= #sin_ry display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const
scoreboard players operation #tmp2 display_calc *= #cos_rz display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const

scoreboard players operation #qz display_calc = #tmp1 display_calc
scoreboard players operation #qz display_calc -= #tmp2 display_calc

# qw = cos_rx*cos_ry*cos_rz + sin_rx*sin_ry*sin_rz
scoreboard players operation #tmp1 display_calc = #cos_rx display_calc
scoreboard players operation #tmp1 display_calc *= #cos_ry display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const
scoreboard players operation #tmp1 display_calc *= #cos_rz display_calc
scoreboard players operation #tmp1 display_calc /= 10000 const

scoreboard players operation #tmp2 display_calc = #sin_rx display_calc
scoreboard players operation #tmp2 display_calc *= #sin_ry display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const
scoreboard players operation #tmp2 display_calc *= #sin_rz display_calc
scoreboard players operation #tmp2 display_calc /= 10000 const

scoreboard players operation #qw display_calc = #tmp1 display_calc
scoreboard players operation #qw display_calc += #tmp2 display_calc