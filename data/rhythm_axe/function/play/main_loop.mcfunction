# 游玩主循环：schedule 自循环，每 tick 推进一局游戏
# 由 start_of_game/start 启动；is_running == 0 时不再调度（链断）

# 运行检查
execute if score is_running play_state matches 0 run return fail

# 时间推进（音乐时间轴，time == 0 为音乐起点）
scoreboard players add time play_state 1

# 音乐播放：time 推进到 0 时播放谱面 music（time 从 -1 起单调递增，0 恰好经过一次，天然只触发一次）
execute if score time play_state matches 0 if data storage rhythm_axe:runtime music run function rhythm_axe:play/start_of_game/play_music with storage rhythm_axe:runtime

# 歌曲进度条更新（每 tick；value = time - 时间起点）
scoreboard players operation #sv play_state = time play_state
scoreboard players operation #sv play_state -= #song_start play_state
execute if score song_progress_display options matches 1 run execute store result storage rhythm_axe:runtime bp int 1 run scoreboard players get #sv play_state
execute if score song_progress_display options matches 1 run function rhythm_axe:play/note/song_progress/bossbar_value with storage rhythm_axe:runtime

# 结束点检查：若定义了 end_time 且 time == end_time → 立即结束（跳过本刻剩余处理）
scoreboard players set #end_time play_state 0
execute if data storage rhythm_axe:runtime end_time run execute store result score #end_time play_state run data get storage rhythm_axe:runtime end_time
execute if data storage rhythm_axe:runtime end_time if score time play_state = #end_time play_state run function rhythm_axe:play/end_of_game/end_of_game with storage rhythm_axe:runtime
execute if data storage rhythm_axe:runtime end_time if score time play_state = #end_time play_state run return fail

# timing_point 推进：若 #timing_cursor 指向的时间点 time == time → 更新 tick rate 与判定缩放，光标+1
execute store result storage rhythm_axe:runtime tp_idx int 1 run scoreboard players get #timing_cursor play_state
function rhythm_axe:play/timing/advance with storage rhythm_axe:runtime

# 音符生成：若 #note_cursor 指向音符的出生时刻 == time → 生成，光标+1，继续检查同一刻
execute store result storage rhythm_axe:runtime note_idx int 1 run scoreboard players get #note_cursor play_state
function rhythm_axe:play/note/spawn with storage rhythm_axe:runtime

# 活跃音符处理（移动；寿命/判定/保护/出窗 里程碑2 后续接入）
function rhythm_axe:play/active_note/active_note

# 音符判定反馈（里程碑2）

# 指令事件推进：若 #event_cursor 指向的事件 time == time → 执行其 commands，光标+1，递归检查同一刻
# （仿 timing/advance：宏参数 ev_idx = #event_cursor；commands 逐条由 event/execute 递归执行）
execute store result storage rhythm_axe:runtime ev_idx int 1 run scoreboard players get #event_cursor play_state
function rhythm_axe:play/event/advance with storage rhythm_axe:runtime

# 调度下一次
schedule function rhythm_axe:play/main_loop 1t
