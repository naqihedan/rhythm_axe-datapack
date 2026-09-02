# 平移X插值子函数（仅当 @s anim_c_px=1 有变化时被 step 调用）
# 输入：#ratio(0~10000)；@s anim_start_px / anim_end_px；输出：#cur_px
# ★ 优化（2026-08-09）：end≠start 才调用本函数；无变化分量由 step 直接取 anim_start（省 5 条/分量/tick）
# 有变化保证 diff≠0，故省略原 unless 保护（标志由 start 计算，可靠）
scoreboard players operation #cur_px display_calc = @s anim_start_px
scoreboard players operation #diff display_calc = @s anim_end_px
scoreboard players operation #diff display_calc -= @s anim_start_px
scoreboard players operation #diff display_calc *= #ratio display_calc
scoreboard players operation #diff display_calc /= 10000 const
scoreboard players operation #cur_px display_calc += #diff display_calc
