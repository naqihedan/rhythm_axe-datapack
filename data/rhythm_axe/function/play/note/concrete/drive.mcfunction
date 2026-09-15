# 混凝土非线性（power≠1）每刻驱动：按「一条曲线」模型直接写 transformation（与编辑器 place_concrete 同公式）
# @s = 混凝土展示实体（concrete/tick 每刻调用）
# 输入实体计分板：note_c_dist（d×100）、note_c_size（s×100）、note_c_lt（有效寿命）、note_c_m（duration）、
#   note_c_easing/note_c_power（缓动）、note_life（寿命）
# 输出：transformation.translation[2]（中心）、scale[2]（长度）；#hp = 头端进度（0..lt，单位刻）
#   （#hp 供 concrete/tick 算交互实体跟随头端；此处直接写好，tick 里非线性分支不再重算）

# ---- 常量（×100）----
scoreboard players operation #cdtot display_calc = @s note_c_dist
scoreboard players operation #cdtot display_calc += @s note_c_size
scoreboard players operation #chalf display_calc = @s note_c_size
scoreboard players operation #chalf display_calc /= 2 const
scoreboard players operation #cp0 display_calc = #cdtot display_calc
scoreboard players operation #cp0 display_calc *= -1 const
scoreboard players operation #cp0 display_calc += #chalf display_calc
# ---- t = lt - life + 2（渲染延迟 2 刻）----
scoreboard players operation #cn display_calc = @s note_c_lt
scoreboard players operation #cn display_calc -= @s note_life
scoreboard players operation #cn display_calc += 2 const
# ---- 头端进度 g ----
scoreboard players operation #n display_calc = #cn display_calc
execute if score #n display_calc matches ..0 run scoreboard players set #n display_calc 0
scoreboard players operation #total display_calc = @s note_c_lt
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
scoreboard players operation #power display_calc = @s note_c_power
scoreboard players operation #easing_type display_calc = @s note_c_easing
function rhythm_axe:utilization/display_animation/easing/power
scoreboard players operation #cg display_calc = #ratio display_calc
# ---- 尾端进度 gt（同一条曲线，延后 m 刻）----
scoreboard players operation #n display_calc = #cn display_calc
scoreboard players operation #n display_calc -= @s note_c_m
execute if score #n display_calc matches ..0 run scoreboard players set #n display_calc 0
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
function rhythm_axe:utilization/display_animation/easing/power
scoreboard players operation #cgt display_calc = #ratio display_calc
# ---- 长度（×100）= Δ(g-gt)/10000 ----
scoreboard players operation #clen2 display_calc = #cg display_calc
scoreboard players operation #clen2 display_calc -= #cgt display_calc
scoreboard players operation #clen2 display_calc *= #cdtot display_calc
scoreboard players operation #clen2 display_calc /= 10000 const
execute if score #clen2 display_calc matches ..0 run scoreboard players set #clen2 display_calc 0
# ---- 中心（×100）= P0 + Δ(g+gt)/20000 ----
scoreboard players operation #ctz2 display_calc = #cg display_calc
scoreboard players operation #ctz2 display_calc += #cgt display_calc
scoreboard players operation #ctz2 display_calc *= #cdtot display_calc
scoreboard players operation #ctz2 display_calc /= 20000 const
scoreboard players operation #ctz2 display_calc += #cp0 display_calc
# ---- 头端进度 #hp（0..lt，单位刻）= lt×g/10000 ----
scoreboard players operation #hp display_calc = #cg display_calc
scoreboard players operation #hp display_calc *= @s note_c_lt
scoreboard players operation #hp display_calc /= 10000 const
# ---- 写 NBT（平移只动 z；scale[0/1] 保持原值）----
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #clen2 display_calc
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #ctz2 display_calc
# ---- 段标记（调试）：1=拉伸 / 2=平移或静止 / 3=收缩 ----
scoreboard players set @s note_c_seg 1
execute if score #cn display_calc > @s note_c_m run scoreboard players set @s note_c_seg 2
execute if score #cn display_calc >= @s note_c_lt run scoreboard players set @s note_c_seg 3
