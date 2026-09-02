# 编辑器引导线每刻入口：计算 m = playhead - time_prev、n = note_guide_n，再按 m 分支绘制或清除
# @s = editor_guide item_display；note_guide_a/b 分别为前一个和当前音符 id
scoreboard players operation #ga editor = @s note_guide_a
scoreboard players operation #gb editor = @s note_guide_b
scoreboard players operation #m editor = #playhead editor
scoreboard players operation #m editor -= @s note_guide_tp
scoreboard players operation #n editor = @s note_guide_n
# ★ n<0（B 在 A 之前判定）才 kill；n==0（同刻音符）保留 → 靠 m>=n 判定，m>=0 时自然消失
execute if score #n editor matches ..-1 run kill @s
execute if score #m editor >= #n editor run kill @s
# A 显示条件 = A 音符实体存在（已出生）或播放头已到 A 判定时刻（m>=0，实体可能已消失但仍用判定快照绘制）
# 修复：A 实体在判定时刻(=A.time)被击杀，不能再用"实体存在"当显示条件，否则 A 一消失引导线就没了
scoreboard players set #a_show editor 0
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #ga editor run scoreboard players set #a_show editor 1
execute if score #m editor matches 0.. run scoreboard players set #a_show editor 1
execute if score #a_show editor matches 0 run data modify entity @s transformation.scale[2] set value 0.0f
execute if score #a_show editor matches 0 run return 0
execute unless score #m editor >= #n editor run function rhythm_axe:editor/visual/guide_tick_body
