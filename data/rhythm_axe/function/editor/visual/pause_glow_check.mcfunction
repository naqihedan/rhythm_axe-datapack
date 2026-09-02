# 暂停补亮橙光（单实体调用）：@s=音符展示实体；若正处于判定时刻则亮橙光
# 播放中判定只播音效/粒子（橙光不亮）；暂停后补亮提示判定时刻
# 只亮不播（不调 trigger_，不推 seg）；普通=playhead==time；混凝土=段边界 rel==seg×density 且 rel≤dur
# ★ 单实体写→判（#rel/#st 共享假玩家，多实体串扰需每实体独立函数）
execute if score @s editor_n_type matches 0..2 if score #playhead editor = @s editor_n_time run data modify entity @s Glowing set value 1b
execute if score @s editor_n_type matches 0..2 if score #playhead editor = @s editor_n_time run data modify entity @s glow_color_override set value 16766720
execute if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run scoreboard players operation #rel editor = #playhead editor
execute if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run scoreboard players operation #rel editor -= @s editor_n_time
execute if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run scoreboard players operation #st editor = @s editor_n_seg
execute if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run scoreboard players operation #st editor *= @s editor_n_density
execute if score #st editor > @s editor_n_dur run scoreboard players operation #st editor = @s editor_n_dur
execute if score @s editor_n_type matches 3 if score @s editor_n_seg <= @s editor_n_seg_count if score #rel editor = #st editor if score #rel editor <= @s editor_n_dur run data modify entity @s Glowing set value 1b
execute if score @s editor_n_type matches 3 if score @s editor_n_seg <= @s editor_n_seg_count if score #rel editor = #st editor if score #rel editor <= @s editor_n_dur run data modify entity @s glow_color_override set value 16766720
