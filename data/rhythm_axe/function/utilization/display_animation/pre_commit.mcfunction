# ========== 预提交位置偏移 (apply_position=1) ==========
# 先将 anim_end 复制到 #cur_px→调用通用提交函数，
# 再更新 anim_start/end 为调整后的 translation 值，并重新应用 TARGET/DELTA。
# 调用方：start.mcfunction（apply_position=1 时自动调用）

# 第 1 步：将 anim_end 作为 "当前平移" 传入通用提交函数
scoreboard players operation #cur_px display_calc = @s anim_end_px
scoreboard players operation #cur_py display_calc = @s anim_end_py
scoreboard players operation #cur_pz display_calc = @s anim_end_pz
function rhythm_axe:utilization/display_animation/apply_position_offset

# 第 2 步：读取调整后的 translation 作为新的 anim_start
execute store result score @s anim_start_px run data get entity @s transformation.translation[0] 100
execute store result score @s anim_start_py run data get entity @s transformation.translation[1] 100
execute store result score @s anim_start_pz run data get entity @s transformation.translation[2] 100

# 第 3 步：重新计算 anim_end（新 start + TARGET/DELTA）
scoreboard players operation @s anim_end_px = @s anim_start_px
execute if score #ANIM_TARGET_PX display_calc matches 1.. run scoreboard players operation @s anim_end_px = #ANIM_TARGET_PX display_calc
execute if score #ANIM_TARGET_PX display_calc matches ..-1 run scoreboard players operation @s anim_end_px = #ANIM_TARGET_PX display_calc
scoreboard players operation @s anim_end_px += #ANIM_DELTA_PX display_calc

scoreboard players operation @s anim_end_py = @s anim_start_py
execute if score #ANIM_TARGET_PY display_calc matches 1.. run scoreboard players operation @s anim_end_py = #ANIM_TARGET_PY display_calc
execute if score #ANIM_TARGET_PY display_calc matches ..-1 run scoreboard players operation @s anim_end_py = #ANIM_TARGET_PY display_calc
scoreboard players operation @s anim_end_py += #ANIM_DELTA_PY display_calc

scoreboard players operation @s anim_end_pz = @s anim_start_pz
execute if score #ANIM_TARGET_PZ display_calc matches 1.. run scoreboard players operation @s anim_end_pz = #ANIM_TARGET_PZ display_calc
execute if score #ANIM_TARGET_PZ display_calc matches ..-1 run scoreboard players operation @s anim_end_pz = #ANIM_TARGET_PZ display_calc
scoreboard players operation @s anim_end_pz += #ANIM_DELTA_PZ display_calc
