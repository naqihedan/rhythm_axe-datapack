# 旋转X插值子函数（仅当 @s anim_c_rx=1 有变化时被 step 调用）
# 输入：#ratio(0~10000)；@s anim_start_rx / anim_end_rx；输出：#cur_rx
scoreboard players operation #cur_rx display_calc = @s anim_start_rx
scoreboard players operation #diff display_calc = @s anim_end_rx
scoreboard players operation #diff display_calc -= @s anim_start_rx
scoreboard players operation #diff display_calc *= #ratio display_calc
scoreboard players operation #diff display_calc /= 10000 const
scoreboard players operation #cur_rx display_calc += #diff display_calc
