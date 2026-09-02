# 引导线每刻入口：先计算 m = time - time_prev、n = note_guide_n，再按 m 分支绘制或清除
# @s = 引导线展示实体（note_guide；active_note 每刻遍历调用）
# 设计（用户 2026-08-30 定稿）：
#   m<0（前一个音符未到判定时刻）→ 长度 = 两音符当前距离（A=前音符实时位置）
#   0<=m<n → 长度 = l×(n-m)/n（l = 后音符到前判定点距离，A=前判定位置快照），m=n 时归零消失
scoreboard players operation #ga play_state = @s note_guide_a
scoreboard players operation #gb play_state = @s note_guide_b
scoreboard players operation #m play_state = time play_state
scoreboard players operation #m play_state -= @s note_guide_tp
scoreboard players operation #n play_state = @s note_guide_n
# ★ n<0（B 在 A 之前判定）才 kill；n==0（同刻音符）保留 → 靠 m>=n 判定，m>=0 时自然消失
execute if score #n play_state matches ..-1 run kill @s
execute if score #m play_state >= #n play_state run kill @s
execute unless score #m play_state >= #n play_state run function rhythm_axe:play/note/guide/tick_body
