# 交互实体统一判定入口（@s = note_interaction 交互实体，at 其位置）
# ★ 合并 @e 遍历（2026-08-09）：原 active_note 对交互实体 4 次全量遍历
#   （noteblock/plank/jukebox/concrete 判定）→ 合并为 1 次遍历，内部按类型 tag 分流。
#   各类型 tag 互斥（summon 时只打一种），判定互不影响，安全。
# ★ 自动模式（2026-08-09）：auto=1 时玩家不能判定，由 auto 接管——
#   音符盒/木板/唱片机走 auto_note（寿命=0 判大P）；混凝土走 main_concrete（内部短路 in_zone=1 逐段判P）
#   玻璃在 auto 下不判定（不判大P不扣血，仅出窗清除）→ 不匹配任何分支，静默跳过
#   ★ 性能优化（2026-09-04，O(N²) 消除）：线性音符交互实体的位置已在调用本函数前由 active_note 单独遍历 move_self 更新（使 move 全量扫描交互实体可跳过）。
execute if score auto play_state matches 1 if entity @s[tag=note_noteblock] run function rhythm_axe:play/judgement/auto_note
execute if score auto play_state matches 1 if entity @s[tag=note_plank] run function rhythm_axe:play/judgement/auto_note
execute if score auto play_state matches 1 if entity @s[tag=note_jukebox] run function rhythm_axe:play/judgement/auto_note
execute if score auto play_state matches 1 if entity @s[tag=note_concrete] run function rhythm_axe:play/judgement/main_concrete
# 手动模式（auto=0）：按类型走原判定
# ★ 性能优化（2026-09-04）：只对"进入判定窗口"的音符调用 judgement/main_plank。
#   judgement/main_plank 内部只有当寿命 <=3x 时才做 seeing_at 检测（窗口 [3x,0]），保护进入在寿命==3x+1。
#   寿命 > 3x+1（音符还在飞向判定位置）时调用这些函数纯浪费（十几条命令只算了个 3x 就退出）。
#   窗口上界 3x+1 = #proto_high 由 active_note 每 tick 全局算一次（此处直接读），寿命 <= 它才进入判定子函数。
#   （音符盒/木板判定窗口同 [3x(incl 保护), -2x/goodL]，后续由 active_note 的 windowout 处理 miss，不在此。）
execute if score auto play_state matches 0 if entity @s[tag=note_noteblock] if score @s note_life <= #proto_high play_state run function rhythm_axe:play/judgement/judgement
execute if score auto play_state matches 0 if entity @s[tag=note_plank] if score @s note_life <= #proto_high play_state run function rhythm_axe:play/judgement/main_plank
execute if score auto play_state matches 0 if entity @s[tag=note_jukebox] run function rhythm_axe:play/judgement/main_jukebox
execute if score auto play_state matches 0 if entity @s[tag=note_concrete] run function rhythm_axe:play/judgement/main_concrete
