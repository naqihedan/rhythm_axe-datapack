# 同一刻判定限制 · 单个玩家的配额（@s = 玩家）
# 前置：#proto_high（3x+1）已由 active_note 算好
# ★ st_me：临时 tag，用于在「音符上下文」里重新指代本玩家（@a[tag=st_me]）。
#   玩家串行处理（as @a 逐个），同一时刻只会有一个 st_me ⇒ 全局唯一。
# ★ #st_min：全局临时量，逐玩家串行使用（每个玩家开头重置，不跨玩家残留）
#   ★ 2026-09-26：只有「life > 0 的音符盒」会更新它（见 st_probe）
tag @s add st_me
# ★ 2026-09-26 判定延迟补偿：本玩家要回退几刻（= (RTT+30)/50 整数除，钳制 0..4）
#   基准点取 20ms：RTT ≥ 20ms 就退 1 刻，之后每多 50ms 再退 1 刻（偏「宁可多退」一侧）
#   来源 = mod 每秒写的计分板 net（该玩家 RTT 毫秒）；options.judge_lag_comp=0 可整体关掉。
#   计分项缺失（没装 mod / 旧数据包）时 #st_rtt 保持哨兵 -100 ⇒ 下界钳成 0 = 不补偿，行为同补偿前。
scoreboard players set #st_rtt play_state -100
# ★ 用 `if score` 而不是 `store result … scoreboard players get`：后者在「该玩家在 net 里没有分」时
#   会报“取不到分数”并刷日志（房主没装 mod 时每人每刻一条）；if score 只是不匹配、静默跳过 ⇒ 哨兵 -100 保留
#   ★ 2026-09-26 判定延迟补偿：本玩家要回退几刻（= (RTT+30)/50 整数除，钳制 0..4）
execute if score judge_lag_comp options matches 1 if score @s net matches -2147483648.. run scoreboard players operation #st_rtt play_state = @s net
# ★ 2026-09-26 手动覆盖：lag_rtt_manual 有分（≥0）时代替自动读到的 RTT（单位同为毫秒）
#   用于「房主没装 mod 读不到 RTT」或想现场 A/B 调参：/scoreboard players set <玩家> lag_rtt_manual <毫秒>
#   （0 = 该玩家不补偿；不设 = 自动。整体开关 judge_lag_comp=0 时手动值也不生效）
execute if score judge_lag_comp options matches 1 if score @s lag_rtt_manual matches 0.. run scoreboard players operation #st_rtt play_state = @s lag_rtt_manual
scoreboard players operation #st_lag play_state = #st_rtt play_state
# +30 而非 +25：四舍五入的基准从 25ms 挪到 20ms（20/70/120/170ms 是 1/2/3/4 刻的临界点）
scoreboard players add #st_lag play_state 30
scoreboard players operation #st_lag play_state /= 50 const
execute if score #st_lag play_state matches ..0 run scoreboard players set #st_lag play_state 0
execute if score #st_lag play_state matches 5.. run scoreboard players set #st_lag play_state 4
scoreboard players set #st_min play_state 999999
# ① 命中检测 + 求本玩家本刻最小寿命
execute as @e[type=interaction,tag=note_interaction] at @s if score @s note_life <= #proto_high play_state run function rhythm_axe:play/judgement/st_probe
# ② 只扫本刻命中的音符（数量极少），放行 life == #st_min 的那一批
execute as @e[type=interaction,tag=note_interaction,tag=st_hit] at @s run function rhythm_axe:play/judgement/st_mark
# ★ 2026-09-26 判定延迟补偿：本玩家退场前还原被他回退过的判定箱。
#   必须在**每个玩家**结束时还原（不能只在 same_tick 末尾）——否则 #st_lag=0 的房主
#   如果排在客机后面，就会拿客机回退过的位置去测（遍历顺序是任意的）。
#   还原后位置 = 「当前刻视觉位置」，也是 interact_judge 判完反馈要用的位置。
scoreboard players set #lag_extra play_state 0
execute as @e[type=interaction,tag=st_lag_moved] run function rhythm_axe:play/judgement/st_lag_restore
tag @e[type=interaction,tag=st_lag_moved] remove st_lag_moved
tag @s remove st_me
