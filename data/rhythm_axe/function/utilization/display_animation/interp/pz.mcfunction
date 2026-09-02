# 平移Z插值子函数（仅当 @s anim_c_pz=1 有变化时被 step 调用）
# 输入：#ratio(0~10000)；@s anim_start_pz / anim_end_pz；输出：#cur_pz
scoreboard players operation #cur_pz display_calc = @s anim_start_pz
scoreboard players operation #diff display_calc = @s anim_end_pz
scoreboard players operation #diff display_calc -= @s anim_start_pz
scoreboard players operation #diff display_calc *= #ratio display_calc
scoreboard players operation #diff display_calc /= 10000 const
scoreboard players operation #cur_pz display_calc += #diff display_calc
