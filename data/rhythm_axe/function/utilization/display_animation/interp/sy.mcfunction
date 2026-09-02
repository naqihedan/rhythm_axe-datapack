# 缩放Y插值子函数（仅当 @s anim_c_sy=1 有变化时被 step 调用）
# 输入：#ratio(0~10000)；@s anim_start_sy / anim_end_sy；输出：#cur_sy
scoreboard players operation #cur_sy display_calc = @s anim_start_sy
scoreboard players operation #diff display_calc = @s anim_end_sy
scoreboard players operation #diff display_calc -= @s anim_start_sy
scoreboard players operation #diff display_calc *= #ratio display_calc
scoreboard players operation #diff display_calc /= 10000 const
scoreboard players operation #cur_sy display_calc += #diff display_calc
