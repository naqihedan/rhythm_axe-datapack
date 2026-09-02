# 线性运动初始化（@s = 展示实体；summon 线性分支调用）
# ===== 统一模型（普通 0/1/2 + 玻璃 4，纯线性 easing=1 power=1）=====
# 点沿直线从局部 z=-dist 运动到 +end（×100 尺度）：
#   普通：end=0（到位 = 判定位置）
#   玻璃：end=dist×dur/lt（穿过判定位置继续向前 dur 刻，最后停在与玻璃同时出窗处）
# 插值时长 D（note_lin_dur）：普通=lt-2、玻璃=lt+dur-2
#   ★ 2026-08-14 修订：出生→终点隔 2 tick 且插值时钟从终点到达时才开始——
#     补偿"客户端渲染延迟 1 刻 + 出生→终点间隔 1 刻"，普通视觉到位=time；玻璃过判定位置≈time
#   ★ 服务器交互同步用 note_lin_dur=D → 客户端与服务器速度一致（无"速度不一致"）
# 全局输入（summon 已算好）：
#   #m_dur display_calc = D（插值时长）
#   #m_end display_calc = end×100
#   #m_sz_end display_calc = scale.z 终点×100（混凝土=长条满长 len1；普通/玻璃=0 不写 scale）
# 实体已有：note_c_dist（dist×100）、note_c_sx/sy/sz（start×100）、note_c_lt（note_base_life）
# 本函数做的事：
#   1. 记录 D / end / scale 终点 / 进度（服务器用公式算交互位置；客户端插值只驱动视觉）
#   2. ★ 2026-08-14 起不再预置客户端插值参数：参数（duration=D、start=0）改由 motion/start
#      与终点【同一刻】下发（wiki：同刻多次变更计为单个变更）——
#      插值时钟从终点到达时才开始，出生→终点之间实体静止在起点，无"参数先到终点后到"的前跳。
#   3. 打 pending：active_note 用计数模式（note_active 0→1→2→3，每 tick +1，到 3 才由 ① 消费）→ 出生→终点真正隔 3 tick（见 active_note）
scoreboard players operation @s note_lin_dur = #m_dur display_calc
scoreboard players operation @s note_lin_end = #m_end display_calc
scoreboard players operation @s note_lin_sz_end = #m_sz_end display_calc
scoreboard players set @s note_lin_t 0
# 出生 tick 不递减（与交互实体 note_active 同步；线性展示实体由 motion 自己管理 active）
scoreboard players set @s note_active 0
# 打 pending（active_note 计数到 3 后消费 → motion/start 一次性下发 参数+终点）
tag @s add note_linear_pending
