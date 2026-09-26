# 移出协作的**实际清理**（@s = 被移出者；不广播 —— 由 leave（踢出）与 exit_do（房主收工）共用）
# ★ 不碰全局会话状态（maps.editor / 工作副本 / 别人的面板）：只回收「这个人自己的东西」
tag @s remove editor_active
tag @s remove editor_host
tag @s remove editor_tool_was_sneak
tag @s remove editor_used_tool
tag @s remove editor_lock_holder
tag @s remove editor_select_owner
tag @s remove editor_tool_sneak_changed
scoreboard players reset @s editor_click
advancement revoke @s only rhythm_axe:editor/note_click
advancement revoke @s only rhythm_axe:editor/note_deselect
advancement revoke @s only rhythm_axe:editor/tool_use
# 收回编辑器工具（逐格判断 custom_data，只清我们发的，绝不动玩家自己的物品）
execute if items entity @s container.0 *[custom_data~{editor_tool:true}] run item replace entity @s container.0 with air
execute if items entity @s container.1 *[custom_data~{editor_tool:true}] run item replace entity @s container.1 with air
execute if items entity @s container.2 *[custom_data~{editor_tool:true}] run item replace entity @s container.2 with air
execute if items entity @s container.3 *[custom_data~{editor_tool:true}] run item replace entity @s container.3 with air
execute if items entity @s container.4 *[custom_data~{editor_tool:true}] run item replace entity @s container.4 with air
execute if items entity @s container.5 *[custom_data~{editor_tool:true}] run item replace entity @s container.5 with air
execute if items entity @s container.6 *[custom_data~{editor_tool:true}] run item replace entity @s container.6 with air
execute if items entity @s container.7 *[custom_data~{editor_tool:true}] run item replace entity @s container.7 with air
execute if items entity @s container.8 *[custom_data~{editor_tool:true}] run item replace entity @s container.8 with air
execute if items entity @s container.9 *[custom_data~{editor_tool:true}] run item replace entity @s container.9 with air
execute if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run item replace entity @s weapon.offhand with air
# 停他自己的试听音乐（不动别人）
stopmusic @s
