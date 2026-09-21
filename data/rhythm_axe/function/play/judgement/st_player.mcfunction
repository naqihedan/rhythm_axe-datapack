# 同一刻判定限制 · 单个玩家的配额（@s = 玩家）
# 前置：#proto_high（3x+1）已由 active_note 算好
# ★ st_me：临时 tag，用于在「音符上下文」里重新指代本玩家（@a[tag=st_me]）。
#   玩家串行处理（as @a 逐个），同一时刻只会有一个 st_me ⇒ 全局唯一。
# ★ #st_min：全局临时量，逐玩家串行使用（每个玩家开头重置，不跨玩家残留）
tag @s add st_me
scoreboard players set #st_min play_state 999999
# ① 命中检测 + 求本玩家本刻最小寿命
execute as @e[type=interaction,tag=note_interaction] at @s if score @s note_life <= #proto_high play_state run function rhythm_axe:play/judgement/st_probe
# ② 只扫本刻命中的音符（数量极少），放行 life == #st_min 的那一批
execute as @e[type=interaction,tag=note_interaction,tag=st_hit] at @s run function rhythm_axe:play/judgement/st_mark
tag @s remove st_me
