# 平移Y插值子函数（仅当 @s anim_c_py=1 有变化时被 step 调用）
# 输入：#ratio(0~10000)；@s anim_start_py / anim_end_py；输出：#cur_py
scoreboard players operation #cur_py display_calc = @s anim_start_py
scoreboard players operation #diff display_calc = @s anim_end_py
scoreboard players operation #diff display_calc -= @s anim_start_py
scoreboard players operation #diff display_calc *= #ratio display_calc
scoreboard players operation #diff display_calc /= 10000 const
scoreboard players operation #cur_py display_calc += #diff display_calc
