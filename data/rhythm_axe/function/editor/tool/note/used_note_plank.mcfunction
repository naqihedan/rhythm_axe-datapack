# 木板工具右键：返还物品（主手/副手）+ 设音符类型(1) + 放置音符（@s=玩家）
# 主手返还（沿用槽内物品原身份重建；state=-1 → 下一 tick 由 tool_note_update 按实际蹲下状态重绘外观）
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/note/return_main
# 副手返还（主手无工具时，沿用槽内物品原身份重建）
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] if items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run function rhythm_axe:editor/tool/note/return_off
# 设置音符类型并放置
function rhythm_axe:editor/tool/note/place {note_type:1}
