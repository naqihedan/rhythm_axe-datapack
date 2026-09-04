# 游戏开始前执行（每次一局游戏开始时调用）
# 初始化 play_state 计分板（游玩状态）并计算 time 起点
# 谱面数据需已复制到 rhythm_axe:runtime（由 start_of_game/start 完成）

scoreboard objectives add play_state dummy

# 运行标记（结束游戏时置 0）
scoreboard players set is_running play_state 1

# 时间起点：time = min(0, 所有音符里最早的出生时刻) - 1

    # 先扫描最早出生（遍历 notes，含自动计算），再换算
        scoreboard players set #earliest_birth play_state 1000000
        scoreboard players set #scan_index play_state 0
        execute store result storage rhythm_axe:runtime scan_idx int 1 run scoreboard players get #scan_index play_state
        scoreboard players set #dbg play_state 7
        function rhythm_axe:play/start_of_game/scan_birth with storage rhythm_axe:runtime
        scoreboard players set #dbg play_state 8

    # 按出生时刻升序排序音符（保证游标生成正确：同 time 不同 note_base_life 时出生顺序可能与数组顺序不一致）
        # ★ 2026-09-05 启用排序：改为跨多刻 schedule 驱动（sort_notes 内部启动链），
        #   意在解决桶排序 range=954 时单刻命令数爆 200000。排序完成后由 finish 启动 main_loop。
        scoreboard players set #dbg play_state 9
        function rhythm_axe:play/start_of_game/sort_notes
        scoreboard players set #dbg play_state 10

    # ★ 2026-08-14 修复"没有音符生成"：earliest ≤ 0（如 -16）时 time 之前只减 1（=-1），
    #   最早出生永远等不到 → 游标卡在第一个音符 → 一个音符都不生成。
    #   正确起点 = min(0, earliest) - 1（见本函数头注释）；先清零防上一局残留
    #   （time=end_time 时新局立即结束）。
    scoreboard players set time play_state 0
    execute if score #earliest_birth play_state matches ..0 run scoreboard players operation time play_state = #earliest_birth play_state
    scoreboard players remove time play_state 1

# 三条时间线游标
scoreboard players set #note_cursor play_state 0
scoreboard players set #timing_cursor play_state 0
scoreboard players set #event_cursor play_state 0
# 音符间引导线："上一个 0/1/2 音符"指针（-1 = 无上一个；3/4 不参与引导线）
scoreboard players set #guide_last_id play_state -1

# 判定相关计数
    # 当前判定缩放
    scoreboard players set #judgement_scale play_state 1

    # 生命（来自谱面 health 字段）
    execute store result score health play_state run data get storage rhythm_axe:runtime health
    # 伤害扣血冷却（0 = 可扣血；扣血后 = damage_cooldown，每刻递减，M2-G）
    scoreboard players set damage_cooldown play_state 0

    # 判定计数
    scoreboard players set perfect play_state 0
    scoreboard players set perfect_early play_state 0
    scoreboard players set perfect_late play_state 0
    scoreboard players set good play_state 0
    scoreboard players set good_early play_state 0
    scoreboard players set good_late play_state 0
    scoreboard players set bad play_state 0
    scoreboard players set miss play_state 0

    # combo
    scoreboard players set combo play_state 0
    scoreboard players set max_combo play_state 0

    # FC/AP（0=无 1=FC 2=AP）
    scoreboard players set fc_ap play_state 2
    
    # 分数（最高分保留）
    scoreboard players set score play_state 0

# ===== 歌曲进度条（bossbar；设置 song_progress_display / song_progress_color）=====
# max = end_time - 时间起点（time 初始 = 最早出生-1）；value = time - 时间起点（main_loop 每 tick 更新）
scoreboard players operation #song_start play_state = time play_state
scoreboard players set #song_max play_state 0
execute if data storage rhythm_axe:runtime end_time run execute store result score #song_max play_state run data get storage rhythm_axe:runtime end_time
scoreboard players operation #song_max play_state -= #song_start play_state
execute if score song_progress_display options matches 1 run function rhythm_axe:play/note/song_progress/bossbar_init with storage rhythm_axe:runtime
execute if score song_progress_display options matches 1 run bossbar set rhythm_axe:song_progress players @a
execute if score song_progress_display options matches 1 run bossbar set rhythm_axe:song_progress value 0
execute if score song_progress_display options matches 1 run execute store result storage rhythm_axe:runtime bp int 1 run scoreboard players get #song_max play_state
execute if score song_progress_display options matches 1 run function rhythm_axe:play/note/song_progress/bossbar_max with storage rhythm_axe:runtime
# 颜色映射（song_progress_color：0白 1粉 2蓝 3红 4绿 5黄 6紫）
execute if score song_progress_display options matches 1 if score song_progress_color options matches 0 run bossbar set rhythm_axe:song_progress color white
execute if score song_progress_display options matches 1 if score song_progress_color options matches 1 run bossbar set rhythm_axe:song_progress color pink
execute if score song_progress_display options matches 1 if score song_progress_color options matches 2 run bossbar set rhythm_axe:song_progress color blue
execute if score song_progress_display options matches 1 if score song_progress_color options matches 3 run bossbar set rhythm_axe:song_progress color red
execute if score song_progress_display options matches 1 if score song_progress_color options matches 4 run bossbar set rhythm_axe:song_progress color green
execute if score song_progress_display options matches 1 if score song_progress_color options matches 5 run bossbar set rhythm_axe:song_progress color yellow
execute if score song_progress_display options matches 1 if score song_progress_color options matches 6 run bossbar set rhythm_axe:song_progress color purple
