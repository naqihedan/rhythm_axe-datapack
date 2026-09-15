# 一次性写入器：把 Lament Rain 20-6 过场（12 个事件点）写进【编辑器工作副本】
#   · 整段只在 history 里占 **一份** 快照 —— 对编辑器来说就是「一步操作」，
#     放在主菜单的【撤销】/ 操作反馈里的【撤销】都能一次整体回退。
#   · 只改工作副本，**不入档**：要在编辑器里执行【保存】才会写进 rhythm_axe:maps.lament_rain。
#
# 用法（游戏内，编辑器已打开 lament_rain）：
#   /function rhythm_axe:maps/lament_rain/cutscene/apply_editor
#
# 布局：3480 → 4536 刻，每 96 刻一句（96 刻 = 2 小节 = 2.4 秒 @BPM200/tpb12），共 12 句
#       第 8 句（line08，虔的『奴隶/奇迹』宣言）固定在 4248 刻 = 3480 + 96×8，即开战瞬间
#       第 9 句（line09，虔的『重生』宣言）在其前一格 4152 刻

# ── 0. 前置校验 ────────────────────────────────────────────────
execute unless data storage rhythm_axe:maps.editor {active:1b} run tellraw @a [{"text":"[过场] 编辑器未打开，未写入任何内容（请先进入 lament_rain 的编辑器）","color":"red"}]
execute unless data storage rhythm_axe:maps.editor {active:1b} run return fail
execute unless data storage rhythm_axe:maps.editor {mapid:"lament_rain"} run tellraw @a [{"text":"[过场] 编辑器当前编辑的不是 lament_rain，未写入任何内容","color":"red"}]
execute unless data storage rhythm_axe:maps.editor {mapid:"lament_rain"} run return fail

# ── 1. 同步 history 游标（#history_cursor 计分板镜像 + prop.cursor 宏参数）──
execute store result score #history_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:prop cursor

# ── 2. 事件清单（12 条，time = 3480 + 96k，k = 0..11）──────────
# ★ 第 8/9 句已对调刻位：4152 = line09（重生宣言）、4248 = line08（奴隶宣言，开战瞬间）
data modify storage rhythm_axe:prop lr_list set value [{time:3480,commands:["function rhythm_axe:maps/lament_rain/cutscene/line01"]},{time:3576,commands:["function rhythm_axe:maps/lament_rain/cutscene/line02"]},{time:3672,commands:["function rhythm_axe:maps/lament_rain/cutscene/line03"]},{time:3768,commands:["function rhythm_axe:maps/lament_rain/cutscene/line04"]},{time:3864,commands:["function rhythm_axe:maps/lament_rain/cutscene/line05"]},{time:3960,commands:["function rhythm_axe:maps/lament_rain/cutscene/line06"]},{time:4056,commands:["function rhythm_axe:maps/lament_rain/cutscene/line07"]},{time:4152,commands:["function rhythm_axe:maps/lament_rain/cutscene/line09"]},{time:4248,commands:["function rhythm_axe:maps/lament_rain/cutscene/line08"]},{time:4344,commands:["function rhythm_axe:maps/lament_rain/cutscene/line10"]},{time:4440,commands:["function rhythm_axe:maps/lament_rain/cutscene/line11"]},{time:4536,commands:["function rhythm_axe:maps/lament_rain/cutscene/line12"]}]

# ── 3. 一步操作 = 一份快照 ─────────────────────────────────────
function rhythm_axe:editor/file/begin
function rhythm_axe:maps/lament_rain/cutscene/apply_clear_old with storage rhythm_axe:prop
function rhythm_axe:maps/lament_rain/cutscene/apply_loop
data modify storage rhythm_axe:maps.editor op_label set value "添加 Lament Rain 过场（12 个事件点）"
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh

# ── 4. 反馈 + 界面刷新 ─────────────────────────────────────────
data modify storage rhythm_axe:maps.editor feedback set value "已添加 Lament Rain 过场（12 个事件点）"
tellraw @a [{"text":"[过场] 已向编辑器工作副本写入 12 个事件点：3480→4536 刻，每 96 刻一句（开战那句 line08 在 4248）。","color":"green"},{"text":"这是【一步操作】，可用【撤销】整体回退；要入档请在编辑器里执行【保存】。","color":"gray"}]
schedule function rhythm_axe:editor/menu/resume_next 1t

# ── 5. 清理 prop（键用后即删）──────────────────────────────────
data remove storage rhythm_axe:prop lr_list
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop commands
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop dup
data remove storage rhythm_axe:prop kind
