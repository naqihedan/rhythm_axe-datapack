# 交互实体统一判定入口（@s = note_interaction 交互实体，at 其位置）
# ★ 合并 @e 遍历（2026-08-09）：原 active_note 对交互实体 4 次全量遍历
#   （noteblock/plank/jukebox/concrete 判定）→ 合并为 1 次遍历，内部按类型 tag 分流。
#   各类型 tag 互斥（summon 时只打一种），判定互不影响，安全。
# ★ 自动模式（2026-08-09）：auto=1 时玩家不能判定，由 auto 接管——
#   音符盒/木板/唱片机走 auto_note（寿命=0 判大P）；混凝土走 main_concrete（内部短路 in_zone=1 逐段判P）
#   玻璃在 auto 下不判定（不判大P不扣血，仅出窗清除）→ 不匹配任何分支，静默跳过
execute if score auto play_state matches 1 if entity @s[tag=note_noteblock] run function rhythm_axe:play/judgement/auto_note
execute if score auto play_state matches 1 if entity @s[tag=note_plank] run function rhythm_axe:play/judgement/auto_note
execute if score auto play_state matches 1 if entity @s[tag=note_jukebox] run function rhythm_axe:play/judgement/auto_note
execute if score auto play_state matches 1 if entity @s[tag=note_concrete] run function rhythm_axe:play/judgement/main_concrete
# 手动模式（auto=0）：按类型走原判定
execute if score auto play_state matches 0 if entity @s[tag=note_noteblock] run function rhythm_axe:play/judgement/judgement
execute if score auto play_state matches 0 if entity @s[tag=note_plank] run function rhythm_axe:play/judgement/main_plank
execute if score auto play_state matches 0 if entity @s[tag=note_jukebox] run function rhythm_axe:play/judgement/main_jukebox
execute if score auto play_state matches 0 if entity @s[tag=note_concrete] run function rhythm_axe:play/judgement/main_concrete
