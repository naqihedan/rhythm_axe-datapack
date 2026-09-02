# ========== 通用提交位置偏移（commit_pos） ==========
# 将平移动画的偏移量  (#cur_px/y/z - anim_start_px/y/z) 提交到实体实际坐标 Pos，
# 并调整 translation 保持渲染位置不变。
# 由以下场景共用（#cur_px 在调用前设置好）：
#   - finish (mode=2, 动画后提交): #cur_px 来自 step 的最终插值
#   - pre_commit (mode=1, 动画前提交): #cur_px 由调用者设为 anim_end

# 先设瞬切，防止之前残留的 interpolation_duration 导致 NBT 修改被插值
data merge entity @s {interpolation_duration:0}

# 读取当前 translation 到 storage（保留未变化轴的原始值）
execute store result storage display_animation:transform translation[0] float 0.01 run data get entity @s transformation.translation[0] 100
execute store result storage display_animation:transform translation[1] float 0.01 run data get entity @s transformation.translation[1] 100
execute store result storage display_animation:transform translation[2] float 0.01 run data get entity @s transformation.translation[2] 100

# ===== X 轴 =====
scoreboard players operation #cmt_ox display_calc = #cur_px display_calc
scoreboard players operation #cmt_ox display_calc -= @s anim_start_px
execute unless score #cmt_ox display_calc matches 0 run execute store result score #cmt_px display_calc run data get entity @s Pos[0] 100
execute unless score #cmt_ox display_calc matches 0 run scoreboard players operation #cmt_px display_calc += #cmt_ox display_calc
execute unless score #cmt_ox display_calc matches 0 run execute store result entity @s Pos[0] double 0.01 run scoreboard players get #cmt_px display_calc
execute unless score #cmt_ox display_calc matches 0 run execute store result score #cmt_tx display_calc run data get entity @s transformation.translation[0] 100
execute unless score #cmt_ox display_calc matches 0 run scoreboard players operation #cmt_tx display_calc -= #cmt_ox display_calc
execute unless score #cmt_ox display_calc matches 0 run execute store result storage display_animation:transform translation[0] float 0.01 run scoreboard players get #cmt_tx display_calc

# ===== Y 轴 =====
scoreboard players operation #cmt_oy display_calc = #cur_py display_calc
scoreboard players operation #cmt_oy display_calc -= @s anim_start_py
execute unless score #cmt_oy display_calc matches 0 run execute store result score #cmt_py display_calc run data get entity @s Pos[1] 100
execute unless score #cmt_oy display_calc matches 0 run scoreboard players operation #cmt_py display_calc += #cmt_oy display_calc
execute unless score #cmt_oy display_calc matches 0 run execute store result entity @s Pos[1] double 0.01 run scoreboard players get #cmt_py display_calc
execute unless score #cmt_oy display_calc matches 0 run execute store result score #cmt_ty display_calc run data get entity @s transformation.translation[1] 100
execute unless score #cmt_oy display_calc matches 0 run scoreboard players operation #cmt_ty display_calc -= #cmt_oy display_calc
execute unless score #cmt_oy display_calc matches 0 run execute store result storage display_animation:transform translation[1] float 0.01 run scoreboard players get #cmt_ty display_calc

# ===== Z 轴 =====
scoreboard players operation #cmt_oz display_calc = #cur_pz display_calc
scoreboard players operation #cmt_oz display_calc -= @s anim_start_pz
execute unless score #cmt_oz display_calc matches 0 run execute store result score #cmt_pz display_calc run data get entity @s Pos[2] 100
execute unless score #cmt_oz display_calc matches 0 run scoreboard players operation #cmt_pz display_calc += #cmt_oz display_calc
execute unless score #cmt_oz display_calc matches 0 run execute store result entity @s Pos[2] double 0.01 run scoreboard players get #cmt_pz display_calc
execute unless score #cmt_oz display_calc matches 0 run execute store result score #cmt_tz display_calc run data get entity @s transformation.translation[2] 100
execute unless score #cmt_oz display_calc matches 0 run scoreboard players operation #cmt_tz display_calc -= #cmt_oz display_calc
execute unless score #cmt_oz display_calc matches 0 run execute store result storage display_animation:transform translation[2] float 0.01 run scoreboard players get #cmt_tz display_calc

# 批量写入 translation
data modify entity @s transformation.translation set from storage display_animation:transform translation