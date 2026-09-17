# resume_playback 的「下一刻重绘」版：本刻已经跑过重活（如 refresh 重建整表视觉），
# 面板渲染必须推到下一 tick，否则同刻会挤爆命令链（见 reload 说明 / AI常见问题「分刻政策」）。
# 守卫语义与 resume_playback 完全一致（只有面板 1/10 需要随播放状态重绘）。
scoreboard players reset #pb_panel editor
execute store result score #pb_panel editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #pb_panel editor matches 1 run schedule function rhythm_axe:editor/menu/resume_next 1t
execute if score #pb_panel editor matches 10 run schedule function rhythm_axe:editor/menu/resume_next 1t
execute unless data storage rhythm_axe:maps.editor current_panel run schedule function rhythm_axe:editor/menu/resume_next 1t
