# 打开/切换工具选项栏（面板 23）。@s = 玩家；#tool_group 已由 group.mcfunction 写入（1..7）。
#
# 面板栈规则（2026-10-06 用户定）：
#   · 当前不在工具面板(23)  → 记下"上一个非工具面板"(tool_panel_prev)，打开工具面板
#   · 已在工具面板(23) 且是**同一个工具** → 视作"再按一次" ⇒ 返回上一个非工具面板
#   · 已在工具面板(23) 但**换了工具** → 直接切内容（tool_panel_prev 不变）
#   · 连续开了多个工具面板后点【返回】→ 回到那个"上一个非工具面板"（不是上一个工具面板）
execute if score #tool_group editor matches 0 run return fail
scoreboard players set #tp_cur editor -1
execute store result score #tp_cur editor run data get storage rhythm_axe:maps.editor current_panel
scoreboard players set #tp_last editor -1
execute store result score #tp_last editor run data get storage rhythm_axe:maps.editor tool_panel_gid
# 同一个工具再次放进副手 ⇒ 返回
execute if score #tp_cur editor matches 23 if score #tp_last editor = #tool_group editor run return run function rhythm_axe:editor/tool/offhand/back
# 从"非工具面板"进入 ⇒ 记下上一个面板
execute unless score #tp_cur editor matches 23 run data modify storage rhythm_axe:maps.editor tool_panel_prev set from storage rhythm_axe:maps.editor current_panel
# 打开提示音（只在"真的打开/切换了面板"时响；"同一个工具再放 = 返回"上面已 return，不会响）
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.8 1.6
# 写入分组并渲染
execute store result storage rhythm_axe:maps.editor tool_panel_gid int 1 run scoreboard players get #tool_group editor
function rhythm_axe:editor/menu/tool/panel/tool_panel
