# 游戏结束时执行（宏参数 mapid，with storage rhythm_axe:runtime）
#arg: mapid
# 停止背景音乐（record 通道；自动结束与手动 stop 都汇聚于此，一处覆盖）
stopsound @a record
scoreboard players set is_running play_state 0
# 移除歌曲进度条
bossbar remove rhythm_axe:song_progress
# 退出游玩状态（射线步进视线检测按此筛选玩家）
tag @a remove playing
# 收回唱片机点击 advancement
advancement revoke @a only rhythm_axe:jukebox_right_click
advancement revoke @a only rhythm_axe:jukebox_left_click
# 清除本谱面所有音符实体（展示 + 交互 + 完美判定区域 marker）
# ★ auto 补判（2026-08-09）：auto 模式保证"判到所有音符"——若谱面提前结束（end_time 早于音符
#   寿命 0）或手动 stop 时还有未判定音符，先补判大P再清除，避免漏判（auto_note 的寿命< -2x 兜底
#   只在音符活到出窗才触发；提前结束的存活音符不经过它）。限定本谱面 map_$(mapid)，不误判他谱/残留。
#   as+at @s 成对：judge 内部 playsound/particle 用 ~ ~ ~ 相对执行位置（结束时刻播放，结算前补计数）
$execute if score auto play_state matches 1 as @e[type=interaction,tag=note_interaction,tag=map_$(mapid)] at @s run scoreboard players set #judge_life play_state 0
$execute if score auto play_state matches 1 as @e[type=interaction,tag=note_interaction,tag=map_$(mapid)] at @s run function rhythm_axe:play/judgement/judge
# ★ kill 前清计分板分数：实体删除不会自动清分，需主动 reset 防 note_life 等残留
$scoreboard players reset @e[tag=map_$(mapid)]
$kill @e[tag=map_$(mapid)]
# 清理 hit_events（判定反馈存储，M2-H；音符清除时已逐个删，这里兜底清空防残留）
execute if data storage rhythm_axe:runtime hit_events run data remove storage rhythm_axe:runtime hit_events
# 还原玩家状态（按进入前模式精确还原；模式数值：0=生存 1=创造 2=冒险 3=旁观）
# 先重置 #prev_gm 防止读取失败时残留上一局的值
scoreboard players set #prev_gm play_state 0
execute if data storage rhythm_axe:runtime prev_gamemode run execute store result score #prev_gm play_state run data get storage rhythm_axe:runtime prev_gamemode
execute if score #prev_gm play_state matches 0 run gamemode survival @a
execute if score #prev_gm play_state matches 1 run gamemode creative @a
execute if score #prev_gm play_state matches 2 run gamemode adventure @a
execute if score #prev_gm play_state matches 3 run gamemode spectator @a
effect clear @a minecraft:resistance
execute as @a run attribute @s entity_interaction_range base set 3.0
clear @a minecraft:stick[item_name={"text":"小木斧lv.1","color":"green"}] 1
tick rate 20
# 结算程序（评分/展示需读 note_* 判定反馈计分板 → 必须先于计分板重建）
# ★ score_calculate 是宏函数（#arg: mapid），用 with storage 传参（读写谱面 storage 最高分）
function rhythm_axe:play/end_of_game/score_calculate with storage rhythm_axe:runtime
function rhythm_axe:play/end_of_game/result_display
# 清空 note_* 计分板残留计分项（remove+add 重建；已死亡音符的项 @e 选不中，只能重建清空）
# ★ 必须放在结算之后：remove 的同一刻后续不能再引用这些计分板（见 clear_note_scores 头部注释）
function rhythm_axe:utilization/clear_note_scores
