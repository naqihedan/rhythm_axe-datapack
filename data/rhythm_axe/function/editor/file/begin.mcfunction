# 新操作开始：若当前不在历史末尾（撤销过），丢弃 cursor 之后的分支快照
# 截断条件：history 长度 > cursor + 1
execute store result score #history_size editor run data get storage rhythm_axe:maps.editor history
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
scoreboard players operation #temp editor = #temp_cursor editor
scoreboard players add #temp editor 1
execute if score #history_size editor > #temp editor run function rhythm_axe:editor/file/truncate
# 记录操作所在面板（撤销/重做后回此面板；每次操作覆盖，存的是最新操作发生时的面板）
# ★ 2026-08-28 优先用操作发起面板 editing.panel_from（设置面板打开时记录=从哪个列表来），
#   否则当前面板——撤销后回到按下按钮的那个面板（如时间点列表），而非操作完成时的设置面板
execute store result storage rhythm_axe:maps.editor undo_panel int 1 run data get storage rhythm_axe:maps.editor current_panel
execute if data storage rhythm_axe:maps.editor editing.panel_from run data modify storage rhythm_axe:maps.editor undo_panel set from storage rhythm_axe:maps.editor editing.panel_from
data remove storage rhythm_axe:maps.editor editing.panel_from
# ★ 2026-08-28 撤销污染修复：备份当前工作副本（history[-1]）到独立快照
#   操作会直接改写 history[-1]（= history[history_cursor]，末尾快照），commit 时先把它 append
#   为新快照，再从本备份恢复被污染的原快照 → 撤销回退到的快照保持干净、真正生效
data modify storage rhythm_axe:undo pre_snapshot set from storage rhythm_axe:maps.editor history[-1]
