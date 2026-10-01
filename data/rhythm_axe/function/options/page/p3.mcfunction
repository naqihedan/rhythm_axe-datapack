# 设置面板 · 页 3：高级（行 142~153）
# 风格：仿编辑器主菜单 —— 数值行 [-]值[+]，按钮可点=绿 / 到头=红；布尔行【开】绿 /【关】灰
# 值 = 行号×100 + 列码（列码 1 = −、2 = ＋）；每行由 options/num_row 生成（参数经 storage rhythm_axe:op_ui 传入）
# ⚠️ 判定权重（1th/2nd/3rd_weight）在 score_calculate 计分板，其余在 options（由 obj 参数指定）。
# ⚠️ 分类名（分节线）固定放在**本页最后一个设置项之后、页脚之前**，见文件末尾。

# 行 142 调试等级（0..2，步 1；等级越高输出越多）
data modify storage rhythm_axe:op_ui label set value "调试等级"
data modify storage rhythm_axe:op_ui key set value "debug_output"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 2
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 14201
data modify storage rhythm_axe:op_ui bhi set value 14202
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 143 SS 评级分数线（0..100000，步 1000）
data modify storage rhythm_axe:op_ui label set value "SS 评级线"
data modify storage rhythm_axe:op_ui key set value "SS"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 100000
data modify storage rhythm_axe:op_ui st set value 1000
data modify storage rhythm_axe:op_ui blo set value 14301
data modify storage rhythm_axe:op_ui bhi set value 14302
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 144 S 评级分数线
data modify storage rhythm_axe:op_ui label set value "S 评级线"
data modify storage rhythm_axe:op_ui key set value "S"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 100000
data modify storage rhythm_axe:op_ui st set value 1000
data modify storage rhythm_axe:op_ui blo set value 14401
data modify storage rhythm_axe:op_ui bhi set value 14402
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 145 A 评级分数线
data modify storage rhythm_axe:op_ui label set value "A 评级线"
data modify storage rhythm_axe:op_ui key set value "A"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 100000
data modify storage rhythm_axe:op_ui st set value 1000
data modify storage rhythm_axe:op_ui blo set value 14501
data modify storage rhythm_axe:op_ui bhi set value 14502
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 146 B 评级分数线
data modify storage rhythm_axe:op_ui label set value "B 评级线"
data modify storage rhythm_axe:op_ui key set value "B"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 100000
data modify storage rhythm_axe:op_ui st set value 1000
data modify storage rhythm_axe:op_ui blo set value 14601
data modify storage rhythm_axe:op_ui bhi set value 14602
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 147 C 评级分数线
data modify storage rhythm_axe:op_ui label set value "C 评级线"
data modify storage rhythm_axe:op_ui key set value "C"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 100000
data modify storage rhythm_axe:op_ui st set value 1000
data modify storage rhythm_axe:op_ui blo set value 14701
data modify storage rhythm_axe:op_ui bhi set value 14702
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 148 Failed 评级分数线
data modify storage rhythm_axe:op_ui label set value "Failed 评级线"
data modify storage rhythm_axe:op_ui key set value "Failed"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 100000
data modify storage rhythm_axe:op_ui st set value 1000
data modify storage rhythm_axe:op_ui blo set value 14801
data modify storage rhythm_axe:op_ui bhi set value 14802
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 149 一级判定权重（score_calculate，0..10，步 1）
data modify storage rhythm_axe:op_ui label set value "一级判定权重"
data modify storage rhythm_axe:op_ui key set value "1th_weight"
data modify storage rhythm_axe:op_ui obj set value "score_calculate"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 10
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 14901
data modify storage rhythm_axe:op_ui bhi set value 14902
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 150 二级判定权重（score_calculate，0..10，步 1）
data modify storage rhythm_axe:op_ui label set value "二级判定权重"
data modify storage rhythm_axe:op_ui key set value "2nd_weight"
data modify storage rhythm_axe:op_ui obj set value "score_calculate"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 10
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 15001
data modify storage rhythm_axe:op_ui bhi set value 15002
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 151 三级判定权重（score_calculate，0..10，步 1）
data modify storage rhythm_axe:op_ui label set value "三级判定权重"
data modify storage rhythm_axe:op_ui key set value "3rd_weight"
data modify storage rhythm_axe:op_ui obj set value "score_calculate"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 10
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 15101
data modify storage rhythm_axe:op_ui bhi set value 15102
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 152 伤害扣血冷却（0..200 刻，步 1；2026-09-29 从页 0 行 131 挪来）
data modify storage rhythm_axe:op_ui label set value "伤害扣血冷却（刻）"
data modify storage rhythm_axe:op_ui key set value "damage_cooldown"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 0
data modify storage rhythm_axe:op_ui hi set value 200
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 15201
data modify storage rhythm_axe:op_ui bhi set value 15202
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 153 音乐自动对齐游戏（布尔，默认开；2026-09-29 由「编辑器音乐自动对齐」+「游玩音乐自动对齐」
#   合并而来 —— 一个开关同时管编辑器试听与正式游玩；mod 侧 MusicTime 读 options.audio_align）
data modify storage rhythm_axe:op_ui label set value "音乐自动对齐游戏"
data modify storage rhythm_axe:op_ui key set value "audio_align"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 15301
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# —— 分类名（分节线；页尾，紧接在页脚之前）——
tellraw @s [{"text":"───────── 高级 ─────────","color":"dark_gray"}]
