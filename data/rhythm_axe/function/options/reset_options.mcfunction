# ====================默认选项设置（仅首次加载 / 玩家主动重置时调用）====================
# 与文档「设置/全局设置」对齐
scoreboard objectives add options dummy
scoreboard objectives add score_calculate dummy

# 流速：音符的运动时间 = 基础寿命×16/流速
scoreboard players set note_speed options 16
# 判定反馈
scoreboard players set feedback_actionbar options 1
scoreboard players set feedback_chat options 1
scoreboard players set detailed_judgements options 1
# 伤害扣血冷却（刻）
scoreboard players set damage_cooldown options 10
# 歌曲进度条
scoreboard players set song_progress_display options 1
scoreboard players set song_progress_color options 0
# 编辑器
scoreboard players set editor_history_limit options 50
# 可视化时间轴（mod 屏幕覆盖层）开关：编辑器进入自动置 1、退出置 0；0=关 1=开
scoreboard players set editor_timeline_gui options 0
# 编辑器试听：播放中经过音符判定时间时是否执行击打事件（hit_events 自定义指令）；0=只播音效/粒子 1=同时执行指令
scoreboard players set editor_note_hitevents options 0
# 编辑器试听：播放中经过事件点时是否执行谱面事件（events[]）指令；0=不执行 1=执行
scoreboard players set editor_play_events options 0

# 判定的三级权重
scoreboard players set 1th_weight score_calculate 2
scoreboard players set 2nd_weight score_calculate 1
scoreboard players set 3rd_weight score_calculate 0

# 评级分数线
scoreboard players set SS options 100000
scoreboard players set S options 98000
scoreboard players set A options 94000
scoreboard players set B options 88000
scoreboard players set C options 80000
scoreboard players set Failed options 0

# 调试等级（0=关闭，1/2 逐级显示更多调试信息）
scoreboard players set debug_output options 0

tellraw @a [{"text":"设置已重置为初始状态！","color":"green",bold:true}]
