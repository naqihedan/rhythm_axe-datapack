# 执行退出：移除编辑标签、清空状态、清编辑器音符实体、提示
bossbar set rhythm_axe:editor_progress visible false
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
