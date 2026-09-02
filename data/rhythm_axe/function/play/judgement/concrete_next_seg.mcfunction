# 混凝土段落推进（@s = 混凝土交互实体；当前段已判定，进入下一段）
# ★ 末段 seg_end = -duration（非整数倍时不能继续减 density）；末段后不再推进（主调用守卫 seg_idx<seg_count）
scoreboard players add @s note_c_seg_idx 1
execute if score @s note_c_seg_idx < @s note_c_seg_count run scoreboard players operation @s note_c_seg_end -= @s note_c_density
execute if score @s note_c_seg_idx >= @s note_c_seg_count run scoreboard players operation @s note_c_seg_end = @s note_c_dur
execute if score @s note_c_seg_idx >= @s note_c_seg_count run scoreboard players operation @s note_c_seg_end *= -1 const
scoreboard players set @s note_c_seg_done 0
