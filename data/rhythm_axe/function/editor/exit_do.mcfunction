# 执行退出：停试听、复位 tick rate、移除编辑标签、清空状态、清编辑器音符实体、提示
# ★ 播放中退出：必须停音乐 + 复位 tick rate（放在 clear_state 之前、editor_active 还在时）
#   2026-09-19 补——此前会残留继续播放的音乐与缩放后的 tick rate；四条退出路径都走本文件
#   （暂停时的 tick rate 复位由 playback/pause 负责）
execute as @a[tag=editor_active] run function rhythm_axe:editor/coop/leave_core
tag @a remove editor_select_owner
tick rate 20
bossbar set rhythm_axe:editor_progress visible false
# ★ 2026-09-20：kill 前先清 editor_n_* 计分项（kill 不清计分板项，否则每次退出都残留一整套，详见 note_scores_reset_）
execute as @e[tag=editor_note] run function rhythm_axe:editor/visual/note_scores_reset_
kill @e[tag=editor_note]
kill @e[tag=editor_guide]
kill @e[tag=editor_tool_cursor]
kill @e[tag=editor_tool_glow]
kill @e[tag=editor_tool_select_glow]
advancement revoke @s only rhythm_axe:editor/tool_use
advancement revoke @s only rhythm_axe:editor/note_click
advancement revoke @s only rhythm_axe:editor/note_deselect
tag @s remove editor_active
function rhythm_axe:editor/clear_state
tellraw @s [{"text":"[编辑器] 已退出编辑器","color":"yellow"}]
