# 播放中每刻：1) 从游标 #vis_next 起生成新出生音符 2) 已有实体更新位置 / 消失清理 / 击打触发
# 3) 事件点触发（editor_play_events=1 时；游标 #vis_event，以编辑玩家为执行者）
# 前置：advance_ 已把 playhead +1 并同步 #playhead；本函数仅播放中调用
# 1) 新出生检查（游标从 #vis_next 起；按 time 序推进，遇到第一个未出生即停）
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_next editor
function rhythm_axe:editor/visual/tick_birth_note_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop note_idx
data remove storage rhythm_axe:prop cursor
# 2) 已有实体：更新位置 + 消失/未出生清理 + 击打触发（实体驱动）
# ★ at @s：把执行位置设到展示实体坐标（=判定位置），与游玩系统 as @e[...] at @s 一致
#   否则 trigger_ → play_sound/play_particle 的 ~ ~ ~ 停留在 tick 调用位置（世界原点），音效/粒子播错位置
execute as @e[type=item_display,tag=editor_note] at @s run function rhythm_axe:editor/visual/tick_one
execute as @e[tag=editor_guide,type=item_display] run function rhythm_axe:editor/visual/guide_tick
# 3) 事件点触发（仅播放中经过；跳转不触发）
execute if score editor_play_events options matches 1 run execute as @a[tag=editor_active] at @s run function rhythm_axe:editor/visual/tick_event
# 4) 播放进度 actionbar（播放每 tick 刷新）
function rhythm_axe:editor/visual/progress_actionbar
