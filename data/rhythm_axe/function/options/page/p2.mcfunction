# 设置面板 · 页 2：编辑器设置（行 132~141；行 134/135/136/138/139 已废弃或挪走，留空）
# 风格：仿编辑器主菜单 —— 数值行 [-]值[+]，按钮可点=绿 / 到头=红；布尔行【开】绿 /【关】灰
# 值 = 行号×100 + 列码（列码 1 = −/切换、2 = ＋）；每行由 options/num_row、options/bool_row 生成
# 参数经 storage rhythm_axe:op_ui 传入（生成器是宏，见各自文件头注释）
# ⚠️ 分类名（分节线）固定放在**本页最后一个设置项之后、页脚之前**，见文件末尾。

# 行 132 编辑器试听真实判定（布尔）
data modify storage rhythm_axe:op_ui label set value "试听真实判定"
data modify storage rhythm_axe:op_ui key set value "editor_note_judge"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 13201
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 133 编辑器试听事件播放（布尔）
data modify storage rhythm_axe:op_ui label set value "试听事件播放"
data modify storage rhythm_axe:op_ui key set value "editor_play_events"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 13301
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# 行 134 【已废弃 2026-09-29】时间轴显示长度（editor_timeline_length）：该设置**从未被任何地方读取** ——
#   mod 时间轴的实际显示长度由客户端按屏幕宽度上报（ClientWindowPayload → TimelineSync.setWindowLen，
#   见 工具组件.md），所以整项移除（不显示、无分支）。行号留空、号段不重排。

# 行 135 【已移除 2026-09-29】每页事件数（editor_event_per_page）：事件列表代码里**写死每页 5 行**
#   （索引 = events_page×5 + 页内行），这个设置没有任何地方读取 ⇒ 整项移除。行号留空、号段不重排。

# 行 136 【已移除 2026-09-29】可视化时间轴开关（editor_timeline_gui）：它由编辑器流程自动管理
#   （init_state 置 1 / clear_state 置 0 / resume 置 1），面板里改了也会被覆盖 ⇒ 不再作为设置项。
#   计分项本身保留（mod 侧 TimelineSync 仍读它）。行号留空、号段不重排。

# 行 137 撤销历史上限（1..200，步 10；超出丢弃最旧快照）
data modify storage rhythm_axe:op_ui label set value "撤销历史上限"
data modify storage rhythm_axe:op_ui key set value "editor_history_limit"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value 1
data modify storage rhythm_axe:op_ui hi set value 200
data modify storage rhythm_axe:op_ui st set value 10
data modify storage rhythm_axe:op_ui blo set value 13701
data modify storage rhythm_axe:op_ui bhi set value 13702
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 138/139 【已合并挪走 2026-09-29】编辑器音乐自动对齐 / 游玩音乐自动对齐
#   → 合并为一个设置「音乐自动对齐游戏」（audio_align，默认开），现位于**页 3 高级**（行 153）。
#   行号留空、号段不重排。

# 行 140 音乐同步偏移（-500..500 ms，步 5；语义 = 0.25x 下所需补偿）
data modify storage rhythm_axe:op_ui label set value "音乐同步偏移（ms）"
data modify storage rhythm_axe:op_ui key set value "audio_sync_offset"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui lo set value -500
data modify storage rhythm_axe:op_ui hi set value 500
data modify storage rhythm_axe:op_ui st set value 5
data modify storage rhythm_axe:op_ui blo set value 14001
data modify storage rhythm_axe:op_ui bhi set value 14002
function rhythm_axe:options/num_row with storage rhythm_axe:op_ui

# 行 141 多人判定延迟补偿（布尔；⏸ 已搁置，reload 会被强制置 0）
data modify storage rhythm_axe:op_ui label set value "多人判定延迟补偿（已搁置）"
data modify storage rhythm_axe:op_ui key set value "judge_lag_comp"
data modify storage rhythm_axe:op_ui obj set value "options"
data modify storage rhythm_axe:op_ui blo set value 14101
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# —— 分类名（分节线；页尾，紧接在页脚之前）——
tellraw @s [{"text":"───────── 编辑器 ─────────","color":"dark_gray"}]
