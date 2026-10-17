# 设置面板 · 页 0：游玩设置（行 122~130；行 127 已废弃留空、行 131 已挪到页 3）
# 风格：仿编辑器主菜单 —— 数值行 [-]值[+]，按钮可点=绿 / 到头=红；布尔行【开】绿 /【关】灰
# 值 = 行号×100 + 列码（列码 1 = −/切换、2 = ＋）；每行由 options/num_row、options/bool_row 生成
# 参数经 storage rhythm_axe:op_ui 传入（生成器是宏，见各自文件头注释）
# ⚠️ 分类名（分节线）固定放在**本页最后一个设置项之后、页脚之前**，见文件末尾。

# 行 122 流速（1..100，步 1）
data modify storage rhythm_axe:op_ui label set value "流速"
data modify storage rhythm_axe:op_ui key set value "note_speed"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 1
data modify storage rhythm_axe:op_ui hi set value 100
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 12201
data modify storage rhythm_axe:op_ui bhi set value 12202
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 123 音符 hotbar 反馈（布尔）
data modify storage rhythm_axe:op_ui label set value "音符hotbar反馈"
data modify storage rhythm_axe:op_ui key set value "feedback_actionbar"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 12301
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 124 音符聊天反馈（布尔）
data modify storage rhythm_axe:op_ui label set value "音符聊天反馈"
data modify storage rhythm_axe:op_ui key set value "feedback_chat"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 12401
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 125 实验性挥砍动画（布尔；默认关。开 = 播自定义 item_model 挥砍动画，关 = 原版 /swing 挥手臂）
data modify storage rhythm_axe:op_ui label set value "实验性挥砍动画"
data modify storage rhythm_axe:op_ui key set value "swing_anim"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 12501
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 126 歌曲进度条显示（布尔；颜色是谱面级 progress_color，见编辑器「谱面设置」）
data modify storage rhythm_axe:op_ui label set value "歌曲进度条"
data modify storage rhythm_axe:op_ui key set value "song_progress_display"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 12601
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 127 全局音乐偏移（-500..500 ms；正=音乐延后、负=音乐提前，补偿设备输出延迟填负值）
#   ★ 2026-10-14 启用：原「进度条颜色」废弃后留空的行，现复用为 music_offset（行号不重排）。
#   五个按钮：12701=−5 / 12702=−1 / 12703=+1 / 12704=+5 / 12705=【输入数值】（对话框）
#   专用生成器 options/offset_row（num_row 只支持两档按钮），叶子 options/offset_emit
data modify storage rhythm_axe:op_ui label set value "全局音乐偏移"
data modify storage rhythm_axe:op_ui key set value "music_offset"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value -500
data modify storage rhythm_axe:op_ui hi set value 500
data modify storage rhythm_axe:op_ui b1 set value 12701
data modify storage rhythm_axe:op_ui b2 set value 12702
data modify storage rhythm_axe:op_ui b3 set value 12703
data modify storage rhythm_axe:op_ui b4 set value 12704
data modify storage rhythm_axe:op_ui b5 set value 12705
data modify storage rhythm_axe:op_ui b6 set value 12706
function rhythm_axe:options/offset_row with storage rhythm_axe:op_ui

# 行 128 结算详细判定（布尔）
data modify storage rhythm_axe:op_ui label set value "结算详细判定"
data modify storage rhythm_axe:op_ui key set value "detailed_judgements"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 12801
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 129 全局击打音效组（1..6，步 1；音符 hitsound=0 时使用）
data modify storage rhythm_axe:op_ui label set value "全局击打音效组"
data modify storage rhythm_axe:op_ui key set value "note_hitsound"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 1
data modify storage rhythm_axe:op_ui hi set value 6
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 12901
data modify storage rhythm_axe:op_ui bhi set value 12902
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 130 全局击打粒子组（1..6，步 1；音符 hit_particles=0 时使用）
data modify storage rhythm_axe:op_ui label set value "全局击打粒子组"
data modify storage rhythm_axe:op_ui key set value "note_particle"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 1
data modify storage rhythm_axe:op_ui hi set value 6
data modify storage rhythm_axe:op_ui st set value 1
data modify storage rhythm_axe:op_ui blo set value 13001
data modify storage rhythm_axe:op_ui bhi set value 13002
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 131 音符击打音效开关（布尔；1=开 0=关。关时音符判定/生成不播音效，粒子与事件不受影响）
#   ★ 2026-10-17 启用：原「伤害扣血冷却」2026-09-29 挪到页 3 行 152 后留空的行，现复用（行号不重排）
data modify storage rhythm_axe:op_ui label set value "音符击打音效"
data modify storage rhythm_axe:op_ui key set value "hitsound_on"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 13101
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# —— 分类名（分节线；页尾，紧接在页脚之前）——
tellraw @s [{"text":"───────── 游玩 ─────────","color":"dark_gray"}]
