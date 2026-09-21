# 编辑器真实判定：文字反馈（@s = 编辑器音符展示实体；#ed_disp = 0..7，7 = DAMAGE 玻璃撞人）
# ★ 文案/颜色/结构严格照抄游玩 play/judgement_feedback/*.mcfunction：
#     actionbar = 「(血量 红bold)」+ 等级段 + 「(连击 白bold)」，等级段 bad=dark_aqua / goodE=green /
#     perfectE=yellow / perfect=gold / perfectL=yellow / goodL=green / miss=gray / damage=红色 -1 ❤；
#     聊天栏 = 单段（含箭头），颜色同上。
# ★ 虚拟血量/连击（#ed_health / #ed_combo，editor 计分板假玩家）：
#     每次开始播放由 playback/play_ 回满血量、连击归零；本函数按 #ed_disp 更新（good/perfect 各档连击 +1，
#     bad/miss 连击归零，damage 扣 1 血）。编辑器不碰 play_state 的真实成绩。
# 受 options 控制（与游玩同一对开关）：feedback_actionbar=1 → actionbar；feedback_chat=1 → 聊天栏

# ===== 虚拟连击 / 血量更新（按判定档位；先更新再输出，玩家看到的是更新后的值）=====
execute if score #ed_disp editor matches 1..5 run scoreboard players add #ed_combo editor 1
execute if score #ed_disp editor matches 0 run scoreboard players set #ed_combo editor 0
execute if score #ed_disp editor matches 6 run scoreboard players set #ed_combo editor 0
execute if score #ed_disp editor matches 7 if score #ed_health editor matches 1.. run scoreboard players remove #ed_health editor 1

execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 0 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *  <BAD   *  ","color":"dark_aqua"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 1 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *  <GOOD   *  ","color":"green"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 2 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *  <PERFECT   *  ","color":"yellow"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 3 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *   PERFECT   *  ","color":"gold"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 4 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *   PERFECT>  *  ","color":"yellow"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 5 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *   GOOD>  *  ","color":"green"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 6 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *   MISS>  *  ","color":"gray"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_actionbar options matches 1 if score #ed_disp editor matches 7 run title @a[tag=editor_active] actionbar [{"text":"(","color":"red"},{"score":{"objective":"editor","name":"#ed_health"},"color":"red","bold":true},{"text":")","color":"red","bold":true},{"text":"  *    -1 ❤    *  ","color":"red"},{"text":"(","color":"white","bold":true},{"score":{"objective":"editor","name":"#ed_combo"},"color":"white","bold":true},{"text":")","color":"white","bold":true}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 0 run tellraw @a[tag=editor_active] [{"text":"*  Bad *  <","color":"dark_aqua"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 1 run tellraw @a[tag=editor_active] [{"text":"*  Good *  <","color":"green"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 2 run tellraw @a[tag=editor_active] [{"text":"*  Perfect *  <","color":"yellow"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 3 run tellraw @a[tag=editor_active] [{"text":"*  PERFECT *","color":"gold"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 4 run tellraw @a[tag=editor_active] [{"text":"*  Perfect *  >","color":"yellow"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 5 run tellraw @a[tag=editor_active] [{"text":"*  Good *  >","color":"green"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 6 run tellraw @a[tag=editor_active] [{"text":"*  Miss *  >","color":"gray"}]
execute if score feedback_chat options matches 1 if score #ed_disp editor matches 7 run tellraw @a[tag=editor_active] [{"text":"*   -1 ❤   *","color":"red"}]
# 用完清掉（防残留到下一次判定）
scoreboard players reset #ed_disp editor