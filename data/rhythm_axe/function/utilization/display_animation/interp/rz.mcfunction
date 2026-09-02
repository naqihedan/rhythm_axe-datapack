# 旋转Z插值子函数（仅当 @s anim_c_rz=1 有变化时被 step 调用）
# 输入：#ratio(0~10000)；@s anim_start_rz / anim_end_rz；输出：#cur_rz
scoreboard players operation #cur_rz display_calc = @s anim_start_rz
scoreboard players operation #diff display_calc = @s anim_end_rz
scoreboard players operation #diff display_calc -= @s anim_start_rz
scoreboard players operation #diff display_calc *= #ratio display_calc
scoreboard players operation #diff display_calc /= 10000 const
scoreboard players operation #cur_rz display_calc += #diff display_calc
