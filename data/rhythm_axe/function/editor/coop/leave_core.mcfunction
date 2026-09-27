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
# ★ 2026-09-27：退出编辑器（含被踢出协作）**不再收回**编辑器工具 —— 工具留在背包里。
#   重新进入编辑器时 give_*_tool 会覆盖刷新，所以不会留「过期工具」；
#   安全性：tool/use 开头有 `unless data storage rhythm_axe:maps.editor active run return fail`，
#   非编辑状态下拿着工具点右键会被直接忽略，不会误触发任何操作。
#   如需恢复「收回」行为：删掉下面 11 行行首的 `#off ` 即可。
#off execute if items entity @s container.0 *[custom_data~{editor_tool:true}] run item replace entity @s container.0 with air
#off execute if items entity @s container.1 *[custom_data~{editor_tool:true}] run item replace entity @s container.1 with air
#off execute if items entity @s container.2 *[custom_data~{editor_tool:true}] run item replace entity @s container.2 with air
#off execute if items entity @s container.3 *[custom_data~{editor_tool:true}] run item replace entity @s container.3 with air
#off execute if items entity @s container.4 *[custom_data~{editor_tool:true}] run item replace entity @s container.4 with air
#off execute if items entity @s container.5 *[custom_data~{editor_tool:true}] run item replace entity @s container.5 with air
#off execute if items entity @s container.6 *[custom_data~{editor_tool:true}] run item replace entity @s container.6 with air
#off execute if items entity @s container.7 *[custom_data~{editor_tool:true}] run item replace entity @s container.7 with air
#off execute if items entity @s container.8 *[custom_data~{editor_tool:true}] run item replace entity @s container.8 with air
#off execute if items entity @s container.9 *[custom_data~{editor_tool:true}] run item replace entity @s container.9 with air
#off execute if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run item replace entity @s weapon.offhand with air
# 停他自己的试听音乐（不动别人）
stopmusic @s
