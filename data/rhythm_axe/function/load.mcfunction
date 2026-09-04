# 初始化整个数据包
# 会将整个数据包的属性进行重置
#====================常量====================
scoreboard objectives add const dummy
scoreboard players set 1 const 1
scoreboard players set 0 const 0
scoreboard players set -1 const -1
scoreboard players set -2 const -2
scoreboard players set 2 const 2
scoreboard players set 3 const 3
scoreboard players set 4 const 4
scoreboard players set 5 const 5
scoreboard players set 7 const 7
scoreboard players set 10 const 10
scoreboard players set 15 const 15
scoreboard players set 6 const 6
scoreboard players set 8 const 8
scoreboard players set 9 const 9
scoreboard players set 12 const 12
scoreboard players set 16 const 16
scoreboard players set 18 const 18
scoreboard players set 20 const 20
scoreboard players set 24 const 24
scoreboard players set 32 const 32
scoreboard players set 40 const 40
scoreboard players set 49 const 49
scoreboard players set 50 const 50
scoreboard players set 4096 const 4096

scoreboard players set 100 const 100
scoreboard players set 1000 const 1000
scoreboard players set 860 const 860
scoreboard players set 360 const 360
scoreboard players set 3600 const 3600
# 玻璃扫掠 CCD 采样步数阈值（(N×50)² = (N×0.5 格 ×100)²；glass_sweep 查表定 N，避免每玻璃每刻调 sqrt）
scoreboard players set 2500 const 2500
scoreboard players set 10000 const 10000
scoreboard players set 22500 const 22500
scoreboard players set 40000 const 40000
scoreboard players set 62500 const 62500
scoreboard players set 90000 const 90000
scoreboard players set 122500 const 122500
scoreboard players set 160000 const 160000
scoreboard players set 202500 const 202500
scoreboard players set 250000 const 250000
scoreboard players set 302500 const 302500
scoreboard players set 360000 const 360000
scoreboard players set 422500 const 422500
scoreboard players set 490000 const 490000
scoreboard players set 562500 const 562500
scoreboard players set 5000 const 5000
scoreboard players set 10000 const 10000
scoreboard players set 2812 const 2812
scoreboard players set 10006 const 10006
scoreboard players set 15708 const 15708
# π/180×10000 ≈ 174.533（度→弧度×10000 换算，轴角旋转快路径用）
scoreboard players set 17453 const 17453
scoreboard players set 57296 const 57296
scoreboard players set 100000 const 100000
scoreboard players set -10 const -10
scoreboard players set -100 const -100
scoreboard players set 180 const 180
scoreboard players set -180 const -180

#====================展示实体动画系统====================
function rhythm_axe:utilization/display_animation/init


#====================判定反馈组表====================
function rhythm_axe:play/feedback/init


#====================游玩状态====================
scoreboard objectives add play_state dummy
scoreboard objectives add score_calculate dummy
scoreboard objectives add options dummy
# mods 计分板（玩家开始游戏前设置的 mod 开关；start 时复制到 play_state 同名项）
#   auto：1=自动模式（auto 接管判定，玩家不能判定）
scoreboard objectives add mods dummy
# 运行期 auto 标记（start 从 mods.auto 复制；判定系统读取）
scoreboard players set auto play_state 0
# is_running 初始化：防上次游玩未正常走完 end_of_game（自动结束未到/退出/重载）导致残留 1，
#   之后 start_of_game 误判“已有谱面在运行”而无法重开。重载时旧 main_loop 链会因 is_running=0 自动断开。
scoreboard players set is_running play_state 0
# 音符间引导线两端音符 id（引导线展示实体存储：note_guide_a = 前一个、note_guide_b = 当前；清除配对用）
scoreboard objectives add note_guide_a dummy
scoreboard objectives add note_guide_b dummy
scoreboard objectives add note_guide_x dummy
scoreboard objectives add note_guide_y dummy
scoreboard objectives add note_guide_z dummy
# 当前音符（B）出生点（×100；B 未出生时引导线连此点）
scoreboard objectives add note_guide_sx dummy
scoreboard objectives add note_guide_sy dummy
scoreboard objectives add note_guide_sz dummy
# 引导线时间参数（note_guide_tp = 前一个音符判定时刻、note_guide_n = 两音符判定时刻差）
scoreboard objectives add note_guide_tp dummy
scoreboard objectives add note_guide_n dummy
# 音符判定时刻（每个音符展示实体/交互实体存储自己的 data.time；引导线用）
scoreboard objectives add note_time dummy
# 音符实体配对用（展示实体与交互实体各存自己的 note_id）
scoreboard objectives add note_id dummy
# 音符寿命（交互实体存储，每刻递减，M2-B）
scoreboard objectives add note_life dummy
# 判定保护状态与记录寿命（交互实体存储，M2-C）
scoreboard objectives add note_protect dummy
scoreboard objectives add note_recorded_life dummy
# 音符活跃标记（出生 tick 不递减，M2-C）
scoreboard objectives add note_active dummy
# 展示实体"上一刻视觉位置"（交互实体解耦延迟用，每实体存储 ×100，M2-C）
scoreboard objectives add note_prev_x dummy
scoreboard objectives add note_prev_y dummy
scoreboard objectives add note_prev_z dummy
# 通用实体点击标记（交互实体存储，advancement 触发 + UUID 匹配后 +1；唱片机判定等消费，M2-E）
scoreboard objectives add interacted dummy
# 混凝土长条移动参数（展示实体存储；交互实体 note_c_m 仅保留信息，出窗已改用 -note_c_dur。M2-F：concrete_move 每 tick 驱动）
#   note_c_sx/sy/sz = 起始偏移×100；note_c_lt = note_base_life；note_c_m = duration（尾开始移动时刻）；note_c_dist = |start_pos|×100
scoreboard objectives add note_c_sx dummy
scoreboard objectives add note_c_sy dummy
scoreboard objectives add note_c_sz dummy
scoreboard objectives add note_c_lt dummy
scoreboard objectives add note_c_m dummy
scoreboard objectives add note_c_dist dummy
scoreboard objectives add note_c_size dummy
# ★ 阶段A（性能轮）：展示实体 Pos/scale 快照（move 读计分板替代 data get entity）
scoreboard objectives add note_base_x dummy
scoreboard objectives add note_base_y dummy
scoreboard objectives add note_base_z dummy
scoreboard objectives add note_half_size dummy
scoreboard objectives add note_cur_tz dummy
# 阶段C 线性客户端插值（统一模型，2026-08-08 重写 / 2026-08-14 修订）：note_lin_dur = 插值时长 D
#   （普通=lt-2、玻璃=lt+dur-2：出生→终点隔 2 tick 且插值时钟从终点到达时开始，补偿渲染延迟1刻+间隔1刻）；
#   note_lin_t = 插值进度（0 起每 tick +1，move 算交互位置用）；note_lin_end = 终点 end×100（普通 0，玻璃 dist×dur/lt）
#   由 play/note/motion/init 设置、motion/start 与 active_note/move 消费（普通 0/1/2 与玻璃 4 共用）
scoreboard objectives add note_lin_dur dummy
scoreboard objectives add note_lin_t dummy
scoreboard objectives add note_lin_end dummy
scoreboard objectives add note_lin_sz_end dummy
# 混凝土 display_animation 分段（展示实体存储，concrete/init·seg2·seg3 用）：note_c_seg = 当前段（1 拉伸/2 平移/3 收缩）
scoreboard objectives add note_c_seg dummy
# 玻璃 display_animation 分段（展示实体存储，glass/init·seg2 用）：note_g_seg = 当前段（1 到位/2 穿过后段）
scoreboard objectives add note_g_seg dummy
# 混凝土交互实体 1 刻解耦：note_prev_cx/cy/cz = 混凝土展示实体上一刻头端世界坐标（×100，y 已减 size/2）
scoreboard objectives add note_prev_cx dummy
scoreboard objectives add note_prev_cy dummy
scoreboard objectives add note_prev_cz dummy
# 玻璃扫掠段 1 刻退位：note_prev2_x/y/z = 展示实体"上上一刻"视觉中心（×100；move 每刻把旧 note_prev_* 滚过来）
#   ★ 玻璃判定早1刻修复（2026-08-08）：marker 扫掠段起点用 note_prev2_*、终点用 note_prev_* → 扫掠段=[P(T-2),P(T-1)] 对齐视觉路径
scoreboard objectives add note_prev2_x dummy
scoreboard objectives add note_prev2_y dummy
scoreboard objectives add note_prev2_z dummy
# 混凝土朝向四元数（展示实体存储，concrete_move 每 tick 写回 left_rotation 防插值拉偏）
scoreboard objectives add note_c_qx dummy
scoreboard objectives add note_c_qy dummy
scoreboard objectives add note_c_qz dummy
scoreboard objectives add note_c_qw dummy
# 混凝土缓动参数（展示实体存储，concrete_move 每 tick 应用 anim_easing/anim_power）
scoreboard objectives add note_c_easing dummy
scoreboard objectives add note_c_power dummy
# 混凝土段②客户端插值起点 tick（展示实体存储，seg2_client/seg2_merge 记录当前 #ct；concrete/tick 算交互实体段②进度用）
scoreboard objectives add note_c_seg2_s dummy
# 混凝土段①客户端插值起点 tick（展示实体存储，seg1_merge 记录当前 #ct；concrete/tick 算交互实体段①进度用）
scoreboard objectives add note_c_seg1_s dummy
# 混凝土段①客户端插值时长（展示实体存储，seg1_client 按模型算；concrete/tick 段②触发阈值 + 交互段①进度用）
scoreboard objectives add note_c_seg1_dur dummy
# 混凝土段①客户端插值延迟计数（展示实体存储，seg1_client 置 0；concrete/tick 每 tick +1，>=2 时 seg1_merge）
#   ★ 2026-09-05：seg1_s=4 与 seg1_dur=m-2 共同使 seg1_s+seg1_dur=m+2 → 段②到位=判定时刻（头端到位 s/2）
#     （曾试 >=4 使 seg1_s=6，导致头端晚 2 刻不到位、段③截断，故回退为 >=2）
scoreboard objectives add note_c_seg1_ticks dummy
# 混凝土判定状态（交互实体存储，M2-F 段落判定）
#   note_c_density = density；note_c_dur = duration；note_c_seg_done = 当前段是否已判；
#   note_c_seg_end = 当前段结束寿命；note_c_seg_idx = 当前段索引；note_c_done = 全部段完成
scoreboard objectives add note_c_density dummy
scoreboard objectives add note_c_dur dummy
scoreboard objectives add note_c_seg_done dummy
scoreboard objectives add note_c_seg_end dummy
scoreboard objectives add note_c_seg_idx dummy
scoreboard objectives add note_c_seg_count dummy
scoreboard objectives add note_c_done dummy
# 染色玻璃持续时长（交互实体存储，M2-G 出窗：寿命 + duration <= 0 → 清除）
scoreboard objectives add note_glass_dur dummy
# 判定反馈组号（交互实体存储，M2-H 查表：note_hitsound / note_hit_particles = 音效/粒子组编号）
scoreboard objectives add note_hitsound dummy
scoreboard objectives add note_hit_particles dummy
# 音符颜色（混凝土默认组3动态破坏粒子用；交互实体/编辑器展示实体存储，缺省 0）
scoreboard objectives add note_color dummy
# 延迟 spawn 反馈计数（交互实体存储，2026-08-29：出生提前 4 刻，spawn 事件延后 4 刻执行）
scoreboard objectives add note_spawn_delay dummy
# 音符是否已开始运动（tick 事件每刻执行标记，2026-08-29）
scoreboard objectives add note_moving dummy
# 混凝土移动参数计分板（注册完毕）

#====================设置====================
# 首次加载时初始化默认设置；之后 reload 保留玩家已保存的设置
scoreboard objectives add options dummy
execute unless score options_initialized const matches 1 run function rhythm_axe:options/reset_options
scoreboard players set options_initialized const 1

#====================gamerule======================

# 阻止JSON文本组件中点击含有run_command的组件后弹出确认弹窗，直接执行指令。
# 此gamerule来自rhythm_axe_mod
# gamerule rhythm_axe_mod:confirm_command false //先把这玩意注释掉免得我工作区老是挂着个报错...

gamerule block_drops false
gamerule mob_drops false
gamerule minecraft:advance_time false
gamerule advance_weather false
gamerule max_command_sequence_length 200000
#====================编辑器====================
# 编辑器运行时计分板（#playhead/#play_speed/#metronome/#history_cursor/#timeline_length 镜像 maps.editor）
scoreboard objectives add editor dummy
# 编辑器音符展示实体参数（visual/：place/tick 按实体读；每个字段一个 objective，与游玩 note_c_* 同模式）
scoreboard objectives add editor_n_birth dummy
scoreboard objectives add editor_n_time dummy
scoreboard objectives add editor_n_end dummy
scoreboard objectives add editor_n_dist dummy
scoreboard objectives add editor_n_type dummy
scoreboard objectives add editor_n_dur dummy
scoreboard objectives add editor_n_density dummy
scoreboard objectives add editor_n_lt dummy
scoreboard objectives add editor_n_easing dummy
scoreboard objectives add editor_n_power dummy
scoreboard objectives add editor_n_len dummy
scoreboard objectives add editor_n_seg dummy
scoreboard objectives add editor_n_seg_count dummy
scoreboard objectives add editor_n_size dummy
scoreboard objectives add editor_n_idx dummy
# 编辑器音符判定位置与起始偏移（place 算交互实体世界坐标用；×1000）
scoreboard objectives add editor_n_px dummy
scoreboard objectives add editor_n_py dummy
scoreboard objectives add editor_n_pz dummy
scoreboard objectives add editor_n_vx dummy
scoreboard objectives add editor_n_vy dummy
scoreboard objectives add editor_n_vz dummy
scoreboard objectives add editor_n_sx dummy
scoreboard objectives add editor_n_sy dummy
scoreboard objectives add editor_n_sz dummy
# 编辑器聊天栏点击通道（trigger 类型：点击 run_command 执行 /trigger 不弹确认窗）
scoreboard objectives add editor_click trigger
scoreboard players enable @a editor_click
# 编辑器音符交互实体点击检测（时间戳）用
scoreboard objectives add nc_last_right dummy
scoreboard objectives add nc_last_attack dummy
# 唱片机判定方式设置（0 无保护 / 1 均衡 / 2 激进）
scoreboard objectives add jukebox_judgement_mode dummy
scoreboard players set #jukebox_judgement_mode jukebox_judgement_mode 0
# 编辑器播放进度 bossbar（默认隐藏）
bossbar add rhythm_axe:editor_progress {"text":"播放进度"}
bossbar set rhythm_axe:editor_progress visible false
# 重进存档提示：编辑器状态持久化在命令存储，未正常退出时提醒
execute store result score #temp editor run data get storage rhythm_axe:maps.editor active
execute if score #temp editor matches 1 run function rhythm_axe:editor/load_notice

#====================残留实体清理（★ 修复 2026-08-08）====================
# reload 会重置 storage/计分板/schedule，但【不会清实体】。若 reload 前游戏进行中/未正常结束，
# 旧音符实体残留且带相同 tag（mapid_nid、note_display 等）→ 新游戏 summon 用 @e[tag=...,limit=1]
# 配对时可能选中旧实体 → 新音符未初始化（无 note_linear_pending/note_id）→ 停出生位置
#（用户实测：reload 后第一次游戏前两个音符停出生位置，不 reload 第二次正常）。
# reload 时清掉所有数据包音符实体，保证从干净状态开始。
# 所有音符相关实体（展示/交互/玻璃 marker/混凝土 zone marker）都带基础 tag "note"（summon 时打）→ 一条清全。
kill @e[tag=note]
# 清空 note_* 计分板残留计分项（scoreboard players reset *；reload 不清计分板项，残留只能靠此清空）
# ★ 已在上方注册 objective（dummy），reset * 通配所有名字（含已死亡/已卸载音符残留项）
function rhythm_axe:utilization/clear_note_scores
# ★ reload 的 clear_note_scores 用 reset * 会清掉【编辑器音符实体】的 note_id（展示↔交互配对计分板）。
#   编辑器实体带 tag=editor_note（非 note），不被上面的 kill 清除，但仍存活且靠 note_id 配对；
#   note_id 被清空后 place 无法移动交互实体（滞留召唤位置=混凝土判定位置）、tick_kill 无法按 id 清除交互实体。
#   若编辑器活跃，重建编辑器音符实体以恢复 note_id 配对（用当前播放头重新定位，位置不变）。
execute if data storage rhythm_axe:maps.editor {active:1b} run function rhythm_axe:editor/visual/refresh

tellraw @a [{"text":"[节奏地图] 数据包reload完成！","color":"green",bold:true}]