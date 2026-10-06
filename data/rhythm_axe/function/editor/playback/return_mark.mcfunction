# 跳回「记录点」——由 menu/playback_toggle 的播放→暂停分支调用
# 前置：maps.editor.record_head 存在（= 蹲下右键记录下的播放头刻数）
# ★ 2026-10-07：记录点是**持久**的 —— 本函数**不清除**它，每次暂停都可以跳回（删除走 playback/record_toggle）
#   跳回时发一行聊天栏提示（告诉玩家跳回哪儿、怎么清除）
execute store result score #mk_val editor run data get storage rhythm_axe:maps.editor record_head
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #mk_val editor
scoreboard players operation #playhead editor = #mk_val editor
# 同步播放进度 bossbar value（暂停状态下跳转需手动刷新）
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
# ★ 只移动播放头，不改音符 → 跳过 refresh 里的 selection 重建（省一整趟遍历）
data modify storage rhythm_axe:prop refresh_skip_sel set value 1b
function rhythm_axe:editor/refresh
execute if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/playback/resync
# 时间控件刷新一次播放进度 actionbar
function rhythm_axe:editor/visual/progress_actionbar
# 聊天栏提示：跳回了哪里 + 怎么清除记录点
tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"已经返回到记录点 ","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"gold"},{"text":"，在记录点处蹲下右键可以清除记录点","color":"green"}]
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 已跳回记录点（","color":"green"},{"score":{"name":"#playhead","objective":"editor"},"color":"aqua"},{"text":"刻）","color":"green"}]
